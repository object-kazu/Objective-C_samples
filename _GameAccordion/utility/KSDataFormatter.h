//
//  KSDataFormatter.h
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/30.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSDataFormatter : NSObject

//date formatter
- (NSString *)displayDateFormatted:(NSDate *)date;
- (NSDateComponents *)separateDateComponets:(NSDate *)date;


@end
