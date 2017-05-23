//
//  LYViewController.m
//  ConfigKit
//
//  CREATED BY LUO YU ON 2016-10-11.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "LYViewController.h"
#import "LYTestViewController.h"
#import "ConfigKit.h"

@interface LYViewController ()

@end

@implementation LYViewController

- (IBAction)pushButtonPressed:(UIButton *)sender {
	[self.navigationController pushViewController:[[LYTestViewController alloc] init] animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.view.backgroundColor = [UIColor colorWithHex:@"#939393"];
	
	self.navigationItem.title = @"sample long long title";
	
//	NSLog(@"\n\n%@\n=======\n%@", [self availableLanguages], [self availableLangs]);
//	[[self availableLangs] containsObject:localeName] ? NSLog(@"YES") : NSLog(@"NO");
	
	[[ConfigKit kit] availableLanguages];
	
	[[ConfigKit kit] setLocale:@"zh-Hans"];
	
	NSLocalizedString(@"", nil);
	
	[@"" localized];
	
	[ConfigKit kit].target = [NSDate dateWithTimeIntervalSinceNow:60];
	
	NSLog(@"%@", [ConfigKit kit].target);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
