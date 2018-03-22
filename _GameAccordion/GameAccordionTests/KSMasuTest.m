//
//  KSMasuTest.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/08.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KSGlobalConst.h"
#import "KSMasuManager.h"
#import "KSMasu.h"

@interface KSMasuTest : XCTestCase

@property (nonatomic,retain) KSMasu* masu;

@end

@implementation KSMasuTest

- (void)setUp
{
    [super setUp];
    self.masu = [KSMasu new];
    self.masu.masuIndex = 1;
}

- (void)tearDown
{
    self.masu =nil;
    [super tearDown];
}


//-(void)test_masuOfActiveCardBeforeMasu{
//    KSMasu* target = [[KSMasuManager sharedManager] masuOfActiveCardBeforeMasu:masuBeforeOne activieMasu:self.masu];
//    ;;;;;;;
//    
//}

//-(void)test_getMasuFromCGPoint_nil{
//    CGPoint ori = CGPointMake(0, 0);
//    self.masu = [[KSMasuManager sharedManager] getMasuFromCGPoint:ori];
//    XCTAssertNil(self.masu, @"");
//}
//-(void)test_getMasuFromCGPoint_NotNil{
//    CGPoint ori = CGPointMake(100, 100);
//    self.masu = [[KSMasuManager sharedManager] getMasuFromCGPoint:ori];
//    XCTAssertNil(self.masu, @"");
//}


@end
