//
//  SKTestLocalAuthentication.h
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

#import "SKTestLocalAuthentication.h"
@import LocalAuthentication;

@implementation SKTestLocalAuthentication

- (SKTestLocalAuthentication *) init {
    self = [super init];
    self.testKey = TEST_KEY_LOCAL_AUTHENTICATION;
    return self;
}

- (void) run:(void (^)(SKTestResult * _Nonnull))finished {
    LAContext * context = [LAContext new];

    // Check if touchid/faceid are supported
    BOOL biometricSupported = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    if (biometricSupported) {
        finished([SKTestResult passResultWithDescriptionKey:@"test_local_authentication_has_biometric"]);
        return;
    }

    // Check if a passcode is configured
    BOOL passcodeSupported = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:nil];
    if (!passcodeSupported) {
        finished([SKTestResult failResultWithDescriptionKey:@"test_local_authentication_no_passcode"]);
        return;
    }

    finished([SKTestResult passResultWithDescriptionKey:@"test_local_authentication_has_passcode"]);
}

@end
