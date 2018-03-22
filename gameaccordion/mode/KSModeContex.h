//
//  KSModeContex.h
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/03.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSModeState.h"
#import "KSModeSeven.h"
#import "KSModeTwentyOne.h"
#import "KSModeForteen.h"

@interface KSModeContex : NSObject

@property (nonatomic,retain) KSModeState* currentModeState;

//game general
@property (nonatomic) NSInteger cardMAX;
-(void)changeMode:(KSModeState*) mode;

//card class
-(NSArray*) getCards;
-(KSCard*) makeACard;


//utility


//sample code
//-(void) say;


@end
