//
//  SKTestJailbreak.m
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

#import "SKTestJailbreak.h"

@implementation SKTestJailbreak

- (SKTestJailbreak *) init {
    self = [super init];
    self.testKey = TEST_KEY_IS_JAILBROKEN;
    return self;
}

- (void) run:(void (^)(SKTestResult * _Nonnull))finished {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self tryCheckJailbreak]) {
            finished([SKTestResult failResultWithDescriptionKey:@"test_is_jailbroken_true"]);
            return;
        }

        finished([SKTestResult passResultWithDescriptionKey:@"test_is_jailbroken_false"]);
    });
}

/**
 Try some common ways to detect jailbroken devices.

 These aren't exhaustive, and can be easily worked around with exsiting packages - however the ability to detect a jailbroken iOS device
 will always be a game of cat-and-mouse because, well, jailbroken devices modify much more aspects of the system that can be impossible
 for a normal app to detect.
 */
- (BOOL) tryCheckJailbreak {
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:@"/Applications/Cydia.app"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
        return YES;
    }

    // Check if the app can access outside of its sandbox
    NSError *error = nil;
    NSString *string = @".";
    [string writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        [fileManager removeItemAtPath:@"/private/jailbreak.txt" error:nil];
        return YES;
    }

    // Check if the app can open a Cydia's URL scheme
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
        return YES;
    }

    return NO;
}

@end
