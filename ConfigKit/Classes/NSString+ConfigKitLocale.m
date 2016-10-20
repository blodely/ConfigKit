//
//  NSString+ConfigKitLocale.m
//  Pods
//
//  CREATED BY LUO YU ON 2016-10-20.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "NSString+ConfigKitLocale.h"
#import "ConfigKit.h"

@implementation NSString (ConfigKitLocale)

- (NSString *)localized {
	return [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:CONFIGKIT_LANG]] ofType:@"lproj"]] localizedStringForKey:(self) value:nil table:@"Language"];
}

@end
