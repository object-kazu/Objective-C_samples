//
//  KSModeContex.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/03.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSModeContex.h"


@implementation KSModeContex


 
#pragma mark game general
-(NSInteger) cardMAX{
    return self.currentModeState.card_max;
}

-(void) changeMode:(KSModeState *)mode{
    self.currentModeState = nil;
    self.currentModeState = mode;
}



 
#pragma mark card
-(NSArray*) getCards{
        return [self.currentModeState getCards];
}
-(KSCard*) makeACard{
    return [self.currentModeState makeACard];
}


 
#pragma mark utility



 
#pragma mark test
//-(void) say{
//    [self.currentModeState showMode];
//}

@end
