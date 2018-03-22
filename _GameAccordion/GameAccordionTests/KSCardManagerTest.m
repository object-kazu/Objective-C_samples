//
//  KSCardManagerTest.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/06.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KSCardManager.h"
#import "KSGlobalConst.h"

@interface KSCardManagerTest : XCTestCase

@property (nonatomic,retain) KSCardManager* cardManager;

@end

@implementation KSCardManagerTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)test_Suit
{
    NSArray* arr = [[KSCardManager sharedManager] suit];
    NSInteger cardNumber = CARD_COLOR_MAX * CARD_NUMBER_MAX;
    XCTAssertEqual([arr count], (NSUInteger)cardNumber, @"");
}

-(void)test_arc4random_uniform{
    NSInteger cardNumber = CARD_COLOR_MAX * CARD_NUMBER_MAX;
    NSLog(@"cardnum is %ld",(long)cardNumber);
    for (int i = 0; i < cardNumber; i++) {
        int num = arc4random_uniform(cardNumber);
        XCTAssertTrue(num < cardNumber, @"");
    }
}

-(void)test_suit_randomTreatment{
    NSArray *arr = [[KSCardManager sharedManager] suit];
    NSUInteger serialArray = [arr count];
    NSArray* t_arr = [[KSCardManager sharedManager] shuffleSuit:arr];
    NSUInteger ramdomArray = [t_arr count];
    NSLog(@"s_arr :%lu r_arr:%lu",(unsigned long)serialArray,(unsigned long)ramdomArray);
    XCTAssertEqual(serialArray, ramdomArray, @"");
    
}

-(void)test_suit_random_desctipe{
//    NSArray *arr = [[KSCardManager sharedManager] suit];
//    NSArray* t_arr = [[KSCardManager sharedManager] shuffleSuit:arr];
    NSArray *t_arr = [[KSCardManager sharedManager] shuffledSuit];
    for (int i = 0; i <[t_arr count]; i++) {
        CardID cid;
        NSValue *val = [t_arr objectAtIndex:i];
        [val getValue:&cid];
        NSLog(@"CardID id:%d,Number:%d, color:%@",cid.tagID,cid.numberID,cid.colorID);
    }
}

@end
