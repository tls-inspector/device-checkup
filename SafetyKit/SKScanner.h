//
//  SKScanner.h
//  SafetyKit
//
//  Created by Ian Spence on 2020-12-24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SKScannerDelegate

- (void) test:(SKTest * _Nonnull)test finishedWithResult:(SKTestResult * _Nonnull)result;
- (void) scannerFinishedAllTests;

@optional

- (void) scannerDidStart;
- (void) scannerDidStartTest:(SKTest * _Nonnull)test;

@end

@interface SKScanner : NSObject

@property (strong, nonatomic, nonnull) id<SKScannerDelegate> delegate;

+ (SKScanner * _Nonnull) withDelegate:(id<SKScannerDelegate> _Nonnull)delegate;
- (void) start;

@end

NS_ASSUME_NONNULL_END
