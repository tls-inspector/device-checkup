//
//  SKTest.h
//  SafetyKit
//
//  Created by Ian Spence on 2020-12-24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKTest : NSObject

@property (strong, nonatomic, nonnull) id delegate;
@property (strong, nonatomic, nonnull) NSString * testKey;
- (void) start;

@end

@protocol SKTestTask

- (void) test:(SKTest * _Nonnull)test didFinishWithResult:(SKTestResult * _Nonnull)result;

@end

NS_ASSUME_NONNULL_END
