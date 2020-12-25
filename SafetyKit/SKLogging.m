//
//  SKLogging.m
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

#import "SKLogging.h"

#include <mach/mach.h>
#include <mach/mach_time.h>

@interface SKLogging ()

@property (strong, nonatomic) NSFileHandle * handle;

@end

static id _instance;
static dispatch_queue_t queue;

@implementation SKLogging

+ (SKLogging *) sharedInstance {
    if (!_instance) {
        _instance = [SKLogging new];
    }
    return _instance;
}

- (id) init {
    if (_instance == nil) {
        _instance = [[SKLogging alloc] initWithLogFile:@"SafetyKit.log"];
    }
    return _instance;
}

- (id) initWithLogFile:(NSString *)file {
    self = [super init];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    self.file = [documentsDirectory stringByAppendingPathComponent:file];
    [self createQueue];
    [self open];
    self.level = SKLoggingLevelWarning;
    return self;
}

- (void) createQueue {
    if (!queue) {
        queue = dispatch_queue_create("com.tlsinspector.SafetyKit.SKLogging", NULL);
    }
}

- (void) open {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillTerminate:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];

    if (![[NSFileManager defaultManager] fileExistsAtPath:self.file]) {
        [[NSFileManager defaultManager] createFileAtPath:self.file contents:nil attributes:nil];
    }

    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.file];
    [self.handle seekToEndOfFile];
}

- (void) appWillTerminate:(NSNotification *)n {
    [self close];
}

- (void) close {
    [self.handle closeFile];
}

- (NSString *) stringForLevel:(SKLoggingLevel)level {
    switch (level) {
        case SKLoggingLevelDebug:
            return @"DEBUG";
        case SKLoggingLevelInfo:
            return @"INFO ";
        case SKLoggingLevelError:
            return @"ERROR";
        case SKLoggingLevelWarning:
            return @"WARN ";
    }
}

- (void) write:(NSString *)string forLevel:(SKLoggingLevel)level {
    NSString * thread = [NSThread currentThread].description;
    dispatch_async(queue, ^{
        NSString * writeString = [NSString stringWithFormat:@"[%@][%ld][%@] %@",
                                  [self stringForLevel:level], time(0), thread, string];
        [self.handle writeData:[writeString dataUsingEncoding:NSUTF8StringEncoding]];
        printf("%s", [writeString UTF8String]);
    });
}

- (void) writeLine:(NSString *)string forLevel:(SKLoggingLevel)level {
    if (self.level <= level) {
        [self write:[NSString stringWithFormat:@"%@\n", string] forLevel:level];
    }
}

- (void) writeDebug:(NSString *)message {
    [self writeLine:message forLevel:SKLoggingLevelDebug];
}

- (void) writeInfo:(NSString *)message {
    [self writeLine:message forLevel:SKLoggingLevelInfo];
}

- (void) writeWarn:(NSString *)message {
    [self writeLine:message forLevel:SKLoggingLevelWarning];
}

- (void) writeError:(NSString *)message {
    [self writeLine:message forLevel:SKLoggingLevelError];
}

- (void) setLevel:(SKLoggingLevel)level {
    _level = level;
    [self writeDebug:[NSString stringWithFormat:@"Setting log level to: %@ (%lu)", [self stringForLevel:level], (unsigned long)level]];
}

@end
