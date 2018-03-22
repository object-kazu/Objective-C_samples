//
//  DataController.m
//  luckyToday
//
//  Created by 清水 一征 on 12/09/12.
//  Copyright 2012年 momiji-mac.com. All rights reserved.
//

#import "DataController.h"

@implementation DataController

-(id) init  {
    if( (self=[super init])) {
        _isDateExist = YES;
        _LAUNCH = @"lastDate";
	}
    return self;
}
-(void)save_data{
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *today = [NSDate date];
    [defaults setObject:today forKey:_LAUNCH];
    
    NSNumber* uData = @(_upData);
    NSNumber* dData= @(_downData);
    NSNumber* pData=@(_playTimeData);
    
    [defaults setObject:uData forKey:@"up"];
    [defaults setObject:dData forKey:@"down"];
    [defaults setObject:pData forKey:@"playTime"];
    
    [defaults synchronize];
    
}

-(NSDate*)load_data{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *date_launch = [defaults objectForKey:_LAUNCH];
    if ( ! date_launch) {
        NSLog(@"%@", @"データが存在しません。");
        _isDateExist = NO;
        NSDate *today = [NSDate date];
        [defaults setObject:today forKey:@"launchedDate"];
        _launchedDate = today;
        _upData= 0;
        _downData=0;
        _playTimeData =1;
        
        NSLog(@"today is setted");
        
    }else{
        _launchedDate = date_launch;
        _upData = [[defaults objectForKey:@"up"] floatValue];
        _downData= [[defaults objectForKey:@"down"] floatValue];
        _playTimeData = [[defaults objectForKey:@"playTime"] floatValue];
    }
    return _launchedDate;
}

-(NSArray*)load_Score{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSNumber *upScore = [defaults objectForKey:@"up"];
    NSNumber *downScore = [defaults objectForKey:@"down"];
    NSNumber *playScore = [defaults objectForKey:@"playTime"];
            
    NSArray *array = [NSArray arrayWithObjects:upScore,downScore,playScore, nil];

    CCLOG(@"u:%@",[array objectAtIndex:0]);
    CCLOG(@"u:%@",[array objectAtIndex:1]);
    CCLOG(@"u:%@",[array objectAtIndex:2]);
    
    return array;
}


-(bool) isStartGame:(NSString *)today lastDate:(NSString *)lastDate{
    return [today isEqualToString:lastDate];
}
-(NSString*)formattingDate:(NSDate *)date{
    NSDateFormatter *df = [[[NSDateFormatter alloc]init]autorelease];
    df.dateFormat = @"yyyy/MM/dd";
    NSString *str = [df stringFromDate:date];
    CCLOG(@"formatting date is %@",str);
    return str;
}

@end
