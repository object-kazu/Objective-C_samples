//
//  Data.h
//  gameaccordion
//
//  Created by 清水 一征 on 2014/03/11.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Data : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * mode;
@property (nonatomic, retain) NSString * remainCards;
@property (nonatomic, retain) NSString * level;

@end
