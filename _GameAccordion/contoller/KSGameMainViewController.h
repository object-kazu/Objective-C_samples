//
//  KSGameMainViewController.h
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/29.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSGlobalConst.h"
//#import "KSGameField.h"
#import "RNGridMenu.h"


@interface KSGameMainViewController : UIViewController <RNGridMenuDelegate>

//@property (nonatomic,retain) KSGameField* gameField;
@property (nonatomic) NSInteger gameMode;

@end
