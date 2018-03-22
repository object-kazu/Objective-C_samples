//
//  KSCard.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/05.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSCard.h"
#import "KSGlobalConst.h"
#import  <QuartzCore/QuartzCore.h>

#define SHADOW_OFF 0.0
#define SHADOW_ON  0.6

@interface KSCard ()

@property (nonatomic) CGPoint            up_Left_Center;
@property (nonatomic) CGPoint            down_Left_Center;
@property (nonatomic) CGPoint            up_Right_Center;
@property (nonatomic) CGPoint            down_Right_Center;
@property (nonatomic, retain) UIColor    *eyeCatchColor;
@property (nonatomic) BOOL               shadowFlag;

@end

@implementation KSCard

#pragma mark - property

- (CGPoint)up_Left_Center {
    CGPoint    p = CGPointZero;
    if ( self.eyeCatchUpLeft == nil ) {
        NSLog(@"eyeCatch object nil");
    } else {
        CGFloat    dx = CGRectGetWidth(self.eyeCatchUpLeft.frame) * 0.5;
        CGFloat    dy = CGRectGetHeight(self.eyeCatchUpLeft.frame) * 0.5;
        p = CGPointMake(dx, dy);
        
    }
    
    return p;
}

- (CGPoint)up_Right_Center {
    CGPoint    p = CGPointZero;
    if ( self.eyeCatchUpRight == nil ) {
        NSLog(@"eyeCatch object nil");
    } else {
        CGFloat    base_x = CGRectGetMaxX(self.frame);
        CGFloat    dx     = CGRectGetWidth(self.eyeCatchUpRight.frame) * 0.5;
        CGFloat    dy     = CGRectGetHeight(self.eyeCatchUpRight.frame) * 0.5;
        p = CGPointMake(base_x - dx, dy);
        
    }
    
    return p;
    
}

- (CGPoint)down_Left_Center {
    CGPoint    p = CGPointZero;
    if ( self.eyeCatchDownLeft == nil ) {
        NSLog(@"eyeCatch object nil");
    } else {
        CGFloat    base_y = CGRectGetMaxY(self.frame);
        CGFloat    dx     = CGRectGetWidth(self.eyeCatchDownLeft.frame) * 0.5;
        CGFloat    dy     = CGRectGetHeight(self.eyeCatchDownLeft.frame) * 0.5;
        p = CGPointMake(dx, base_y - dy);
        
    }
    
    return p;
    
}

- (CGPoint)down_Right_Center {
    CGPoint    p = CGPointZero;
    if ( self.eyeCatchDownRight == nil ) {
        NSLog(@"eyeCatch object nil");
    } else {
        CGFloat    base_x = CGRectGetMaxX(self.frame);
        CGFloat    base_y = CGRectGetMaxY(self.frame);
        CGFloat    dx     = CGRectGetWidth(self.eyeCatchDownRight.frame) * 0.5;
        CGFloat    dy     = CGRectGetHeight(self.eyeCatchDownRight.frame) * 0.5;
        p = CGPointMake(base_x - dx, base_y - dy);
        
    }
    
    return p;
    
}

#pragma mark -
- (id)initWithSize:(CGSize)csize eyeColor:(UIColor *)color fontSize:(NSInteger)fsize {
    
    if ( self = [super init] ) {
        self.frame                  = CGRectMake(0, 0, csize.width, csize.height);
        self.userInteractionEnabled = YES;
        self.hidden                 = NO;
        
        //shadow
        CALayer    *shadowLayer = [self layer];
        shadowLayer.shadowOpacity = SHADOW_OFF;
        shadowLayer.shadowColor   = [[UIColor blackColor] CGColor];
        shadowLayer.shadowOffset  = CGSizeMake(3, 3);
        self.shadowFlag           = NO;
        
        //cardNumberを表示するラベル
        self.numberLabel = [UILabel new];
        CGRect    rec = self.frame;
        self.numberLabel.frame  = CGRectMake(rec.size.width * 0.5, rec.size.height * 0.5, 60, 60);
        self.numberLabel.center = CGPointMake(CGRectGetMidX(self.frame),
                                              CGRectGetMidY(self.frame));
        self.numberLabel.backgroundColor = [UIColor clearColor];
        self.numberLabel.textAlignment   = NSTextAlignmentCenter;
        self.numberLabel.font            = [UIFont fontWithName:APPLI_FONT size:fsize];
        
        [self addSubview:self.numberLabel];
        
        self.eyeCatchColor = color;
        [self addEyeCatch];
        
        //active card
        self.isActived = NO;
        
        //drug
        UIPanGestureRecognizer    *panCard = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(ksCardDrag:)];
        [self addGestureRecognizer:panCard];
        
    }
    
    return self;
    
}

