//
//  ConfigKit.h
//  Pods
//
//  CREATED BY LUO YU ON 2016-09-13.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const LIB_CONFIGKIT_BUNDLE_ID;
FOUNDATION_EXPORT NSString *const NAME_CONF_SYSTEM_STYLE;

@interface ConfigKit : NSObject

+ (instancetype)kit;

/**
 *  CONFIGURE SYSTEM STYLE
 */
- (void)systemStyle;

@end

@class UIColor;

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(NSString *)hexstring;

@end
