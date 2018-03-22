//
//  KSPageViewTest.m
//  gameaccordion
//
//  Created by kazuyuki shimizu on 2014/03/14.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KSPageView.h"
#import "KSGlobalConst.h"

@interface KSPageViewTest : XCTestCase

@property (nonatomic,retain) KSPageView* testPage;

@end

@implementation KSPageViewTest

- (void)setUp
{
    [super setUp];

    self.testPage = [KSPageView new];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) test_checkBackColor{
    BOOL test = [self.testPage checkBackColor:COLOR_red];
    XCTAssertTrue(test, @"");
    test = nil;
    
    test = [self.testPage checkBackColor:COLOR_green];
    XCTAssertTrue(test, @"");
    
    
    test = nil;
    test = [self.testPage checkBackColor:[UIColor redColor]];
    XCTAssertFalse(test, @"");
}


- (void) test_eyeCatchColorFromBackColor{
    UIColor *sample = [self.testPage eyeCatchColorFromBackColor:COLOR_green];
    XCTAssertTrue([sample isEqual:ACCENT_green], @"");
    
    sample = nil;
    sample = [self.testPage eyeCatchColorFromBackColor:COLOR_red];
    XCTAssertTrue([sample isEqual:ACCENT_red], @"");
}

@end
