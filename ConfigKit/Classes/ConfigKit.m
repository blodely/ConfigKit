//
//  ConfigKit.m
//  Pods
//
//  CREATED BY LUO YU ON 2016-09-13.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "ConfigKit.h"
#import "FCFileManager.h"

@interface ConfigKit () {
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

- (void)systemStyle {
	
}

@end
