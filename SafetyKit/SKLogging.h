//
//  SKLogging.h
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

#import "SafetyKit.h"

/// The certificate kit logging class
@interface SKLogging : NSObject

/**
 Logging levels for the certificate kit log

 - SKLoggingLevelDebug: Debug logs will include all information sent to the log instance, including domain names. Use with caution.
 - SKLoggingLevelInfo: Informational logs for irregular, but not dangerous events.
 - SKLoggingLevelWarning: Warning logs for dangerous, but not fatal events.
 - SKLoggingLevelError: Error events for when things really go sideways.
 */
typedef NS_ENUM(NSUInteger, SKLoggingLevel) {
    SKLoggingLevelDebug = 0,
    SKLoggingLevelInfo,
    SKLoggingLevelWarning,
    SKLoggingLevelError,
};

/// The shared instance of the SKLogging class
+ (SKLogging * _Nonnull) sharedInstance;

/// The current logging level
@property (nonatomic) SKLoggingLevel level;
/// The filepath of the log file
@property (strong, nonatomic, nonnull) NSString * file;

/// Write a DEBUG level message
/// @param message The message to write
- (void) writeDebug:(NSString * _Nonnull)message;
/// Write an INFO level message
/// @param message The message to write
- (void) writeInfo:(NSString * _Nonnull)message;
/// Write a WARN level message
/// @param message The message to write
- (void) writeWarn:(NSString * _Nonnull)message;
/// Write an ERROR level message
/// @param message The message to write
- (void) writeError:(NSString * _Nonnull)message;

@end
