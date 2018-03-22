//
//  KSCardContext.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/14.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSCardManagerContext.h"

@implementation KSCardManagerContext
 
#pragma mark - general
-(void) changeMode:(KSCardManagerState *)mode{
    self.currentManagerState = nil;
    self.currentManagerState = mode;
}

-(CGSize) calcSize:(CGFloat)width{
    return [self.currentManagerState calcSize:width];
}



 
#pragma mark - test
-(void) say{
    [self.currentManagerState showMode];
}
-(NSInteger) displayMode{
    return [self.currentManagerState displayMode];
}

@end
