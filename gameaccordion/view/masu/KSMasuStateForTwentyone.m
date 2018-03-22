//
//  KSMasuStateForTwentyone.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/21.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSMasuStateForTwentyone.h"

@implementation KSMasuStateForTwentyone

static  KSMasuManagerState *_sharedInstance = nil;

+(KSMasuManagerState*)sharedMode{
    _sharedInstance = [KSMasuStateForTwentyone new];
    return _sharedInstance;
    
}


- (id)init {
    self = [super init];
    if ( !self ) {
        return nil;
    }
    
    return self;
}

-(KSMasu*)makeOneMasu{
    KSMasu* masu = [[KSMasu alloc] initWithTwentyone];
    return masu;
}

-(NSArray*) makeMasusByMode{
    NSMutableArray    *masus = @[].mutableCopy;
    
    for ( int i = 0; i < MAX_21; i++ ) {
        KSMasu     *one           = [[KSMasu alloc] initWithTwentyone];
        CGFloat    oneWidth       = one.frame.size.width;
        CGFloat    FIRST_MASU_POSI_X = oneWidth - (one.frame.size.width * 0.5);
        one.masuIndex = i;
        
        
        //三段表示にする！
//        CGFloat dy = 0.3f;
        CGFloat FIRST_MASU_POSI_Y = 0.24f;
        int        j = i;
        if ( i < 7 ) {
            one.center = CGPointMake(oneWidth * (j + 1) - FIRST_MASU_POSI_X,
                                     SCREEN_SIZE.height * FIRST_MASU_POSI_Y);
            one.alpha = 0.1 * (j + 1);
            
        } else if ( i >= 7 && i < 14 ) {
            j = i - 7;
            one.center = CGPointMake(oneWidth * (j + 1) - FIRST_MASU_POSI_X,
                                     SCREEN_SIZE.height * (FIRST_MASU_POSI_Y + MASU_dy_FOR_Twentyone));
            one.alpha = 0.85 - (0.1 * (j + 1));
            
        } else {
            j = i - 14;
            one.center = CGPointMake(oneWidth * (j + 1) - FIRST_MASU_POSI_X,
                                     SCREEN_SIZE.height * (FIRST_MASU_POSI_Y + MASU_dy_FOR_Twentyone*2));
            one.alpha = 0.1 * (j + 1);
            
        }
        
        [masus addObject:one];
    }
    
    return masus;

}

#pragma mark - test
-(void) showMode{
    NSLog(@"masu manager 21");
}

@end
