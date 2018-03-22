//
//  KSMenuButton.m
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/29.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSMenuButton.h"
#import "KSGlobalConst.h"
#import "KSDiviceHelper.h"
#import <QuartzCore/QuartzCore.h>

const CGFloat    BUTTON_POSI_HEIGTHT = 0.8;
const CGFloat    BUTTON_POSI_MARGIN  = 10.0f;

#pragma mark - ---------- under line ----------
@interface LineLayer : CALayer

@property (nonatomic, retain) UIColor    *lineColor;

@end

@implementation LineLayer
- (void)drawInContext:(CGContextRef)ctx {
    CGMutablePathRef    path = CGPathCreateMutable();
    //配列で、描画する点を指定します。　指定した点同士をつなぐように直線を描きます。
    CGPoint             points[] = {
        CGPointMake(0,                      self.bounds.size.height),
        CGPointMake(self.bounds.size.width, self.bounds.size.height),
    };
    
    int                 numPoints = sizeof(points) / sizeof(points[0]);
    //点と点の数を指定して直線を描写します。
    CGPathAddLines(path, NULL, points, numPoints);
    
    CGContextAddPath(ctx, path);
    CGPathRelease(path);
    
    //線の色を設定
    UIColor    *lineColor_ = self.lineColor;
    CGContextSetStrokeColorWithColor(ctx, lineColor_.CGColor);
    CGContextSetLineWidth(ctx, 2.0);
    CGContextDrawPath(ctx, kCGPathStroke);
}

@end

#pragma mark - ---------- ここまで ----------

@interface KSMenuButton ()

@end

@implementation KSMenuButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        
        //共通
        [self setTitleColor:COLOR_MENU_Charactors forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:APPLI_FONT size:24];
        self.userInteractionEnabled = YES;
        
        //<tapped>
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        // <layer corner round>
        CALayer    *mLayer = [self layer];
        [mLayer setMasksToBounds:NO];
        [mLayer setCornerRadius:BUTTON_CORNER_ROUND];
        //<layer shadow>
        mLayer.shadowOpacity = 0.4;
        mLayer.shadowOffset  = SHADOW_OFFSET;
        mLayer.shadowColor   = [COLOR_MENU_Charactors CGColor];
        
        self.eyeCatch = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:self.eyeCatch];
        
        self.subjectLabel      = [[UILabel alloc] initWithFrame:CGRectZero];
        self.subjectLabel.font = [UIFont fontWithName:APPLI_FONT size:14];
        [self addSubview:self.subjectLabel];
        
        self.numberLabel      = [[UILabel alloc] initWithFrame:CGRectZero];
        self.numberLabel.font = [UIFont fontWithName:APPLI_FONT size:14];
        [self addSubview:self.numberLabel];
        
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.eyeCatch.frame           = CGRectMake(10, 10, 10, 10);
    self.eyeCatch.backgroundColor = COLOR_yellow;
    
    if ( !CGRectIsEmpty(self.subjectRect)) {
        self.subjectLabel.frame = self.subjectRect;
    }
    
    if ( !CGRectIsEmpty(self.numberRect)) {
        self.numberLabel.frame = self.numberRect;
    }
    
}


#pragma mark - ---------- each button ----------
- (KSMenuButton *)startButton {
    
    CGRect    rRect = CGRectMake(0,
                                 0,
                                 BUTTON_WIDTH,
                                 BUTTON_HEIGHT);
    
    KSMenuButton    *startButton = ({
        
        KSMenuButton *menuButton = [[KSMenuButton alloc]initWithFrame:rRect];
        CGFloat x_posi = LAND_SCREEN_SIZE.width * 0.5;
        menuButton.center = CGPointMake(x_posi, LAND_SCREEN_SIZE.height * BUTTON_POSI_HEIGTHT);
        menuButton.backgroundColor = COLOR_red;
        [menuButton setTitle:@"START" forState:UIControlStateNormal];
        
        //underline
        LineLayer *lineLayer = [LineLayer layer];
        lineLayer.frame = CGRectInset(menuButton.layer.bounds,
                                      0.0,
                                      MENU_LINE_BASE);
        
        lineLayer.lineColor = COLOR_MENU_Charactors;
        [menuButton.layer addSublayer:lineLayer];
        [lineLayer setNeedsDisplay];
        
        menuButton;
        
    });
    
    return startButton;
    
}


@end