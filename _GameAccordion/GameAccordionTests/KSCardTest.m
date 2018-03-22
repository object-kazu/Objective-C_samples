//
//  KSCardTest.m
//  GameAccordion
//
//  Created by 清水 一征 on 2014/02/13.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KSCard.h"

@interface KSCardTest : XCTestCase

@property(nonatomic,retain) KSCard* card;

@end

@implementation KSCardTest

- (void)setUp
{
    [super setUp];

    self.card = [KSCard new];
}

- (void)tearDown
{
    self.card = nil;
    [super tearDown];
}


@end
