//
//  KSModeSeven.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/03.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSModeSeven.h"
#import "KSCardManager.h"

@implementation KSModeSeven

static KSModeState *_sharedInstance = nil;

 
#pragma mark game general
-(NSInteger) card_max{
    return MAX_7;
}

+(KSModeState*)sharedMode{
    
    _sharedInstance = [KSModeSeven new];
    return _sharedInstance;
    
}


- (id)init {
    self = [super init];
    if ( !self ) {
        return nil;
    }

    return self;
}


 
#pragma mark card
-(NSArray*) getCards{
    CGFloat width = [[KSMasuManager sharedManager] getAMasuWidth];
    return [[KSCardManager sharedManager] getCards_OnMasuWidth:width mode:GAME_MODE_7];
}

 
#pragma mark utility




 
#pragma mark test
-(void) showMode{
    NSLog(@" mode7");
}


@end
