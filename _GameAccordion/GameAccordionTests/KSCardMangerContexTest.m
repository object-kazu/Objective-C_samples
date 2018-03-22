//
//  KSCardMangerContexTest.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/14.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KSCardManagerContext.h"

@interface KSCardMangerContexTest : XCTestCase

@property(nonatomic,retain) KSCardManagerContext* context;

@end

@implementation KSCardMangerContexTest

- (void)setUp
{
    [super setUp];
    
    self.context = [KSCardManagerContext new];
}

- (void)tearDown
{
    self.context = nil;
    [super tearDown];
}

//-(void)test_checkMode_Seven{
//    [self.context changeMode:[KSCardManagerForSeven sharedMode]];
//    NSString* str = [self.context displayMode];
//    XCTAssertTrue([str isEqualToString:GAME_MODE_7],@"");
//}
//-(void)test_checkMode_FourTeen{
//    [self.context changeMode:[KSCardManagerForFourteen sharedMode]];
//    NSString* str = [self.context displayMode];
//    XCTAssertTrue([str isEqualToString:GAME_MODE_14],@"");
//}
//-(void)test_checkMode_Twentyone{
//    [self.context changeMode:[KSCardManagerForTwentyone sharedMode]];
//    NSString* str = [self.context displayMode];
//    XCTAssertTrue([str isEqualToString:GAME_MODE_21],@"");
//}



@end
