//
//  KSJudge.h
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/24.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSCard.h"

@interface KSJudge : NSObject

@property (nonatomic, retain) KSCard    *active;
@property (nonatomic, retain) KSCard    *target;

// parameter set comfirm
- (BOOL)isCardsExst;

//cardの同一性確認
- (BOOL)isSameColor;
- (BOOL)isSameNumber;
- (BOOL)canMoveOnCard;

- (NSInteger)getRemoveTag:(NSMutableArray *)cardState activetag:(NSUInteger)Tag;

//終了判定
- (BOOL)isCardExstAtMaxPosi:(NSInteger)mode cardstate:(NSMutableArray *)cardStateArray;
- (BOOL)isStockedCardArrayNotZero:(NSMutableArray *)stockedArray;

@end
