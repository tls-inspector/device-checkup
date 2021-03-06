//
//  SafetyKit.h
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

#import <UIKit/UIKit.h>

//! Project version number for SafetyKit.
FOUNDATION_EXPORT double SafetyKitVersionNumber;

//! Project version string for SafetyKit.
FOUNDATION_EXPORT const unsigned char SafetyKitVersionString[];

#import <SafetyKit/SKLogging.h>
#import <SafetyKit/SKTestResult.h>
#import <SafetyKit/SKTest.h>
#import <SafetyKit/SKTestProxy.h>
#import <SafetyKit/SKTestCertificateTrust.h>
#import <SafetyKit/SKTestLocalAuthentication.h>
#import <SafetyKit/SKTestJailbreak.h>
#import <SafetyKit/SKScanner.h>

/**
 Interface for global SafetyKit methods.
 */
@interface SafetyKit : NSObject

@end
