//
//  LPViewController.m
//  Leanplum Segment iOS Integration Version 1.0.1
//
//  Copyright (c) 2016 Leanplum. All rights reserved.
//

#import "LPViewController.h"
#import "Leanplum.h"
#import <LeanplumSegment/SEGLeanplumIntegrationFactory.h>

@interface LPViewController ()

@end

@implementation LPViewController

NSString *const SEGMENT_WRITE_KEY = @"<KEY>";

- (void)viewDidLoad
{
    [super viewDidLoad];

    SEGAnalyticsConfiguration *config =
        [SEGAnalyticsConfiguration configurationWithWriteKey:SEGMENT_WRITE_KEY];
    [config use:[SEGLeanplumIntegrationFactory instance]];
    [SEGAnalytics setupWithConfiguration:config];

    [[SEGAnalytics sharedAnalytics] identify:@"f4ca124297"
                                      traits:@{
                                          @"name" : @"First Last",
                                          @"email" : @"first@last.com"
                                      }];
    [[SEGAnalytics sharedAnalytics] track:@"Signed up"
                               properties:@{
                                   @"plan" : @"Enterprise"
                               }];
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
