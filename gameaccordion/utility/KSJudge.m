//
//  KSJudge.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/24.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSJudge.h"

@implementation KSJudge

- (id)init {
    if ( self = [super init] ) {

    }

    return self;
}

- (BOOL)isCardsExst {
    if ( self.active == nil ) {
//        NSLog(@"active card is nil");

        return NO;
    } else if ( self.target == nil ) {
//        NSLog(@"target card is nil");

        return NO;
    } else {
        return YES;
    }

}

//card 同一性確認
- (BOOL)isSameColor {

    if ( [self.active.backgroundColor
          isEqual:self.target.backgroundColor] ) {
        return YES;
    } else {
        return NO;
    }

}

- (BOOL)isSameNumber {

    if ( [self.active.number isEqualToString:self.target.number] ) {
        return YES;
    } else {
        return NO;
    }

}

- (BOOL)canMoveOnCard {

    BOOL    sameColor  = [self isSameColor];
    BOOL    sameNumber = [self isSameNumber];
    if ( sameColor || sameNumber ) {
        return YES;
    } else {
        return NO;
    }
}

//card state
- (NSInteger)getRemoveTag:(NSMutableArray *)cardState activetag:(NSUInteger)Tag {
    NSInteger    removeTag = 0;
    for ( int i = 0; i < [cardState count]; i++ ) {
        KSCard    *card = [cardState objectAtIndex:i];
        if ( card.tag == Tag ) {
            removeTag = i;
        }
    }

    return removeTag;
}

#pragma mark - 終了判定

- (BOOL)isCardExstAtMaxPosi:(NSInteger)mode
                  cardstate:(NSMutableArray *)cardStateArray {

    NSUInteger    maxCardIndex = [cardStateArray count];
    BOOL          isExist      = NO;

    if ( maxCardIndex < mode ) {
        isExist = NO;
    } else {
        isExist = YES;
    }

//    NSLog(@"isExist is %d", isExist);
    return isExist;
}

- (BOOL)isStockedCardArrayNotZero:(NSMutableArray *)stockedArray {
    if ( [stockedArray count] > 0 ) {
        return YES;
    } else {
        return NO;
    }

}

@end
