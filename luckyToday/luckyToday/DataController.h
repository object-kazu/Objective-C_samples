//
//  DataController.h
//  luckyToday
//
//  Created by 清水 一征 on 12/09/12.
//  Copyright 2012年 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DataController : CCLayer {
    
}

@property (nonatomic,assign) NSDate *launchedDate;
@property (nonatomic ,assign) NSDate *lastDate;
@property (nonatomic) bool isDateExist;
@property (nonatomic) float upData;
@property (nonatomic) float downData;
@property (nonatomic) float playTimeData;
@property (nonatomic,assign) NSString* LAUNCH;

-(void)save_data;
-(NSDate*)load_data;
-(NSString*)formattingDate:(NSDate*)date;
-(bool) isStartGame:(NSString*)today lastDate:(NSString*)lastDate;

-(NSArray*)load_Score;

@end
