//
//  SEGLeanplumIntegration.h
//  Leanplum Segment iOS Integration Version 1.1.4-beta3
//
//  Copyright (c) 2020 Leanplum. All rights reserved.
//

#import <Analytics/SEGAnalytics.h>
#import <Foundation/Foundation.h>
#import "Leanplum.h"

@interface SEGLeanplumIntegration : NSObject <SEGIntegration>

- (instancetype)initWithSettings:(NSDictionary *)settings;

@end
