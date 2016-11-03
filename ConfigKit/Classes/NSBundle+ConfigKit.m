//
//  NSBundle+ConfigKit.m
//  ConfigKit
//
//  CREATED BY LUO YU ON 2016-11-03.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "NSBundle+ConfigKit.h"
#import "ConfigKit.h"

@implementation NSBundle (ConfigKit)

+ (NSBundle *)configkitResBundle {
	return [self bundleWithURL:[[NSBundle bundleForClass:[ConfigKit class]] URLForResource:@"ConfigKitRes" withExtension:@"bundle"]];
}

@end
