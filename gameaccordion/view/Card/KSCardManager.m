//
//  KSCardManager.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/05.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSCardManager.h"
#import "KSGlobalConst.h"
#import "KSCardManagerContext.h"

//for NSDictionary
#define CARD_MAIN_COLOR @"maincolor"
#define EYECATCH_COLOR  @"eyecatchcolor"

@interface KSCardManager ()

@property (nonatomic, retain) NSMutableArray    *numberArray;
@property (nonatomic, retain) NSArray           *colorArray;
@property (nonatomic) CGFloat                   width;

@end

@implementation KSCardManager

static KSCardManager    *_sharedInstance = nil;

+ (KSCardManager *)sharedManager {
    if ( !_sharedInstance ) {
        _sharedInstance = [KSCardManager new];
    }

    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if ( !self ) {
        //notice center open

    }

    return self;
}

#pragma mark property & prep card
- (NSArray *)colorArray {
    NSArray    *arr = @[RED_CARD, BLUE_CARD, YELLOW_CARD, GREEN_CARD];

    return arr;
}

- (NSArray *)suit { //ランダムなカード一組を得る
    NSMutableArray    *cardInfo = @[].mutableCopy;

    NSInteger         indexForColor = 1;
    for ( NSString *color in self.colorArray ) {
        for ( NSInteger i = 0; i < CARD_NUMBER_MAX; i++ ) {
            CardID    cid;
            cid.numberID = i + 1; //1~13に補正する
            cid.colorID  = color;
            cid.tagID    = indexForColor * 100 + i;
            NSValue    *val = [NSValue value:&cid withObjCType:@encode(CardID)];
            [cardInfo addObject:val];
        }

        indexForColor++;
    }

    //    NSLog(@"cardInfo数：%d",[cardInfo count]);

    return cardInfo;

}

- (NSArray *)shuffledSuit {
    return [self shuffleSuit:self.suit];
}

- (NSArray *)shuffleSuit:(NSArray *)orderdSuit {

    NSMutableArray    *serialArray = (NSMutableArray *)orderdSuit;
    NSMutableArray    *randomArray = @[].mutableCopy;

    NSUInteger        counterMax = [serialArray count];
    for ( NSUInteger i = 0; i < counterMax; i++ ) {
        //        NSLog(@"i is %d",i);
        NSInteger     suitSize = [serialArray count];
        NSUInteger    index    = arc4random_uniform((u_int32_t)suitSize);
        [randomArray addObject:[serialArray objectAtIndex:index]];
        [serialArray removeObjectAtIndex:index];
        //        NSLog(@"serial %d, random %d",[serialArray count], [randomArray count]);

    }

    return randomArray;
}

- (KSCard *)insertCardID_ToCard:(KSCard *)targetCard cid:(CardID)cid {

    targetCard.tag              = cid.tagID;
    targetCard.number           = [NSString stringWithFormat:@"%ld", (long)cid.numberID];
    targetCard.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)cid.numberID];
    targetCard.backgroundColor  = [self stringConvertToUIColor:cid.colorID]; // cid.colorID;
    targetCard.cardColor        = cid.colorID;

    return targetCard;

}

- (UIColor *)stringConvertToUIColor:(NSString *)string {
    UIColor    *color;
    if ( [string isEqualToString:RED_CARD] ) {
        color = COLOR_red;
    } else if ( [string isEqualToString:BLUE_CARD] ) {
        color = COLOR_blue;
    } else if ( [string isEqualToString:GREEN_CARD] ) {
        color = COLOR_green;
    } else if ( [string isEqualToString:YELLOW_CARD] ) {
        color = COLOR_yellow;
    } else {
        NSLog(@"error at stringConvertToUIColor");
    }

    return color;
}

- (UIColor *)eyeCatchColorDependOnCard:(NSString *)string {
    UIColor    *color;
    if ( [string isEqualToString:RED_CARD] ) {
        color = ACCENT_red;
    } else if ( [string isEqualToString:BLUE_CARD] ) {
        color = ACCENT_blue;
    } else if ( [string isEqualToString:GREEN_CARD] ) {
        color = ACCENT_green;
    } else if ( [string isEqualToString:YELLOW_CARD] ) {
        color = ACCENT_yellow;
    } else {
        NSLog(@"error at stringConvertToUIColor");
    }

    return color;

}

- (CGSize)calcSizeWithMode:(NSInteger)mode {
    if ( self.width <= 0 ) { //widthを初期化すること！
        NSLog(@"error at %@", NSStringFromSelector(_cmd));
    }
    KSCardManagerContext    *mContex = [KSCardManagerContext new];

    switch ((int)mode ) {
        case GAME_MODE_7:
            [mContex changeMode:[KSCardManagerForSeven sharedMode]];
            break;
        case GAME_MODE_14:
            [mContex changeMode:[KSCardManagerForFourteen sharedMode]];
            break;
        case GAME_MODE_21:
            [mContex changeMode:[KSCardManagerForTwentyone sharedMode]];
            break;

        default:
            NSLog(@"error at %@", NSStringFromSelector(_cmd));

            return CGSizeZero;
            break;
    }

    return [mContex calcSize:self.width];
}

- (NSInteger)fontSizeWithMode:(NSInteger)mode {
    NSInteger    i = 0;

    switch ((int)mode ) {
        case GAME_MODE_7:
            i = 58;
            break;
        case GAME_MODE_14:
            i = 42;
            break;
        case GAME_MODE_21:
            i = 42;
            break;

        default:
            NSLog(@"error at %@", NSStringFromSelector(_cmd));
            i = 0;
            break;
    }

    return i;
}

- (NSArray *)getCards_OnMasuWidth:(CGFloat)masuWidth mode:(NSInteger)mode {
    NSMutableArray    *cardArray = @[].mutableCopy;
    NSInteger         suitMax    = CARD_COLOR_MAX * CARD_NUMBER_MAX;
    NSArray           *arr       = [[KSCardManager sharedManager] shuffledSuit];

    self.width = masuWidth;
    CGSize            aSize = [self calcSizeWithMode:mode];

    for ( int i = 0; i < suitMax; i++ ) {
        CardID     cid;
        NSValue    *val = [arr objectAtIndex:i];
        [val getValue:&cid];
        UIColor    *eColor = [self eyeCatchColorDependOnCard:cid.colorID];
        KSCard     *card   = [[KSCard alloc] initWithSize:aSize
                                                 eyeColor:eColor
                                                 fontSize:[self fontSizeWithMode:mode]];
        card = [self insertCardID_ToCard:card cid:cid];
        [cardArray addObject:card];
    }

    //for debug
    //    for (KSCard *card in cardArray) {
    //        NSLog(@"At_CardID id:%d,Number:%@, color:%@",card.tag,card.number,card.color);
    //    }

    return (NSArray *)cardArray;

}

#pragma mark - card contact

//test
- (KSCard *)getACard:(CGSize)size {
    KSCard    *card = [[KSCard alloc] initWithSize:CGSizeZero eyeColor:COLOR_red fontSize:0];

    return card;
}

@end
