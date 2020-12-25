//
//  SKTestResult.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKTestResult : NSObject

/**
 Options that define the result of the Test
 */
typedef enum __RESULT_TYPE {
    /// An error occurred during the Test
    RESULT_TYPE_ERROR = -1,
    /// The Test returned an unknown result
    RESULT_TYPE_UNKNOWN = 0,
    /// The Test returned the expected, safe result
    RESULT_TYPE_PASS = 1,
    /// The Test returned a potentially incorrect result
    RESULT_TYPE_WARN = 2,
    /// The Test returned an indicator of compromise
    RESULT_TYPE_FAIL = 3,
} RESULT_TYPE;

/**
 The overall status of the Test
 */
@property (nonatomic) RESULT_TYPE resultType;

/**
 A localization key that can be used to describe the result
 */
@property (strong, nonatomic, nullable) NSString * localizedDescriptionKey;

/**
 The error that failed the Test
 */
@property (strong, nonatomic, nullable) NSError * error;

+ (SKTestResult * _Nonnull) failResultWithDescriptionKey:(NSString * _Nonnull)descriptionKey;
+ (SKTestResult * _Nonnull) warnResultWithDescriptionKey:(NSString * _Nonnull)descriptionKey;
+ (SKTestResult * _Nonnull) passResultWithDescriptionKey:(NSString * _Nullable)descriptionKey;
+ (SKTestResult * _Nonnull) unknownResult;
+ (SKTestResult * _Nonnull) errorResult:(NSError * _Nonnull)error;

@end

NS_ASSUME_NONNULL_END
