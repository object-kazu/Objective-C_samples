//
//  KSViewController.h
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/29.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSGlobalConst.h"
#import "KSMenuAnimationHelper.h"
#import "RNGridMenu.h"


@interface KSStartViewController : UIViewController <RNGridMenuDelegate>

@property (nonatomic) NSInteger gameMode;


@end
