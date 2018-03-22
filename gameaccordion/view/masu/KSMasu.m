//
//  KSMasu.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/08.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSMasu.h"
#import "KSGlobalConst.h"

@implementation KSMasu

- (id)init {
    self = [self initWithSeven];
    
    return self;
}

-(id) initWithSeven{
    self = [self initWithMode];
    [self MasuForSeven];
    
    return self;
}

-(id) initWithFourteen{
    self = [self initWithMode];
    [self MasuForFourTeen];
    
    return self;

}

-(id) initWithTwentyone{
    self = [self initWithMode];
    [self MasuForTwentyOne];
    
    return self;    
}



-(id) initWithMode{
    if (self = [super init]) {
          
        self.isActivate = NO;
        
        //for testing
        self.hidden = NO; //default:YES
        self.backgroundColor = [UIColor blackColor]; //default: clearColor
    }
    
    return self;
}

-(void) MasuForSeven{
//    NSLog(@"mode 7");

    CGFloat width_7 = SCREEN_SIZE.width / 7;
    CGFloat height_7 = SCREEN_SIZE.height * 0.6;

    self.frame = CGRectMake(0, 0, width_7, height_7);
    self.masuWidth = width_7;
    
}

-(void)MasuForFourTeen{
//    NSLog(@"mode 14");
    CGFloat width_14 = SCREEN_SIZE.width / 7;
    CGFloat height_14 = SCREEN_SIZE.height * 0.4;

    self.frame = CGRectMake(0, 0, width_14, height_14);
    self.masuWidth  = width_14;
}

-(void)MasuForTwentyOne{
//    NSLog(@"mode 21");
    
    CGFloat width_21 = SCREEN_SIZE.width / 7;
    CGFloat height_21 = SCREEN_SIZE.height * MASU_dy_FOR_Twentyone;

    self.frame = CGRectMake(0, 0, width_21, height_21);
    self.masuWidth = width_21;

}



@end
