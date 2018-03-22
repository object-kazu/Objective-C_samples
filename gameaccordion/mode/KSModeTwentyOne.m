//
//  KSModeTwentyOne.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/03.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSModeTwentyOne.h"

@implementation KSModeTwentyOne

static KSModeState *_sharedInstance = nil;

 
#pragma mark game general
-(NSInteger) card_max{
    return MAX_21;
}

+(KSModeState*)sharedMode{
    
    _sharedInstance = [KSModeTwentyOne new];
    return _sharedInstance;
    
}

- (id)init {
    self = [super init];
    if ( !self ) {
        self.cardFrame = CGRectMake(0, 0, 50, 50);

        return nil;
    }
    
    return self;
}

 
#pragma mark card
-(NSArray*) getCards{
    CGFloat width = [[KSMasuManager sharedManager] getAMasuWidth];
    return [[KSCardManager sharedManager] getCards_OnMasuWidth:width mode:GAME_MODE_21];
}



#pragma mark test
-(void) showMode{
    NSLog(@" mode21");
}

@end
