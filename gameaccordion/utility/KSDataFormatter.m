//
//  KSDataFormatter.m
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/30.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSDataFormatter.h"

@implementation KSDataFormatter

- (NSDateComponents *)separateDateComponets:(NSDate *)date {
    // デフォルトのカレンダーを取得
    NSCalendar          *calendar = [NSCalendar currentCalendar];
    
    // 日時をカレンダーで年月日時分秒に分解する
    NSDateComponents    *dateComps = [calendar components:
                                      NSYearCalendarUnit   |
                                      NSMonthCalendarUnit  |
                                      NSDayCalendarUnit    |
                                      NSHourCalendarUnit   |
                                      NSMinuteCalendarUnit |
                                      NSSecondCalendarUnit
                                                 fromDate:date];
    
    //    NSLog(@"separateDateComponets:%d/%02d/%02d",  dateComps.year, dateComps.month, dateComps.day);
    
    return dateComps;
}


- (NSString *)displayDateFormatted:(NSDate *)date {
    NSDateComponents    *comp = [self separateDateComponets:date];
    
    return [NSString stringWithFormat:@"%ld/%02ld/%02ld", (long)comp.year, (long)comp.month, (long)comp.day];
}


@end
