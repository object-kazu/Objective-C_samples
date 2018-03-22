//
//  Data.h
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/30.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Data : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * mode;
@property (nonatomic, retain) NSString * remain;

@end
