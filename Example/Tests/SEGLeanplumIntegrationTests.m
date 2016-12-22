//
//  SEGLeanplumIntegration.h
//  Leanplum Segment iOS Integration Version 1.0.1
//
//  Copyright (c) 2016 Leanplum. All rights reserved.
//

#import <Leanplum/Leanplum.h>
#import <LeanplumSegment/SEGLeanplumIntegrationFactory.h>
#import <OCMock/OCMock.h>

@import XCTest;

@interface SEGLeanplumIntegrationTests : XCTestCase

@end

@interface Leanplum (ResetInvocation)

+ (void)reset;

@end

@implementation SEGLeanplumIntegrationTests

SEGLeanplumIntegration* integration;

- (void)setUp
{
    [super setUp];

    NSDictionary* settings = @{ @"appId" : @"appId",
                                @"clientKey" : @"key",
                                @"devMode" : @NO };

    integration = [[SEGLeanplumIntegration alloc] initWithSettings:settings];
}

- (void)tearDown
{
    [super tearDown];
    [Leanplum reset];
}

- (void)testIntegrationConstructor
{
    XCTAssertNotNil(integration);
}

- (void)testFactory
{
    [Leanplum reset];

    SEGLeanplumIntegration* integration =
        [[SEGLeanplumIntegrationFactory alloc]
            createWithSettings:@{ @"appId" : @"appId",
                                  @"clientKey" : @"key",
                                  @"devMode" : @NO }
                  forAnalytics:nil];

    XCTAssertNotNil(integration);
}

- (void)testIdentify
{
    SEGIdentifyPayload* payload = [[SEGIdentifyPayload alloc]
        initWithUserId:@"userId"
           anonymousId:@"anonymousId"
                traits:@{ @"email" : @"foo@bar.com" }
               context:nil
          integrations:nil];

    id mockLeanplum = OCMClassMock([Leanplum class]);
    SEL selector = @selector(setUserId:withUserAttributes:);
    XCTAssertTrue([[Leanplum class] respondsToSelector:selector]);
    OCMStub(ClassMethod([mockLeanplum methodForSelector:selector]));

    [integration identify:payload];

    [[NSRunLoop mainRunLoop] runUntilDate:
                                 [NSDate dateWithTimeIntervalSinceNow:0.01]];
    OCMVerify([mockLeanplum setUserId:payload.userId
                   withUserAttributes:payload.traits]);
}

- (void)testTrack
{
    SEGTrackPayload* payload = [[SEGTrackPayload alloc]
        initWithEvent:@"testEvent"
           properties:@{ @"email" : @"foo@bar.com" }
              context:nil
         integrations:nil];
    
    SEGTrackPayload* payloadWithValue = [[SEGTrackPayload alloc]
                                initWithEvent:@"testEvent"
                                properties:@{ @"email" : @"foo@bar.com", @"value": @5 }
                                context:nil
                                integrations:nil];

    id mockLeanplum = OCMClassMock([Leanplum class]);

    SEL selector = @selector(track:withParameters:);
    SEL trackValueSelector = @selector(track:withValue:andParameters:);
    
    XCTAssertTrue([[Leanplum class] respondsToSelector:selector]);
    XCTAssertTrue([[Leanplum class] respondsToSelector:trackValueSelector]);
    
    OCMStub(ClassMethod([mockLeanplum methodForSelector:selector]));
    OCMStub(ClassMethod([mockLeanplum methodForSelector:trackValueSelector]));

    [integration track:payload];
    [integration track:payloadWithValue];

    [[NSRunLoop mainRunLoop] runUntilDate: [NSDate dateWithTimeIntervalSinceNow:0.01]];

    OCMVerify([mockLeanplum track:payload.event withParameters:payload.properties]);
    OCMVerify([mockLeanplum track:payloadWithValue.event withValue:5 andParameters:payloadWithValue.properties]);
}

- (void)testScreen
{
    SEGScreenPayload* payload = [[SEGScreenPayload alloc]
        initWithName:@"screen"
          properties:@{ @"some" : @"info" }
             context:nil
        integrations:nil];

    id mockLeanplum = OCMClassMock([Leanplum class]);
    SEL selector = @selector(track:withParameters:);
    XCTAssertTrue([[Leanplum class] respondsToSelector:selector]);
    OCMStub(ClassMethod([mockLeanplum methodForSelector:selector]));

    [integration screen:payload];

    [[NSRunLoop mainRunLoop] runUntilDate:
                                 [NSDate dateWithTimeIntervalSinceNow:0.01]];
    OCMVerify([mockLeanplum advanceTo:payload.name
                       withParameters:payload.properties]);
}

@end
