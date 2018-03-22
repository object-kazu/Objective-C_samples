//
//  KSEyeCatch.h
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/12.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSEyeCatch : UIView

@property (nonatomic)  CGRect eyeCatchRect;

-(KSEyeCatch*)eyeCatchAt_Up_Left;
-(KSEyeCatch*)eyeCatchAt_Up_Right;
-(KSEyeCatch*)eyeCatchAt_Down_Left;
-(KSEyeCatch*)eyeCatchAt_Down_Right;

@end
