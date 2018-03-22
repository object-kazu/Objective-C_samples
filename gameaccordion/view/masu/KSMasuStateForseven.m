//
//  KSMasuStateForseven.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/21.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSMasuStateForseven.h"

@implementation KSMasuStateForseven
static  KSMasuManagerState *_sharedInstance = nil;

+(KSMasuManagerState*)sharedMode{
    _sharedInstance = [KSMasuStateForseven new];
    return _sharedInstance;
    
}


- (id)init {
    self = [super init];
    if ( !self ) {
        return nil;
    }
    
    return self;
}

-(NSArray*) makeMasusByMode{
    NSMutableArray    *masus = @[].mutableCopy;
    
    for ( int i = 0; i < MAX_7; i++ ) {
        KSMasu     *one           = [[KSMasu alloc] initWithSeven];
        CGFloat    oneWidth       = one.frame.size.width;
        CGFloat    firstMasuPosiX = oneWidth - (one.frame.size.width * 0.5);
             one.center = CGPointMake(oneWidth * (i + 1) - firstMasuPosiX, SCREEN_SIZE.height * 0.5);
        one.alpha  = 0.1 * (i + 1);
        one.masuIndex = i;
        [masus addObject:one];
    }
    
    return masus;

}

-(KSMasu*)makeOneMasu{
    KSMasu* masu = [[KSMasu alloc] initWithSeven];
    return masu;
}


#pragma mark - test
-(void) showMode{
    NSLog(@"masu manager 7");
}


@end
