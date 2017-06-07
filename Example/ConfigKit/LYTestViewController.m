//
//  LYTestViewController.m
//  CONFIGKIT
//
//  CREATED BY LUO YU ON 2017-03-20.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "LYTestViewController.h"
#import <ConfigKit/ConfigKit.h>

@interface LYTestViewController ()

@end

@implementation LYTestViewController

- (IBAction)playSoundButtonPressed:(UIButton *)sender {
	[[ConfigKit kit] playSoundWavFileNamed:@"answer-right"
								  inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"game-sound.bundle"]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	self.navigationItem.title = @"test view long long title";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
