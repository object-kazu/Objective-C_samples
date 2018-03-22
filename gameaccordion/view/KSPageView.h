//
//  KSPageView.h
//  gameaccordion
//
//  Created by 清水 一征 on 2014/03/13.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSPageView : UIView

@property (nonatomic, retain) UIColor     *backColor;
@property (nonatomic, retain) NSString    *titile;
@property (nonatomic) CGFloat titileFontSize;
@property (nonatomic, retain) NSString    *helpContents;
@property (nonatomic) BOOL                needReturnButton;
@property (nonatomic, assign) id          delegate;

- (void)makePage;
- (void)addScoreOfMode:(NSInteger)mode;
- (void)addimage:(UIImage*)img;

//  ----------  for test  ----------
@property (nonatomic) NSInteger    colorIndex;

- (BOOL)checkBackColor:(UIColor *)color;
- (UIColor *)eyeCatchColorFromBackColor:(UIColor *)color;

@end

// ---------- delegate  ----------
@interface NSObject (KSPageView)

- (void)callback:(KSPageView *)page;

@end