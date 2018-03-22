//
//  KSPageView.m
//  gameaccordion
//
//  Created by 清水 一征 on 2014/03/13.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSPageView.h"
#import "KSGlobalConst.h"

//data
#import "Data.h"
#import "KSCoreDataController.h"
#import "KSDataFormatter.h"

#define DEFAULT_TITILE_FONT_SIZE 36

@interface KSPageView ()

#pragma mark - page parameters
@property (nonatomic) CGRect             ori;
@property (nonatomic) NSInteger          dx;
@property (nonatomic) NSInteger          dy;

@property (nonatomic, retain) UILabel    *titleLabel;

@property (nonatomic, retain) NSArray    *loadedData;
@property (nonatomic, retain) NSArray    *targetResults;
@property (nonatomic, retain) NSArray    *eyeCatchColorArray;
@property (nonatomic, retain) NSArray    *backgroundColorArray;

@end

@implementation KSPageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        // page size
        self.ori   = CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
        self.dx    = 10;
        self.dy    = 10;
        self.frame = CGRectInset(self.ori, self.dx * 2, self.dy * 2);

        //font size
        self.titileFontSize = DEFAULT_TITILE_FONT_SIZE;
        //eyecatch
        self.eyeCatchColorArray   = @[ACCENT_red, ACCENT_blue, ACCENT_green];
        self.backgroundColorArray = @[COLOR_red, COLOR_blue, COLOR_green];

        self.needReturnButton = NO;
        [self load];

    }

    return self;
}

- (BOOL)checkBackColor:(UIColor *)color {
    BOOL    isExist = NO;
    for ( int i = 0; i < [self.backgroundColorArray count]; i++ ) {
        UIColor    *target = [self.backgroundColorArray objectAtIndex:i];
        if ( [target isEqual:color] ) {
            isExist         = YES;
            self.colorIndex = i;
        }
    }

    return isExist;
}

- (UIColor *)eyeCatchColorFromBackColor:(UIColor *)color {
    if ( ![self checkBackColor:color] ) {
        NSLog(@"you should call checkBackColor method befor use! error at %@", NSStringFromSelector(_cmd));

        return nil;
    }

    return (UIColor *)[self.eyeCatchColorArray objectAtIndex:self.colorIndex];
}

- (void)makePage {
    //eyeCatch
    UIView    *eye = [[UIView alloc] initWithFrame:CGRectZero];
    eye.backgroundColor = [self eyeCatchColorFromBackColor:self.backColor];
    eye.frame           = CGRectMake(10, 10, EYE_CATCH_width, EYE_CATCH_height);
    [self addSubview:eye];

    self.titleLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, EYE_CATCH_width)];
    self.titleLabel.frame           = CGRectOffset(self.titleLabel.frame, 60, 10);
    self.titleLabel.text            = self.titile;
    self.titleLabel.textAlignment   = NSTextAlignmentCenter;
    self.titleLabel.textColor       = [UIColor whiteColor];
    self.titleLabel.font            = [UIFont fontWithName:APPLI_FONT size:self.titileFontSize];
    self.titleLabel.backgroundColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];

    CGRect     descriptRect = CGRectMake(0, 0, self.frame.size.width *0.95, EYE_CATCH_width*3);
    UILabel    *desctipt    = [[UILabel alloc] initWithFrame:descriptRect];
    desctipt.center        = self.center;
    desctipt.textAlignment = NSTextAlignmentCenter;
    desctipt.numberOfLines = 0;
    desctipt.lineBreakMode = NSLineBreakByWordWrapping;
    desctipt.text          = self.helpContents;
    desctipt.frame         = CGRectOffset(desctipt.frame, -1 * self.dx * 2, 0);
    desctipt.font          = [UIFont fontWithName:APPLI_FONT size:24];
    [self addSubview:desctipt];

    self.backgroundColor = self.backColor;

    if ( self.needReturnButton ) {
        [self addReturnButton];
    }

}


