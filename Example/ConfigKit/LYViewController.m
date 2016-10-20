//
//  LYViewController.m
//  ConfigKit
//
//  CREATED BY LUO YU ON 2016-10-11.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "LYViewController.h"
#import "ConfigKit.h"

@interface LYViewController ()

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.navigationItem.title = @"sample";
	
//	NSLog(@"\n\n%@\n=======\n%@", [self availableLanguages], [self availableLangs]);
//	[[self availableLangs] containsObject:localeName] ? NSLog(@"YES") : NSLog(@"NO");
	
	[[ConfigKit kit] availableLanguages];
	
	[[ConfigKit kit] setLocale:@"zh-Hans"];
	
	NSLocalizedString(@"", nil);
	
	[@"" localized];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
