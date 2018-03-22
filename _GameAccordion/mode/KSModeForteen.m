//
//  KSModeForteen.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/03.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSModeForteen.h"

@implementation KSModeForteen

static KSModeState *_sharedInstance = nil;

 
#pragma mark game general
-(NSInteger) card_max{
    return MAX_14;
}

+(KSModeState*)sharedMode{
    
    _sharedInstance = [KSModeForteen new];
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
    return [[KSCardManager sharedManager] getCards_OnMasuWidth:width mode:GAME_MODE_14];

}

 
#pragma mark test
-(void) showMode{
    NSLog(@" mode14");
}

@end
