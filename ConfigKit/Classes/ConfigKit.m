//
//  ConfigKit.m
//  Pods
//
//  CREATED BY LUO YU ON 2016-09-13.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "ConfigKit.h"
#import "FCFileManager.h"

NSString *const LIB_CONFIGKIT_BUNDLE_ID = @"org.cocoapods.ConfigKit";
NSString *const NAME_CONF_SYSTEM_STYLE = @"conf-system-style"; // SHOUND NOT BE CHANGED

NSString *const CONFIGKIT_LANG = @"config.kit.lang";
NSString *const NOTIF_LANGUAGE_CHANGED = @"config.kit.notif.language.changed";

@interface ConfigKit () {
	
	NSString *confValue;
}
@end

@implementation ConfigKit

+ (instancetype)kit {
	static ConfigKit *sharedConfigKit;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedConfigKit = [[ConfigKit alloc] init];
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
	
	__weak NSDictionary *conf = [self readConfigurationFile];
	
	[[UIApplication sharedApplication] setStatusBarStyle:([conf[@"sys-statusbar-style"][confValue] intValue] == 0 ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent)];
	
	[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHex:conf[@"sys-navbar-bar-tint-color"][confValue]]];
	[[UINavigationBar appearance] setTintColor:[UIColor colorWithHex:conf[@"sys-navbar-tint-color"][confValue]]];
	
	[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:conf[@"sys-navbar-title-foreground-color"][confValue]],}];
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

- (NSArray *)availableLanguages {
	return [self readConfigurationFile][@"sys-languages"][confValue];
}

// MARK: PRIVATE METHOD

- (NSDictionary *)readConfigurationFile {
	NSString *confpath;
	
	confpath = [[NSBundle mainBundle] pathForResource:NAME_CONF_SYSTEM_STYLE ofType:@"plist"];
	
	if (confpath == nil || [confpath isEqualToString:@""] == YES || [FCFileManager isFileItemAtPath:confpath] == NO) {
		
		NSLog(@"ConfigKit WARNING\n\tAPP CONFIGURATION FILE WAS NOT FOUND.\n\t%@", confpath);
		
		// FALLBACK TO LIB DEFAULT
		confpath = [[NSBundle bundleWithIdentifier:LIB_CONFIGKIT_BUNDLE_ID] pathForResource:NAME_CONF_SYSTEM_STYLE ofType:@"plist"];
	}
	
	// TRY TO READ APP CONFIGURATION
	NSDictionary *conf = [FCFileManager readFileAtPathAsDictionary:confpath];
	
	if (conf == nil) {
		NSLog(@"ConfigKit ERROR\n\tCONFIGURATION FILE WAS NEVER FOUND.");
	}
	
//	NSLog(@"%@", conf);
	
	return conf;
}

- (NSArray *)availableLangs {
	NSMutableArray *langs = [NSMutableArray arrayWithCapacity:1];
	for (NSDictionary *one in [self readConfigurationFile][@"sys-languages"][confValue]) {
		[langs addObject:one[confValue]];
	}
	return [NSArray arrayWithArray:langs];
}

@end

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(NSString *)hexstring {
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

@end
