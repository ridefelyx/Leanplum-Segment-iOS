//
//  SEGLeanplumIntegrationFactory.h
//  Leanplum Segment iOS Integration Version 1.1.4-beta1
//
//  Copyright (c) 2020 Leanplum. All rights reserved.
//

#import <Analytics/SEGIntegrationFactory.h>
#import "SEGLeanplumIntegration.h"
#import <Foundation/Foundation.h>

@interface SEGLeanplumIntegrationFactory : NSObject <SEGIntegrationFactory>

extern NSString *LPLeanplumSegmentKey;

+ (SEGLeanplumIntegrationFactory *)instance;
- (SEGLeanplumIntegration *)createWithSettings:(NSDictionary *)settings
                                  forAnalytics:(SEGAnalytics *)analytics;
- (NSString *)key;

@end
