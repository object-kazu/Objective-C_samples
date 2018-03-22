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
        
        one.center = CGPointMake(oneWidth * (i + 1) - firstMasuPosiX, SCREEN_SIZE.width * 0.5);
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

//- (CGPoint)previousMasuOfActiveCard:(CGPoint)activeCenter {
//
//    //card selection時にOffsetを設定しているため
//    CGPoint    netActiveCenter = CGPointMake(activeCenter.x, activeCenter.y + CARD_SELECTION_OFFSET);
//    
//    //    NSLog(@"masuCenter : %@", [self.masuCenterArray description]);
//    
//    NSInteger    targetIndex = 0;
//    if ( [self.masuCenterArray count] == 0 ) {
//        NSLog(@"error at %@", NSStringFromSelector(_cmd));
//        
//    } else {
//        
//        for ( int i = 0; i < [self.masuCenterArray count]; i++ ) {
//            NSValue    *val   = [self.masuCenterArray objectAtIndex:i];
//            CGPoint    target = [val CGPointValue];
//            if ( CGPointEqualToPoint(target, netActiveCenter)) {
//                targetIndex = i;
//            }
//        }
//    }
//    
//    // 一つ前のセンターを探す
//    NSInteger    previousIndex = targetIndex - 1;
//    if ( previousIndex < 0 ) {
//        
//        return CGPointZero;
//    } else {
//        
//        NSValue    *val = [self.masuCenterArray objectAtIndex:previousIndex];
//        
//        return [val CGPointValue];
//    }
//}


#pragma mark - test
-(void) showMode{
    NSLog(@"masu manager 7");
}


@end
