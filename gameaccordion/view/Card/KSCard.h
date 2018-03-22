//
//  KSCard.h
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/05.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSEyeCatch.h"

@interface KSCard : UIView

@property (nonatomic,retain) NSString* number;
@property (nonatomic,retain) UILabel* numberLabel;
@property (nonatomic,retain) NSString* cardColor;
@property (nonatomic) BOOL isActived;

//eyeCatch
@property (nonatomic,retain) KSEyeCatch* eyeCatchUpLeft;
@property (nonatomic,retain) KSEyeCatch* eyeCatchUpRight;
@property (nonatomic,retain) KSEyeCatch* eyeCatchDownLeft;
@property (nonatomic,retain) KSEyeCatch* eyeCatchDownRight;


-(id) initWithSize:(CGSize)size eyeColor:(UIColor*)color fontSize:(NSInteger)size;




@end
