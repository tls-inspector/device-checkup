//
//  SKScanner.m
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

#import "SKScanner.h"

@interface SKScanner ()

@property (strong, nonatomic, nonnull) NSArray<SKTest *> * tests;
@property (nonatomic) int currentTestIdx;

@end

@implementation SKScanner

+ (SKScanner * _Nonnull) withDelegate:(id<SKScannerDelegate> _Nonnull)delegate {
    SKScanner * scanner = [SKScanner new];
    scanner.delegate = delegate;
    scanner.tests = @[
        [SKTestProxy new],
        [SKTestCertificateTrust new],
    ];
    scanner.currentTestIdx = -1;
    return scanner;
}

- (void) start {
    [self.delegate scannerDidStart];
    [self runNextText];
}

- (void) runNextText {
    self.currentTestIdx++;

    if (self.currentTestIdx >= self.tests.count) {
        [self.delegate scannerFinishedAllTests];
        return;
    }

    SKTest * nextTest = self.tests[self.currentTestIdx];
    [self.delegate scannerDidStartTest:nextTest];
    [nextTest run:^(SKTestResult * result) {
        [self.delegate test:nextTest finishedWithResult:result];
        [self runNextText];
    }];
}

@end
