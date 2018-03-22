//
//  KSCardForTwentyone.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/14.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSCardManagerForTwentyone.h"

@implementation KSCardManagerForTwentyone
static  KSCardManagerState *_sharedInstance = nil;

+(KSCardManagerState*)sharedMode{
    _sharedInstance = [KSCardManagerForTwentyone new];
    return _sharedInstance;
    
}


- (id)init {
    self = [super init];
    if ( !self ) {
        return nil;
    }
    
    return self;
}

-(CGSize) calcSize:(CGFloat)width{
    if (width <=0) {
        NSLog(@"error at %@",NSStringFromSelector (_cmd));
    }
    
    CGFloat targetWidth = width* 0.6;
    CGFloat targetHeight = targetWidth * 1.618;
    CGSize s = CGSizeMake(targetWidth, targetHeight);
    return s;
    
}


 
#pragma mark test
-(void) showMode{
    NSLog(@"card manager 21");
}
-(NSInteger)displayMode{
    return GAME_MODE_21;
}


@end
