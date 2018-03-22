//
//  KSEyeCatch.m
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/12.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSEyeCatch.h"
#import "KSGlobalConst.h"
#import <QuartzCore/QuartzCore.h>

@interface KSEyeCatch()

@property (nonatomic)  CGRect smallEyeCatchRect;


@end

@implementation KSEyeCatch

 
#pragma mark property
-(CGRect) eyeCatchRect{
    CGRect    rRect = CGRectMake(0,
                                 0,
                                 10,
                                 10);
    return rRect;
}

-(CGRect) smallEyeCatchRect{
    CGRect    rRect = CGRectMake(0,
                                 0,
                                 5,
                                 5);
    return rRect;

}


 
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        UILabel* smallEye = [[UILabel alloc] initWithFrame:self.smallEyeCatchRect];
        smallEye.backgroundColor = [UIColor clearColor];
        [self addSubview:smallEye];

    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
  }



//- (void)drawRect:(CGRect)rect
//{
//    // CGContextを用意する
//    CGContextRef    context = UIGraphicsGetCurrentContext();
//    
//    // CGGradientを生成する
//    // 生成するためにCGColorSpaceと色データの配列が必要になるので
//    // 適当に用意する
//    CGGradientRef      gradient;
//    CGColorSpaceRef    colorSpace;
//    size_t             num_locations = 2;
//    CGFloat            locations[2]  = { 0.0, 1.0 };
//    
//    //start color RGB
//    float              r = (float)255 / 255;
//    float              g = (float)236 / 255;
//    float              b = (float)202 / 255;
//    
//    CGFloat            components[12] = { r, g,            b,            0.5, //start color
//        r,            g,            b,            1.0,
//        0.5,          0.5,          0.5,          1.0 }; // end color
//    
//    colorSpace = CGColorSpaceCreateDeviceRGB();
//    gradient   = CGGradientCreateWithColorComponents(colorSpace, components,
//                                                     locations, num_locations);
//    
//    // 生成したCGGradientを描画する
//    // 始点と終点を指定してやると、その間に直線的なグラデーションが描画される。
//    // （横幅は無限大）
//    CGPoint    startPoint = CGPointMake(self.frame.size.width / 2, 0.0);
//    CGPoint    endPoint   = CGPointMake(self.frame.size.width / 2, self.frame.size.height);
//    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
//    
//    // GradientとColorSpaceを開放する
//    CGColorSpaceRelease(colorSpace);
//    CGGradientRelease(gradient);
//
//}




-(KSEyeCatch*) eyeCatchAt_Up_Left{
    
    KSEyeCatch* eye = [[KSEyeCatch alloc] initWithFrame:self.eyeCatchRect];
    eye.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 180 * M_PI/180);

    return eye;
    
}
-(KSEyeCatch*)eyeCatchAt_Up_Right{
    KSEyeCatch* eye = [[KSEyeCatch alloc] initWithFrame:self.eyeCatchRect];
    eye.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -90 * M_PI/180);

    return eye;

    
}

-(KSEyeCatch*)eyeCatchAt_Down_Left{
    KSEyeCatch* eye = [[KSEyeCatch alloc] initWithFrame:self.eyeCatchRect];
    eye.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 90 * M_PI/180);
    return eye;

    
}
-(KSEyeCatch*)eyeCatchAt_Down_Right{
    KSEyeCatch* eye = [[KSEyeCatch alloc] initWithFrame:self.eyeCatchRect];
    return eye;

    
}


@end
