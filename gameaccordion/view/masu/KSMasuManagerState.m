//
//  KSMasuManagerState.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/21.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSMasuManagerState.h"

@implementation KSMasuManagerState

static KSMasuManagerState *_sharedInstance = nil;



#pragma mark geme general
+ (KSMasuManagerState *)sharedMode {
    if ( !_sharedInstance ) {
        _sharedInstance = [self new];
    }
    
    return _sharedInstance;
    
}

-(NSArray*) makeMasusByMode{
    return @[];
}


-(KSMasu*)makeOneMasu{
    KSMasu* masu;
    return masu;
}

-(CGPoint) previousMasuOfActiveCard:(CGPoint)activeCenter{
    return CGPointZero;
}


-(void) showMode{
    
}


@end
