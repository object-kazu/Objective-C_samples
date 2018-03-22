//
//  KSModeButton.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/03/04.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSModeButton.h"
#import "KSGlobalConst.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark -  -------- Line layer for design ---------
@interface LineLayer : CALayer

@property (nonatomic, retain) UIColor    *lineColor;

@end

#pragma mark -  ---------- KSModeButton Private -----------
@interface KSModeButton ()

@property (nonatomic, retain) UIPanGestureRecognizer    *pan;
@property (nonatomic, assign) CGFloat                   dy;

@end

#pragma mark -   ---------- KSModeButton.m ------------
@implementation KSModeButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {

        //drug
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                           action:@selector(ksCardDrag:)];
        [self addGestureRecognizer:self.pan];
        self.alpha = 1.0f;
        self.dy    = 0;
    }

    return self;
}

- (void)ksCardDrag:(UIPanGestureRecognizer *)sender {

    CGPoint    p         = [sender translationInView:self];
    CGPoint    movePoint = CGPointMake(self.center.x + p.x, self.center.y);

    self.center = movePoint;
    self.dy    += p.x;

    [sender setTranslation:CGPointZero inView:self];

    // ドラッグ移動 or ドラッグ終了
    if ( sender.state == UIGestureRecognizerStateEnded ) {

        if ( self.dy > 0 ) {
            [[NSNotificationCenter defaultCenter] postNotificationName:BUTTON_SLIDE_LEFT object:nil];

        } else if ( self.dy <= 0 ) {
            [[NSNotificationCenter defaultCenter] postNotificationName:BUTTON_SLIDE_RIGHT object:nil];

        }
        self.dy = 0;
    }

}

- (KSModeButton *)modeButton:(NSInteger)mode {

    CGRect    rect =  CGRectMake(0,
                                 0,
                                 BUTTON_WIDTH,
                                 BUTTON_HEIGHT);

    KSModeButton    *modeBtn = ({

                                    KSModeButton *btn = [[KSModeButton alloc] initWithFrame:rect];
                                    btn.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HIGHT * 0.5);
                                    btn.backgroundColor = COLOR_green;

                                    //underline
                                    LineLayer *lineLayer = [LineLayer layer];
                                    lineLayer.frame = CGRectInset(btn.layer.bounds,
                                                                  0.0,
                                                                  MENU_LINE_BASE);

                                    lineLayer.lineColor = COLOR_red;
                                    [btn.layer addSublayer:lineLayer];
                                    [lineLayer setNeedsDisplay];

                                    btn;
                                });

#define POSI_Y_ADJUST_AT_ENDING 10

    UILabel    *modeLabel = [UILabel new];
    modeLabel.frame = CGRectMake(10,
                                 10,
                                 250,
                                 50);

    modeLabel.center = CGPointMake(modeBtn.frame.size.width * 0.5,
                                   modeBtn.frame.size.height * 0.5 - POSI_Y_ADJUST_AT_ENDING);
    modeLabel.text            = [NSString stringWithFormat:@"%ld", (long)mode];
    modeLabel.textAlignment   = NSTextAlignmentCenter;
    modeLabel.font            = [UIFont fontWithName:APPLI_FONT size:24];
    modeLabel.backgroundColor = [UIColor clearColor];
    [modeBtn addSubview:modeLabel];

    return modeBtn;

}

@end
