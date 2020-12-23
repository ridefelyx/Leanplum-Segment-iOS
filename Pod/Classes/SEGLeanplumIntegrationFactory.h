//
//  SEGLeanplumIntegrationFactory.h
//  Leanplum Segment iOS Integration Version 1.1.4-beta10
//
//  Copyright (c) 2020 Leanplum. All rights reserved.
//

#import <Segment/SEGAnalytics.h>
#import "SEGLeanplumIntegration.h"
#import <Foundation/Foundation.h>

@interface SEGLeanplumIntegrationFactory : NSObject <SEGIntegrationFactory>

extern NSString *LPLeanplumSegmentKey;

+ (SEGLeanplumIntegrationFactory *)instance;
- (SEGLeanplumIntegration *)createWithSettings:(NSDictionary *)settings
                                  forAnalytics:(SEGAnalytics *)analytics;
- (NSString *)key;

@end
