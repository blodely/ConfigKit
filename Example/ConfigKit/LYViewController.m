//
//  LYViewController.m
//  LYConfigKit
//
//  CREATED BY LUO YU ON 2016-10-11.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "LYViewController.h"
#import "LYTestViewController.h"
#import <LYConfigKit/LYConfigKit.h>

@interface LYViewController ()

@end

@implementation LYViewController

- (IBAction)pushButtonPressed:(UIButton *)sender {
	[self.navigationController pushViewController:[[LYTestViewController alloc] init] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW, TYPICALLY FROM A NIB.
	
	self.navigationItem.title = @"sample long long title";
	[self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]];
	
//	NSLog(@"\n\n%@\n=======\n%@", [self availableLanguages], [self availableLangs]);
//	[[self availableLangs] containsObject:localeName] ? NSLog(@"YES") : NSLog(@"NO");
	
	[[LYConfigKit kit] availableLanguages];
	
	[[LYConfigKit kit] setLocale:@"zh-Hans"];
	
	NSLocalizedString(@"", nil);
	
	[@"" localized];
	
	[LYConfigKit kit].target = [NSDate dateWithTimeIntervalSinceNow:60];
	
	NSLog(@"%@", [LYConfigKit kit].target);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
