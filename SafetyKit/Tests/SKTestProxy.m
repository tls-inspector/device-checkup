//
//  SKTestProxy.m
//  SafetyKit
//
//  Created by Ian Spence on 2020-12-24.
//

#import "SKTestProxy.h"

@implementation SKTestProxy

- (void) start {
    CFDictionaryRef proxySettings = CFNetworkCopySystemProxySettings();
    const CFStringRef proxyCFString = (const CFStringRef)CFDictionaryGetValue(proxySettings, (const void*)kCFNetworkProxiesHTTPProxy);
    NSString * proxyString = (__bridge NSString *)(proxyCFString);

    if (proxyString != nil && proxyString.length > 0) {
        [self.delegate test:self finishedWithResult:[SKTestResult failResultWithDescriptionKey:@"test_proxy_enabled"]];
        return;
    }

    [self.delegate test:self finishedWithResult:[SKTestResult failResultWithDescriptionKey:@"test_proxy_not_found"]];
}

@end
