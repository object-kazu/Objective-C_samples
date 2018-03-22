//
//  KSModeState.h
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/03.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSCard.h"
#import "KSCardManager.h"
#import "KSMasuManager.h"
#import "KSGlobalConst.h"

@interface KSModeState : NSObject

@property (nonatomic) CGRect cardFrame;

//general
-(NSInteger) card_max;
+(KSModeState*) sharedMode;

//card
-(NSArray*) getCards;
-(KSCard*) makeACard;


//utility


//test
-(void) showMode;

@end
