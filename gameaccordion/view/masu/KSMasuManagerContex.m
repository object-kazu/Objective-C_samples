//
//  KSMasuManagerContex.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/21.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSMasuManagerContex.h"

@implementation KSMasuManagerContex

#pragma mark - general
-(void) changeMode:(KSMasuManagerState *)mode{
    self.currentState = nil;
    self.currentState = mode;
}
-(NSArray*) makeMasusByMode{
    return [self.currentState makeMasusByMode];
}


-(KSMasu*)makeOneMasu{
    return [self.currentState makeOneMasu];
}

-(CGPoint) previousMasuOfActiveCard:(CGPoint)activeCenter{
    return [self.currentState previousMasuOfActiveCard:activeCenter];
}


#pragma mark - test
-(void) say{
    [self.currentState showMode];
}


@end
