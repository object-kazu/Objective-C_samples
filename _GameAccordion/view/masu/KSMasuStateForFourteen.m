//
//  KSMasuStateForFourteen.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/21.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSMasuStateForFourteen.h"

@implementation KSMasuStateForFourteen

static  KSMasuManagerState *_sharedInstance = nil;

+(KSMasuManagerState*)sharedMode{
    _sharedInstance = [KSMasuStateForFourteen new];
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
    
    for ( int i = 0; i < MAX_14; i++ ) {
        KSMasu     *one           = [[KSMasu alloc] initWithFourteen];
        CGFloat    oneWidth       = one.frame.size.width;
        CGFloat    firstMasuPosiX = oneWidth - (one.frame.size.width * 0.5);
        one.masuIndex = i;
        
        //２段表示するように！
        int        j = i;
        if ( i < 7 ) {
            one.center = CGPointMake(oneWidth * (j + 1) - firstMasuPosiX, SCREEN_SIZE.width * 0.3);
            one.alpha  = 0.1 * (j + 1);
            
        } else {
            j = i - 7;
            //            NSLog(@"i:%d, j%d",i,j);
            one.center = CGPointMake(oneWidth * (j + 1) - firstMasuPosiX, SCREEN_SIZE.width * 0.7);
            //            one.backgroundColor = RGBA(100, 100, 100, 0.1);
            one.alpha = 0.85 - (0.1 * (j + 1));
            
        }
        [masus addObject:one];
    }
    
    return masus;

}

-(KSMasu*)makeOneMasu{
    KSMasu* masu = [[KSMasu alloc] initWithFourteen];
    return masu;
}


#pragma mark - test
-(void) showMode{
    NSLog(@"masu manager 14");
}



@end
