//
//  ConfigKit.m
//  ConfigKit
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

#import "LYConfigKit.h"
#import "FCFileManager.h"
#import <AudioToolbox/AudioToolbox.h>

NSString *const LIB_CONFIGKIT_BUNDLE_ID = @"org.cocoapods.LYConfigKit";
NSString *const NAME_CONF_SYSTEM_STYLE = @"conf-system-style"; // SHOUND NOT BE CHANGED

NSString *const CONFIGKIT_LANG = @"config.kit.lang";
NSString *const NOTIF_LANGUAGE_CHANGED = @"config.kit.notif.language.changed";

NSString *const CONFIGKIT_TARGET_DATE = @"config.kit.target.date";
NSString *const CONFIGKIT_FIRSTTIME_RUN_APP = @"config.kit.first.time.run.app";

@interface LYConfigKit () {
	
	NSString *confValue;
}

- (UIColor *)colorWithHex:(NSString *)hexstring;

@end

@implementation LYConfigKit

+ (instancetype)kit {
	static LYConfigKit *sharedConfigKit;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedConfigKit = [[LYConfigKit alloc] init];
	});
	return sharedConfigKit;
}

- (instancetype)init {
	if (self = [super init]) {
		confValue = @"conf-value";
	}
	return self;
}

- (void)systemStyle {
	
	__weak NSDictionary *conf = [self readConfigurationNamed:NAME_CONF_SYSTEM_STYLE andLibBundleIdentifier:LIB_CONFIGKIT_BUNDLE_ID];
	
	// STATUS BAR
	[[UIApplication sharedApplication] setStatusBarStyle:([conf[@"sys-statusbar-style"][confValue] intValue] == 0 ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent)];
	
	// NAVIGATION BAR TITLE
	[[UINavigationBar appearance] setBarTintColor:[self colorWithHex:conf[@"sys-navbar-bar-tint-color"][confValue]]];
	[[UINavigationBar appearance] setTintColor:[self colorWithHex:conf[@"sys-navbar-tint-color"][confValue]]];
	[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorWithHex:conf[@"sys-navbar-title-foreground-color"][confValue]],}];
	[[UINavigationBar appearance] setTranslucent:[conf[@"sys-navbar-translucent"][confValue] boolValue]];
	
	// REMOVE NAV BAR BOTTOM LINE STYLE
	if ([conf[@"sys-navbar-bottom-line"][confValue] integerValue] > 0) {
		[[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
		[[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
	}
	
	// UITABBAR
	[[UITabBar appearance] setTintColor:[self colorWithHex:conf[@"sys-tabbar-tint-color"][confValue]]];
	
	[[UITabBar appearance] setTranslucent:[conf[@"sys-tabbar-translucent"][confValue] boolValue]];
	
	// NAVIGATION BAR BACK BUTTON
	UIImage *backImg = [UIImage imageNamed:@"nav-ico-back"];
	if (backImg == nil) {
		backImg = [UIImage imageNamed:@"nav-ico-back" inBundle:[self configkitResBundle] compatibleWithTraitCollection:nil];
	}
	[[UINavigationBar appearance] setBackIndicatorImage:backImg];
	[[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backImg];
	
	if (@available(iOS 11.0, *)) {
		[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, UIApplication.sharedApplication.keyWindow.safeAreaInsets.top)
															 forBarMetrics:UIBarMetricsDefault];
	} else {
//		[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin)
		[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, 20) // iOS 7.0+
															 forBarMetrics:UIBarMetricsDefault];
	}
}

- (void)setLocale:(NSString *)localeName {
	
	if ([[self availableLangs] containsObject:localeName]) {
		[[NSUserDefaults standardUserDefaults] setObject:localeName forKey:CONFIGKIT_LANG];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_LANGUAGE_CHANGED object:nil userInfo:@{@"LANGUAGE":localeName,}];
	} else {
		NSLog(@"\n\nCONFIGKIT ERROR\n\tSWITCH LANGUAGE FAILED\n");
	}
	
}

- (NSInteger)selectedLocaleIndex {
	
	NSString *localeName = [[NSUserDefaults standardUserDefaults] objectForKey:CONFIGKIT_LANG];
	
	NSArray *langs = [self availableLangs];
	
	if (localeName == nil || [langs containsObject:localeName] == NO) {
		return 0;
	}
	
	NSInteger idx = 0;
	for (int i = 0; i < [langs count]; i++) {
		if ([langs[i] isEqualToString:localeName]) {
			idx = i;
			break;
		}
	}
	
	return idx;
}

- (NSArray *)availableLanguages {
	return [self readConfigurationNamed:NAME_CONF_SYSTEM_STYLE andLibBundleIdentifier:LIB_CONFIGKIT_BUNDLE_ID][@"sys-languages"][confValue];
}

#pragma mark - PROPERTY

- (void)setTarget:(NSDate *)target {
	if (target == nil || [target isKindOfClass:[NSDate class]] == NO) {
		// REMOVE TARGET DATE
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:CONFIGKIT_TARGET_DATE];
	}
	[[NSUserDefaults standardUserDefaults] setInteger:(NSInteger)[target timeIntervalSince1970] forKey:CONFIGKIT_TARGET_DATE];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDate *)target {
	NSInteger targetTt = [[NSUserDefaults standardUserDefaults] integerForKey:CONFIGKIT_TARGET_DATE];
	if (targetTt <= 0) {
		return nil;
	}
	return [NSDate dateWithTimeIntervalSince1970:targetTt];
}

