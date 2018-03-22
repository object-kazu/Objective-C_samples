//
//  KSMasuManager.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/08.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSMasuManager.h"
#import "KSGlobalConst.h"
#import "KSMasu.h"
#import "KSDiviceHelper.h"

#import "KSMasuManagerContex.h"
#import "KSMasuStateForFourteen.h"
#import "KSMasuStateForseven.h"
#import "KSMasuStateForTwentyone.h"

@interface KSMasuManager ()

@property (nonatomic, retain) KSMasuManagerContex    *masuContex;

@end

@implementation KSMasuManager

static KSMasuManager    *_sharedInstance = nil;

+ (KSMasuManager *)sharedManager {
    if ( !_sharedInstance ) {
        _sharedInstance = [KSMasuManager new];
    }
    
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if ( !self ) {
        return nil;
    }
    self.masuArray       = @[].mutableCopy;
    self.masuCenterArray = @[].mutableCopy;
    
    self.masuContex = [KSMasuManagerContex new];
    
    return self;
}

- (void)selectGameMode:(NSInteger)mode {
    
    switch ((int)mode ) {
        case GAME_MODE_7:
            [self.masuContex changeMode:[KSMasuStateForseven sharedMode]];
            break;
            
        case GAME_MODE_14:
            [self.masuContex changeMode:[KSMasuStateForFourteen sharedMode]];
            break;
        case GAME_MODE_21:
            [self.masuContex changeMode:[KSMasuStateForTwentyone sharedMode]];
            break;
            
        default:
            NSLog(@"error at %@", NSStringFromSelector(_cmd));
            [self.masuContex changeMode:[KSMasuStateForseven sharedMode]];
            break;
    }
}

/**
 *  CGpointを配列から取り出す方法は
 *
 *  NSValue *val = [points objectAtIndex:0];
 *  CGPoint p = [val CGPointValue];
 *
 */

- (NSArray *)masuCenterArray {
    
    NSMutableArray    *arr = @[].mutableCopy;
    if ( [self.masuArray count] > 0 ) {
        for ( KSMasu *masu in self.masuArray ) {
            CGPoint    point = masu.center;
            [arr addObject:[NSValue valueWithCGPoint:point]];
        }
        
    } else {
        NSLog(@"error.  At first, should make masuArray");
    }
    
    return (NSArray *)arr;
    
}

- (CGFloat)getAMasuWidth {
    
    return [self makeOneMasu].frame.size.width;
}

- (KSMasu *)makeOneMasu {
    
    KSMasu    *masu = [self.masuContex makeOneMasu];
    
    return masu;
}

- (NSArray *)makeMasusByMode {
    self.masuArray = [self.masuContex makeMasusByMode];
    
    return self.masuArray;
}


- (KSMasu *)getMasuFromCGPoint:(CGPoint)point {
    
    KSMasu    *_masu_;
    for ( int i = 0; i < [self.masuArray count]; i++ ) {
        KSMasu    *masu = [self.masuArray objectAtIndex:i];
        if ( CGRectContainsPoint(masu.frame, point)) {
            _masu_ = masu;
        }
    }
    
    if ( _masu_ == nil ) {
        NSLog(@"error at %@", NSStringFromSelector(_cmd));
    }
    
    return _masu_;
}

- (KSMasu *)masuOfActiveCardBeforeMasu:(NSInteger)index activieMasu:(KSMasu *)masu {

    KSMasu* targetMasu = [self makeOneMasu];
    
    if ( index == masuBeforeOne || index == masuBeforeThree ) {
        
        // 1or3 つ前のmasuを探す
        
        NSInteger    previousIndex = masu.masuIndex - index;
        if ( previousIndex < 0 ) {
            
            targetMasu = nil;
            
        } else {
            
            for (KSMasu* _masu_ in self.masuArray) {
                if (previousIndex == _masu_.masuIndex ) {
                    targetMasu = _masu_;
                }
            }
        }
        
    } else {
        NSLog(@"index error at %@", NSStringFromSelector(_cmd));
        
        targetMasu = nil;
    }
    
    return targetMasu;
}

@end
