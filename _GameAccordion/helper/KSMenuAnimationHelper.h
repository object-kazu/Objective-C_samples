//
//  KSMenuAnimationHelper.h
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/30.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSMenuAnimationHelper : NSObject

@property (nonatomic, assign) id                delegate;
@property (nonatomic, retain) UIView    *startButton;
@property (nonatomic, retain) UIView    *showRecordButton;

- (id)initWithViewsArray:(NSArray *)array;
- (void)showMenu;
- (void)hideMenu:(id)sender;
- (void) changeModeFromHidden:(UIView*)hButton ToShow:(UIView*) sButton;

@end



#pragma mark - --- child view delegate ---------
@interface NSObject (KSMenuAnimationHelper)

- (void)pushedShowResultsButton:(KSMenuAnimationHelper *)helper;
- (void)pushedStartButton:(KSMenuAnimationHelper *)helper;

@end
