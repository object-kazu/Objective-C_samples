//
//  Face.h
//  smileMaker
//
//  Created by 清水 一征 on 13/05/07.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Face : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSData * smileImage;

@end
