//
//  KSModeState.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/03.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSModeState.h"
//#import "KSCardManager.h"

@implementation KSModeState

static KSModeState    *_sharedInstance = nil;
 
#pragma mark geme general
-(NSInteger) card_max{
    return 1;
}

+ (KSModeState *)sharedMode {
    if ( !_sharedInstance ) {
        _sharedInstance = [self new];
    }
    
    return _sharedInstance;
    
}

 
#pragma mark card
- (NSArray *)getCards {
    NSArray    *arr = [NSArray new];
    
    return arr;
}

- (KSCard *)makeACard {
    KSCard    *card;
    
    return card;
}


 
#pragma mark utility




 
#pragma mark test
- (void)showMode {
    
}

@end
