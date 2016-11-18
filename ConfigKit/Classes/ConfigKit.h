//
//  ConfigKit.h
//  ConfigKit
//
//  CREATED BY LUO YU ON 2016-09-13.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const LIB_CONFIGKIT_BUNDLE_ID;
FOUNDATION_EXPORT NSString *const NAME_CONF_SYSTEM_STYLE;

FOUNDATION_EXPORT NSString *const CONFIGKIT_LANG;
FOUNDATION_EXPORT NSString *const NOTIF_LANGUAGE_CHANGED;

@interface ConfigKit : NSObject

+ (instancetype)kit;

/**
 *  CONFIGURE SYSTEM STYLE
 */
- (void)systemStyle;

/**
 *  LANGUAGES
 */
- (void)setLocale:(NSString *)localeName;

- (NSInteger)selectedLocaleIndex;

- (NSArray *)availableLanguages;

#pragma mark - LIB'S CONFIGURATION READER
- (NSDictionary *)readConfigurationNamed:(NSString *)plistFilename andLibBundleIdentifier:(NSString *)libBundleID;

@end

@class UIColor;

@interface UIColor (ConfigKitHex)

+ (UIColor *)colorWithHex:(NSString *)hexstring;

@end

@interface NSString (ConfigKitLocale)

- (NSString *)localized;

@end
