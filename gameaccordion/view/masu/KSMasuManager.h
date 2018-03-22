//
//  KSMasuManager.h
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/08.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

//TEST
#import "KSMasu.h"

@interface KSMasuManager : NSObject

@property (nonatomic,retain) NSArray* masuArray;
@property (nonatomic,retain) NSArray* masuCenterArray;

+(KSMasuManager*) sharedManager;

-(void) selectGameMode:(NSInteger)mode;
-(NSArray*) makeMasusByMode;

-(CGFloat) getAMasuWidth;
-(KSMasu*) makeOneMasu;


/* 
 CGpointで管理すると、iPhoneの種類によってうまく行かないので
 Masuで管理する方針に変更する。
*/
-(KSMasu*) getMasuFromCGPoint:(CGPoint) point;
-(KSMasu*) masuOfActiveCardBeforeMasu:(NSInteger)index activieMasu:(KSMasu*) masu;

@end
