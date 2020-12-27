//
//  SKTestProxy.m
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

#import "SKTestProxy.h"

@implementation SKTestProxy

- (SKTestProxy *) init {
    self = [super init];
    self.testKey = TEST_KEY_PROXY;
    return self;
}

- (void) run:(void (^)(SKTestResult * _Nonnull))finished {
    CFDictionaryRef proxySettings = CFNetworkCopySystemProxySettings();
    const CFStringRef proxyCFString = (const CFStringRef)CFDictionaryGetValue(proxySettings, (const void*)kCFNetworkProxiesHTTPProxy);
    NSString * proxyString = (__bridge NSString *)(proxyCFString);

    if (proxyString != nil && proxyString.length > 0) {
        finished([SKTestResult failResultWithDescriptionKey:@"test_proxy_enabled"]);
        return;
    }

    finished([SKTestResult failResultWithDescriptionKey:@"test_proxy_not_found"]);
}

@end
