//
//  KSCardState.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/14.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSCardManagerState.h"

@implementation KSCardManagerState

static KSCardManagerState *_sharedInstance = nil;


 
#pragma mark geme general
+ (KSCardManagerState *)sharedMode {
    if ( !_sharedInstance ) {
        _sharedInstance = [self new];
    }
    
    return _sharedInstance;
    
}

-(CGSize) calcSize:(CGFloat)width {
    return CGSizeZero;
}

-(void) showMode{
    
}
-(NSInteger) displayMode{
    return 0;
}

@end
