//
//  LPViewController.m
//  Leanplum Segment iOS Integration
//
//  Copyright (c) 2020 Leanplum. All rights reserved.
//

#import "LPViewController.h"
#import <LeanplumSegment/SEGLeanplumIntegrationFactory.h>

@interface LPViewController ()

@end

@implementation LPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[SEGAnalytics sharedAnalytics] screen:@"Start"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)trackButtonClicked:(id)sender
{
    [[SEGAnalytics sharedAnalytics] track:@"Track Button Clicked!"
                               properties:@{
                                   @"price" : @(0.99),
                                   @"currency" : @"USD",
                                   @"title" : @"InApp Purchase"
                               }];
}

@end
