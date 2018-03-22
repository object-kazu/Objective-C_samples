//
//  KSMenuButton.h
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/29.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSMenuButton : UIButton

@property (nonatomic, retain) UILabel    *eyeCatch; // one point accent
@property (nonatomic, retain) UILabel    *subjectLabel;
@property (nonatomic, retain) UILabel    *numberLabel;
@property (nonatomic) CGRect             subjectRect;
@property (nonatomic) CGRect             numberRect;

#pragma mark - --------- each button ----------
-(KSMenuButton*) startButton;

@end
