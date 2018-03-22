//
//  KSMasu.h
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/08.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSCard.h"

@interface KSMasu : UIView

- (id)initWithSeven;
- (id)initWithFourteen;
- (id)initWithTwentyone;
- (id)initWithMode;

@property (nonatomic) NSInteger    masuIndex;
@property (nonatomic) BOOL         isActivate;
@property (nonatomic) CGFloat      masuWidth;

@end
