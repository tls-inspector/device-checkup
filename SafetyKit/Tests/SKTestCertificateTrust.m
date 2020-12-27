//
//  SKTestCertificateTrust.m
//
//  LGPLv3
//
//  Copyright (c) 2021 Ian Spence
//  https://tlsinspector.com/github.html
//
//  This library is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This library is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser Public License for more details.
//
//  You should have received a copy of the GNU Lesser Public License
//  along with this library.  If not, see <https://www.gnu.org/licenses/>.

#import "SKTestCertificateTrust.h"
@import Network;

@implementation SKTestCertificateTrust

- (SKTestCertificateTrust *) init {
    self = [super init];
    self.testKey = TEST_KEY_CERTIFICATE_TRUST;
    return self;
}

- (void) run:(void (^)(SKTestResult * _Nonnull))finished API_AVAILABLE(ios(12.0)) {
    nw_endpoint_t endpoint = nw_endpoint_create_host("appleid.apple.com", "443");
    dispatch_queue_t nw_dispatch_queue = dispatch_queue_create("com.tlsinspector.SafetyKit", NULL);

    nw_parameters_configure_protocol_block_t configure_tls = ^(nw_protocol_options_t tls_options) {
        sec_protocol_options_t sec_options = nw_tls_copy_sec_protocol_options(tls_options);
        sec_protocol_options_set_verify_block(sec_options, ^(sec_protocol_metadata_t  _Nonnull metadata, sec_trust_t  _Nonnull trust_ref, sec_protocol_verify_complete_t  _Nonnull complete) {
            SecTrustRef trust = sec_trust_copy_ref(trust_ref);
            SecTrustResultType trustStatus;
            SecTrustEvaluate(trust, &trustStatus);

            if (trustStatus == kSecTrustResultUnspecified) {
                finished([SKTestResult passResultWithDescriptionKey:@"test_certificate_trust_valid"]);
            } else if (trustStatus == kSecTrustResultProceed) {
                finished([SKTestResult failResultWithDescriptionKey:@"test_certificate_trust_local"]);
            } else {
                finished([SKTestResult failResultWithDescriptionKey:@"test_certificate_trust_invalid"]);
            }

            complete(true);
        }, nw_dispatch_queue);
    };

    nw_parameters_t parameters = nw_parameters_create_secure_tcp(configure_tls, NW_PARAMETERS_DEFAULT_CONFIGURATION);
    nw_connection_t connection = nw_connection_create(endpoint, parameters);
    nw_connection_set_queue(connection, nw_dispatch_queue);
    nw_connection_set_state_changed_handler(connection, ^(nw_connection_state_t state, nw_error_t error) {
        switch (state) {
            case nw_connection_state_ready:
                PDebug(@"Event: nw_connection_state_ready");
                nw_connection_cancel(connection);
                PDebug(@"Cancelling connection - goodbye!");
                break;
            case nw_connection_state_failed:
                PDebug(@"Event: nw_connection_state_failed");
                PError(@"nw_connection failed: %@", error.description);
                finished([SKTestResult errorResult:error.debugDescription]);
                break;
            default:
                break;
        }
    });
    nw_connection_start(connection);
}

@end