- (void)addReturnButton {
    
    CGFloat btn_width = 40.0f;
    CGFloat btn_height = 40.0f;
    
    UIButton    *options = [UIButton buttonWithType:UIButtonTypeCustom];
    options.frame = CGRectMake(self.frame.size.width - btn_width, self.frame.size.height -btn_height,
                               btn_width, btn_height);
    [options setBackgroundImage:[UIImage imageNamed:@"allow"] forState:UIControlStateNormal];
    
//    [options setBackgroundImage:[UIImage imageNamed:@"backAllow"] forState:UIControlStateNormal];
    [options addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    [self addSubview:options];

}

- (void) addimage:(UIImage*)img{
       UIImageView    *sampleImg = [UIImageView new];
       CGRect         imgFrame   = CGRectInset(self.frame, self.dx * 3, self.dy * 3);
       imgFrame = CGRectOffset(imgFrame, -2 * self.dx, -1.5 * self.dy);
       [sampleImg setFrame:imgFrame];
       [sampleImg setImage:img];
       sampleImg.contentMode = UIViewContentModeScaleAspectFit;
       [self addSubview:sampleImg];
}

- (void)addScoreOfMode:(NSInteger)mode {

    switch ( mode ) {
        case GAME_MODE_7:
            self.targetResults = [self.loadedData firstObject];
            [self writeScore];
            break;

        case GAME_MODE_14:
            self.targetResults = [self.loadedData objectAtIndex:1];
            [self writeScore];
            break;
        case GAME_MODE_21:
            self.targetResults = [self.loadedData lastObject];
            [self writeScore];
            break;

        default:
            NSLog(@"error at %@", NSStringFromSelector(_cmd));
            break;
    }

}

- (void)writeScore {
    //score
    KSDataFormatter    *df           = [KSDataFormatter new];
    CGFloat            labelHeight   = 30.0f;
    CGFloat            fontSize      = 20.0f;
    CGSize             dateLabelSize = CGSizeMake(240, labelHeight);

    CGFloat            scoreStartX = self.titleLabel.frame.origin.x + 70;
    CGFloat            scoreStartY = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 30;
    CGPoint            scoreOrigin = CGPointMake(scoreStartX, scoreStartY);

//    NSLog(@"data count %ld", (long)[self.targetResults count]);

    NSUInteger    bestFive = 0;
    if ( [self.targetResults count] > 6 ) {
        bestFive = 5;
    } else {
        bestFive = [self.targetResults count];
    }

    for ( int i = 0; i < bestFive; i++ ) {

        Data       *aData     = [self.targetResults objectAtIndex:i];
        UILabel    *dateLabel = [UILabel new];
        dateLabel.frame = CGRectMake(scoreOrigin.x, scoreOrigin.y + (labelHeight * i),
                                     dateLabelSize.width, dateLabelSize.height);
        
        NSString    *fDate = [df displayDateFormatted:aData.date];
        
        
        /**
         *  level normalの場合は何も表示しない
         */
        
        NSString* lString = @"";
        if (aData.level) {
            lString = [NSString stringWithFormat:@"(%@)", aData.level];
            dateLabel.text = [NSString stringWithFormat:@"%@     %@ %@", fDate, aData.remainCards,lString];

        }else{
            dateLabel.text = [NSString stringWithFormat:@"%@     %@", fDate, aData.remainCards];

        }
        
        dateLabel.font = [UIFont fontWithName:APPLI_FONT size:fontSize];
        [self addSubview:dateLabel];

    }

}

#pragma mark - --------- load ----------

- (void)load {

    self.loadedData = [[NSArray alloc] initWithObjects:
                       [KSCoreDataController sharedManager].sortedEntityByMode7,
                       [KSCoreDataController sharedManager].sortedEntityByMode14,
                       [KSCoreDataController sharedManager].sortedEntityByMode21, nil];

}

//  ---------- delegate  ----------
- (void)back {
    if ( [self.delegate respondsToSelector:@selector(callback:)] ) {
        [self.delegate callback:self];
    }
}

@end