- (id)init {
    NSLog(@"initiWithWidthを通すこと、エラーです");
    
    return [self initWithSize:CGSizeZero eyeColor:COLOR_red fontSize:100];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark - eyeCatch
- (void)addEyeCatch {
    
    //up-Left
    self.eyeCatchUpLeft                 = [KSEyeCatch new].eyeCatchAt_Up_Left;
    self.eyeCatchUpLeft.center          = self.up_Left_Center;
    self.eyeCatchUpLeft.backgroundColor = self.eyeCatchColor;
    [self addSubview:self.eyeCatchUpLeft];
    
    //up-Right
    self.eyeCatchUpRight                 = [KSEyeCatch new].eyeCatchAt_Up_Right;
    self.eyeCatchUpRight.center          = self.up_Right_Center;
    self.eyeCatchUpRight.backgroundColor = self.eyeCatchColor;
    [self addSubview:self.eyeCatchUpRight];
    
    //down-Right
    self.eyeCatchDownRight                 = [KSEyeCatch new].eyeCatchAt_Down_Right;
    self.eyeCatchDownRight.center          = self.down_Right_Center;
    self.eyeCatchDownRight.backgroundColor = self.eyeCatchColor;
    [self addSubview:self.eyeCatchDownRight];
    
    //down-Left
    self.eyeCatchDownLeft                 = [KSEyeCatch new].eyeCatchAt_Down_Left;
    self.eyeCatchDownLeft.center          = self.down_Left_Center;
    self.eyeCatchDownLeft.backgroundColor = self.eyeCatchColor;
    [self addSubview:self.eyeCatchDownLeft];
    
}

#pragma mark - ---------- touch ----------
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch    *touch = [touches anyObject];
  
    self.isActived = YES;
    
    [self toggleShadow];
    CGRect    ori = touch.view.frame;
    
    touch.view.frame = CGRectOffset(ori, 0, -1 * CARD_SELECTION_OFFSET);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CARD_TOUCH_START object:nil];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // touchで選択Cardの色を変化させる
    UITouch    *touch = [touches anyObject];
    
    if ( touch.view.tag == 1 ) {
//        NSLog(@"touchted");
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch    *touch = [touches anyObject];
    
    [self toggleShadow];
    self.isActived = NO;
    
    CGRect    ori = touch.view.frame;
    touch.view.frame = CGRectOffset(ori, 0, CARD_SELECTION_OFFSET);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CARD_TOUCH_END object:nil];
}

- (void)ksCardDrag:(UIPanGestureRecognizer *)sender {
    
    CGPoint    p         = [sender translationInView:self];
    CGPoint    movePoint = CGPointMake(self.center.x + p.x, self.center.y + p.y);
    
    self.center = movePoint;
    [sender setTranslation:CGPointZero inView:self];
    
    // ドラッグ移動 or ドラッグ終了
    if ( sender.state == UIGestureRecognizerStateEnded ) {
        
        CGRect    ori = self.frame;
        [self toggleShadow];
        self.frame = CGRectOffset(ori, 0, CARD_SELECTION_OFFSET);
        [[NSNotificationCenter defaultCenter] postNotificationName:CARD_TOUCH_END object:nil];
        
    }
    
}

- (void)toggleShadow {
    if ( self.shadowFlag ) {
        self.layer.shadowOpacity = SHADOW_OFF;
        self.shadowFlag          = NO;

    } else if ( !self.shadowFlag ) {
        self.layer.shadowOpacity = SHADOW_ON;
        self.shadowFlag = YES;
    }
}

@end
