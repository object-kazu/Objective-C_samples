//
//  KSGameField.m
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/30.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSGameField.h"

@implementation KSGameField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 識別用設定
        self.backgroundColor = [UIColor greenColor];
        self.userInteractionEnabled = YES;

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // CGContextを用意する
    CGContextRef    context = UIGraphicsGetCurrentContext();
    
    // CGGradientを生成する
    // 生成するためにCGColorSpaceと色データの配列が必要になるので
    // 適当に用意する
    CGGradientRef      gradient;
    CGColorSpaceRef    colorSpace;
    size_t             num_locations = 2;
    CGFloat            locations[2]  = { 0.0, 1.0 };
    
    //start color RGB
    float              r = (float)255 / 255;
    float              g = (float)236 / 255;
    float              b = (float)202 / 255;
    
    CGFloat            components[12] = { r, g,   b,   0.5, //start color
        r,            g,   b,   1.0,
        0.5,          0.5, 0.5, 1.0 }; // end color
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    gradient   = CGGradientCreateWithColorComponents(colorSpace, components,
                                                     locations, num_locations);
    
    // 生成したCGGradientを描画する
    // 始点と終点を指定してやると、その間に直線的なグラデーションが描画される。
    // （横幅は無限大）
    CGPoint    startPoint = CGPointMake(self.frame.size.width / 2, 0.0);
    CGPoint    endPoint   = CGPointMake(self.frame.size.width / 2, self.frame.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    // GradientとColorSpaceを開放する
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
}

@end
