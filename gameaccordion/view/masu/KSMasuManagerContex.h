//
//  KSMasuManagerContex.h
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/21.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSMasuManagerState.h"
#import "KSMasuStateForFourteen.h"
#import "KSMasuStateForseven.h"
#import "KSMasuStateForTwentyone.h"

#import "KSMasu.h"

@interface KSMasuManagerContex : NSObject

@property (nonatomic, retain) KSMasuManagerState    *currentState;
- (void)changeMode:(KSMasuManagerState *)mode;
- (NSArray *)makeMasusByMode;

- (KSMasu *)makeOneMasu;
-(CGPoint) previousMasuOfActiveCard:(CGPoint)activeCenter;


//sample code
- (void)say;

@end