#pragma mark - METHOD

#pragma mark PRIVATE METHOD

- (UIColor *)colorWithHex:(NSString *)hexstring {
	// WE FOUND AN EMPTY STRING, WE ARE RETURNING NOTHING
	if (hexstring.length == 0) {
		return nil;
	}
	
	// CHECK FOR HASH AND ADD THE MISSING HASH
	if('#' != [hexstring characterAtIndex:0]) {
		hexstring = [NSString stringWithFormat:@"#%@", hexstring];
	}
	
	// RETURNING NO OBJECT ON WRONG ALPHA VALUES
	NSArray *validHexStringLengths = @[@7,];
	NSNumber *hexStringLengthNumber = [NSNumber numberWithUnsignedInteger:hexstring.length];
	if ([validHexStringLengths indexOfObject:hexStringLengthNumber] == NSNotFound) {
		return nil;
	}
	
	unsigned value = 0;
	NSScanner *hexValueScanner = nil;
	
	NSString *redHex = [NSString stringWithFormat:@"0x%@", [hexstring substringWithRange:NSMakeRange(1, 2)]];
	hexValueScanner = [NSScanner scannerWithString:redHex];
	[hexValueScanner scanHexInt:&value];
	unsigned redInt = value;
	hexValueScanner = nil;
	
	NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hexstring substringWithRange:NSMakeRange(3, 2)]];
	hexValueScanner = [NSScanner scannerWithString:greenHex];
	[hexValueScanner scanHexInt:&value];
	unsigned greenInt = value;
	hexValueScanner = nil;
	
	NSString *blueHex = [NSString stringWithFormat:@"0x%@", [hexstring substringWithRange:NSMakeRange(5, 2)]];
	hexValueScanner = [NSScanner scannerWithString:blueHex];
	[hexValueScanner scanHexInt:&value];
	unsigned blueInt = value;
	hexValueScanner = nil;
	
	return [UIColor colorWithRed:redInt/255.0f green:greenInt/255.0f blue:blueInt/255.0f alpha:1.0f];
}

#pragma mark CHECK

- (BOOL)isFirstTimeRunApp {
	return ![[NSUserDefaults standardUserDefaults] boolForKey:CONFIGKIT_FIRSTTIME_RUN_APP];
}

- (void)appRunned {
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:CONFIGKIT_FIRSTTIME_RUN_APP];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - LIB'S CONFIGURATION READER
- (NSDictionary *)readConfigurationNamed:(NSString *)plistFilename andLibBundleIdentifier:(NSString *)libBundleID {
	
	NSString *confpath;
	
	confpath = [[NSBundle mainBundle] pathForResource:plistFilename ofType:@"plist"];
	
	if (confpath == nil || [confpath isEqualToString:@""] == YES || [FCFileManager isFileItemAtPath:confpath] == NO) {
		
		NSLog(@"CONFIGURATION FILE READER WARNING\n\tAPP CONFIGURATION FILE WAS NOT FOUND.\n\t%@", confpath);
		
		// FALLBACK TO LIB DEFAULT
		confpath = [[NSBundle bundleWithIdentifier:libBundleID] pathForResource:plistFilename ofType:@"plist"];
	}
	
	// TRY TO READ APP CONFIGURATION
	NSDictionary *conf = [FCFileManager readFileAtPathAsDictionary:confpath];
	
	if (conf == nil) {
		NSLog(@"CONFIGURATION FILE READER ERROR\n\tCONFIGURATION FILE WAS NEVER FOUND.");
	}
	
	// NSLog(@"%@", conf);
	
	return conf;
}

// MARK: PRIVATE METHOD

- (NSArray *)availableLangs {
	NSMutableArray *langs = [NSMutableArray arrayWithCapacity:1];
	for (NSDictionary *one in [self readConfigurationNamed:NAME_CONF_SYSTEM_STYLE andLibBundleIdentifier:LIB_CONFIGKIT_BUNDLE_ID][@"sys-languages"][confValue]) {
		[langs addObject:one[confValue]];
	}
	return [NSArray arrayWithArray:langs];
}

- (NSBundle *)configkitResBundle {
	return [NSBundle bundleWithURL:[[NSBundle bundleForClass:[LYConfigKit class]] URLForResource:@"LYConfigKitRes" withExtension:@"bundle"]];
}

// MARK: SOUND

- (void)playSoundWavFileNamed:(NSString *)soundName inBundle:(NSBundle *)bundle {
	
	// ALLOCATION SOUND
	SystemSoundID soundID;
	
	// CREATE SOUND WITH FILEPATH
	if (bundle == nil) {
		// FALL BACK TO DEDAULT BUNDLE
		AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"]], &soundID);
	} else {
		AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL URLWithString:[bundle pathForResource:soundName ofType:@"wav"]], &soundID);
	}
	
	// PLAY SOUND
	AudioServicesPlaySystemSound(soundID);
}

- (void)playSoundWavFileNamed:(NSString *)soundName {
	[self playSoundWavFileNamed:soundName inBundle:[NSBundle mainBundle]];
}

@end
