//
//  KSCardManagerTest.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/08/25.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSCardManagerTest.h"

@implementation KSCardManagerTest


- (void)setUp
{
    [super setUp];
    _cManager = [KSCardManager new];
    
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    _cManager = nil;
    [super tearDown];
}

-(void) test_moveCardToReservePosition_TOP{
    CGRect rect = CGRectMake(0, 0, CARD_WIDTH, CARD_HIGHT);
    rect = [_cManager moveCardToReservePosition:rect direction:HOMEButton_Down];
    STAssertEquals(rect.origin.x, (CGFloat) 0, nil);
    STAssertEquals(rect.origin.y, (CGFloat) -1*CARD_HIGHT, nil);
}

-(void) test_moveCardToReservePosition_BOTTOM{
    CGRect    screen = [[UIScreen mainScreen] bounds];
    
    CGRect rect = CGRectMake(0, 0, CARD_WIDTH, CARD_HIGHT);
    rect = [_cManager moveCardToReservePosition:rect direction:HOMEButton_Top];
    STAssertEquals(rect.origin.x, (CGFloat) 0, nil);
    STAssertEquals(rect.origin.y, (CGFloat) screen.size.height + CARD_HIGHT, nil);
}

-(void) test_moveCardToReservePosition_LEFT{
    CGRect    screen = [[UIScreen mainScreen] bounds];
    
    CGRect rect = CGRectMake(0, 0, CARD_WIDTH, CARD_HIGHT);
    rect = [_cManager moveCardToReservePosition:rect direction:HOMEButton_Left];
    STAssertEquals(rect.origin.x, (CGFloat) screen.size.width + CARD_WIDTH, nil);
    
    STAssertEquals(rect.origin.y, (CGFloat) 0, nil);
}

-(void) test_moveCardToReservePosition_RIGHT{
    
    CGRect rect = CGRectMake(0, 0, CARD_WIDTH, CARD_HIGHT);
    rect = [_cManager moveCardToReservePosition:rect direction:HOMEButton_Right];
    STAssertEquals(rect.origin.x, (CGFloat)-1 * CARD_WIDTH , nil);
    STAssertEquals(rect.origin.y, (CGFloat) 0, nil);
}

-(void)test_searchMasuArray_BOTTOM{
    
    NSArray* arr = [_cManager searchMasuArray:HOMEButton_Down];
    for (NSValue *vv in arr) {
        MasuPoint mp;
        [vv getValue:&mp];
        NSLog(@"masu point x:%d, y:%d",mp.x, mp.y);
    }
    NSValue *val = arr[0];
    MasuPoint mp;
    [val getValue:&mp];
    
    MasuPoint mp_first;
    mp_first.x = 0;
    mp_first.y = MASU_Y_MAX;// iphone 5の時のみ成立
    
    STAssertEquals(mp_first, mp, nil);
}

-(void)test_searchMasuArray_TOP{
    
    NSArray* arr = [_cManager searchMasuArray:HOMEButton_Top];
    for (NSValue *vv in arr) {
        MasuPoint mp;
        [vv getValue:&mp];
        NSLog(@"masu point x:%d, y:%d",mp.x, mp.y);
    }
    NSValue *val = arr[0];
    MasuPoint mp;
    [val getValue:&mp];
    
    MasuPoint mp_first;
    mp_first.x = 0;
    mp_first.y = 0;// iphone 5の時のみ成立
    
    STAssertEquals(mp_first, mp, nil);
    
    NSArray* arr2 = [_cManager searchMasuArray:HOMEButton_Top];
    NSValue* val2 = [arr2 lastObject];
    MasuPoint vp;
    [val2 getValue:&vp];
    
    MasuPoint mp_last;
    mp_last.x = MASU_X_MAX;
    mp_last.y = 0;
    
    STAssertEquals(mp_last,vp, nil);
}

-(void)test_searchMasuArray_Left{
    NSArray* arr = [_cManager searchMasuArray:HOMEButton_Left];
    for (NSValue *vv in arr) {
        MasuPoint mp;
        [vv getValue:&mp];
        NSLog(@"masu point x:%d, y:%d",mp.x, mp.y);
    }

    
    
    NSValue* val = arr[0];
    MasuPoint mp;
    [val getValue:&mp];
    
    MasuPoint masu;
    masu.x = 0;
    masu.y = 0;
    
    STAssertEquals(mp, masu, nil);
    
    //last
    val = [arr lastObject];
    [val getValue:&mp];
    masu.x = 0;
    masu.y = MASU_Y_MAX; // iphone 5の場合
    STAssertEquals(mp, masu, nil);
    
    
}


-(void)test_searchMasuArray_Right{
    NSArray* arr = [_cManager searchMasuArray:HOMEButton_Right];
    for (NSValue *vv in arr) {
        MasuPoint mp;
        [vv getValue:&mp];
        NSLog(@"masu point x:%d, y:%d",mp.x, mp.y);
    }
    
    
    
    NSValue* val = arr[0];
    MasuPoint mp;
    [val getValue:&mp];
    
    MasuPoint masu;
    masu.x = MASU_X_MAX;
    masu.y = 0;
    
    STAssertEquals(mp, masu, nil);
    
    //last
    val = [arr lastObject];
    [val getValue:&mp];
    masu.x = MASU_X_MAX;
    masu.y = MASU_Y_MAX; // iphone 5の場合
    STAssertEquals(mp, masu, nil);
    
    
}




@end
