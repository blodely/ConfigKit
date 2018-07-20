//
//  LYConfigKit.h
//  LYConfigKit
//
//  CREATED BY LUO YU ON 2016-09-13.
//  COPYRIGHT © 2016 骆昱(LUO YU) <indie.luo@gmail.com>
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import <LYConfigKit/NSBundle+ConfigKit.h>
#import <LYConfigKit/NSString+ConfigKit.h>

FOUNDATION_EXPORT NSString *const LIB_CONFIGKIT_BUNDLE_ID;
FOUNDATION_EXPORT NSString *const NAME_CONF_SYSTEM_STYLE;

FOUNDATION_EXPORT NSString *const CONFIGKIT_LANG;
FOUNDATION_EXPORT NSString *const NOTIF_LANGUAGE_CHANGED;

// MARK: - CONFIGKIT

@interface LYConfigKit : NSObject

/**
 target datetime
 */
@property (nonatomic, weak) NSDate *target;

/**
 shared instance

 @return shared instance of ConfigKit
 */
+ (instancetype)kit;

// MARL: STYLE

/**
 *  CONFIGURE SYSTEM STYLE
 */
- (void)systemStyle;

// MARK: LOCALE

/**
 *  LANGUAGES
 */
- (void)setLocale:(NSString *)localeName;

- (NSInteger)selectedLocaleIndex;

- (NSArray *)availableLanguages;

#pragma mark CHECK

- (BOOL)isFirstTimeRunApp;

/**
 mark app runned first time
 */
- (void)appRunned;

#pragma mark - LIB'S CONFIGURATION READER

- (NSDictionary *)readConfigurationNamed:(NSString *)plistFilename andLibBundleIdentifier:(NSString *)libBundleID;

#pragma mark SOUND

/**
 play wav sound file

 @param soundName file name
 */
- (void)playSoundWavFileNamed:(NSString *)soundName;

/**
 play wav sound file in bundle

 @param soundName file name
 @param bundle bundle object
 */
- (void)playSoundWavFileNamed:(NSString *)soundName inBundle:(NSBundle *)bundle;

@end
