//
//  KSMasuManagerState.h
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/21.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSGlobalConst.h"
#import "KSMasu.h"

@interface KSMasuManagerState : NSObject

+ (KSMasuManagerState *)sharedMode;
- (NSArray *)makeMasusByMode;
- (KSMasu *)makeOneMasu;
- (CGPoint)previousMasuOfActiveCard:(CGPoint)activeCenter;

//test
- (void)showMode;

@end
