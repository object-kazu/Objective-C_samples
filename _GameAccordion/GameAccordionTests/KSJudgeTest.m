//
//  KSJudgeTest.m
//  GameAccordion
//
//  Created by 清水 一征 on 2014/02/24.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KSJudge.h"
#import "KSGlobalConst.h"
#import "KSCard.h"

@interface KSJudgeTest : XCTestCase

@property (nonatomic, retain) KSJudge    *judge;
@property (nonatomic, retain) KSCard     *active;
@property (nonatomic, retain) KSCard     *target;
@property (nonatomic, retain) KSCard     *anotherNumber;
@property (nonatomic, retain) KSCard     *anotherColor;

@end

@implementation KSJudgeTest

- (void)setUp {
    [super setUp];
    self.judge = [KSJudge new];
    
    self.active                 = [[KSCard alloc] initWithSize:CGSizeMake(10, 10) eyeColor:[UIColor redColor] fontSize:10];
    self.active.number          = @"10";
    self.active.backgroundColor = COLOR_red;
    
    self.target                 = [[KSCard alloc] initWithSize:CGSizeMake(10, 10) eyeColor:[UIColor redColor] fontSize:10];
    self.target.number          = @"10";
    self.target.backgroundColor = COLOR_red;
    
    self.anotherNumber                 = [[KSCard alloc] initWithSize:CGSizeMake(10, 10) eyeColor:[UIColor redColor] fontSize:10];
    self.anotherNumber.number          = @"1";
    self.anotherNumber.backgroundColor = COLOR_red;
    
    self.anotherColor                 = [[KSCard alloc] initWithSize:CGSizeMake(10, 10) eyeColor:[UIColor redColor] fontSize:10];
    self.anotherColor.number          = @"10";
    self.anotherColor.backgroundColor = COLOR_yellow;
    
}

- (void)tearDown {
    self.judge         = nil;
    self.active        = nil;
    self.target        = nil;
    self.anotherColor  = nil;
    self.anotherNumber = nil;
    
    [super tearDown];
}

- (void)test_isExist_without_cards {
    BOOL    isExist = [self.judge isCardsExst];
    XCTAssertFalse(isExist, @"");
    
}
-(void) test_isExist_with_two_cards{
    self.judge.active = self.active;
    self.judge.target = self.target;
    BOOL isExist = [self.judge isCardsExst];
    XCTAssertTrue(isExist, @"");
}
-(void) test_isEist_one_Card{
    self.judge.target = self.target;
    BOOL isExist = [self.judge isCardsExst];
    XCTAssertFalse(isExist, @"");
}
-(void) test_SameColor_True{
    self.judge.target = self.target;
    self.judge.active = self.active;
    BOOL isSame = [self.judge isSameColor];
    XCTAssertTrue(isSame, @"");
    
}
-(void) test_SameColor_False{
    self.judge.target = self.target;
    self.judge.active = self.anotherColor;
    BOOL isSame = [self.judge isSameColor];
    XCTAssertFalse(isSame, @"");
    
}
-(void) test_SameColor_True_anotherNuber{
    self.judge.target = self.target;
    self.judge.active = self.anotherNumber;
    BOOL isSame = [self.judge isSameColor];
    XCTAssertTrue(isSame, @"");
    
}
-(void) test_SameNumber_True{
    self.judge.target = self.target;
    self.judge.active = self.active;
    BOOL isSame = [self.judge isSameNumber];
    XCTAssertTrue(isSame, @"");
    
}
-(void) test_SameNumber_False{
    self.judge.target = self.target;
    self.judge.active = self.anotherNumber;
    BOOL isSame = [self.judge isSameNumber];
    XCTAssertFalse(isSame, @"");
    
}
-(void) test_canMove_True_because_both_same{
    self.judge.active = self.active;
    self.judge.target = self.target;
    BOOL canMove = [self.judge canMoveOnCard];
    XCTAssertTrue(canMove, @"");
}
-(void) test_canMove_True_because_sameNumber{
    self.judge.active = self.active;
    self.judge.target = self.anotherColor;
    BOOL canMove = [self.judge canMoveOnCard];
    XCTAssertTrue(canMove, @"");
}

-(void) test_canMove_True_because_sameColor{
    self.judge.active = self.active;
    self.judge.target = self.anotherNumber;
    BOOL canMove = [self.judge canMoveOnCard];
    XCTAssertTrue(canMove, @"");
}

@end
