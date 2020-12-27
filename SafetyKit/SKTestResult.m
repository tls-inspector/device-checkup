//
//  SKTestResult.m
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

#import "SKTestResult.h"

@implementation SKTestResult

+ (SKTestResult * _Nonnull) failResultWithDescriptionKey:(NSString * _Nonnull)descriptionKey {
    SKTestResult * result = [SKTestResult new];
    result.resultType = RESULT_TYPE_FAIL;
    result.localizedDescriptionKey = descriptionKey;
    return result;
}

+ (SKTestResult * _Nonnull) warnResultWithDescriptionKey:(NSString * _Nonnull)descriptionKey {
    SKTestResult * result = [SKTestResult new];
    result.resultType = RESULT_TYPE_WARN;
    result.localizedDescriptionKey = descriptionKey;
    return result;
}

+ (SKTestResult * _Nonnull) passResultWithDescriptionKey:(NSString * _Nullable)descriptionKey {
    SKTestResult * result = [SKTestResult new];
    result.resultType = RESULT_TYPE_PASS;
    result.localizedDescriptionKey = descriptionKey;
    return result;
}

+ (SKTestResult * _Nonnull) unknownResult {
    SKTestResult * result = [SKTestResult new];
    result.resultType = RESULT_TYPE_UNKNOWN;
    return result;
}

+ (SKTestResult * _Nonnull) errorResult:(NSError * _Nonnull)error {
    SKTestResult * result = [SKTestResult new];
    result.resultType = RESULT_TYPE_ERROR;
    result.error = error;
    return result;
}

- (NSString *) description {
    NSString * state = @"";
    switch (self.resultType) {
        case RESULT_TYPE_FAIL:
            state = @"FAIL";
            break;
        case RESULT_TYPE_WARN:
            state = @"WARN";
            break;
        case RESULT_TYPE_PASS:
            state = @"PASS";
            break;
        case RESULT_TYPE_UNKNOWN:
            state = @"UNKNOWN";
            break;
        case RESULT_TYPE_ERROR:
            state = @"ERROR";
            break;
    }
    return [[NSString alloc] initWithFormat:@"%@ - %@", state, self.localizedDescriptionKey];
}

@end
