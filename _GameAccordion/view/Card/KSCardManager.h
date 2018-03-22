//
//  KSCardManager.h
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/05.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSCard.h"

@interface KSCardManager : NSObject

//suitの要素数はColorMAX＝４とNumberMAX＝１３を掛けた数字であること
@property (nonatomic, retain) NSArray    *suit;
@property (nonatomic, retain) NSArray    *shuffledSuit;

+ (KSCardManager *)sharedManager;

- (NSArray *)getCards_OnMasuWidth:(CGFloat)masuWidth mode:(NSInteger)mode;

//touch event
//- (CGRect)getPreviouCard:(CGRect)activeCard;
//- (BOOL) isTouchedActiveCard:(CGRect)active  PreviousOne:(CGRect)pre;
//- (BOOL) isMovedActiveCard:(CGRect)active  PreviousOne:(CGRect)pre;

// test code
- (KSCard *)getACard:(CGSize)size;
- (NSArray *)shuffleSuit:(NSArray *)orderdSuit;

@end
