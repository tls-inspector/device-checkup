//
//  SKScanner.m
//  SafetyKit
//
//  Created by Ian Spence on 2020-12-24.
//

#import "SKScanner.h"

@implementation SKScanner

+ (SKScanner * _Nonnull) withDelegate:(id<SKScannerDelegate> _Nonnull)delegate {
    SKScanner * scanner = [SKScanner new];
    scanner.delegate = delegate;
    return scanner;
}

- (void) start {
    NSArray<SKTest *> * tests = @[];
    for (SKTest * test in tests) {

    }
}

@end
