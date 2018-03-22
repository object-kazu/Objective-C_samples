//
//  GameCondition.h
//  virusCrusader
//
//  Created by 清水 一征 on 11/06/23.
//  Copyright (c) 2011 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cell_kin;

@interface GameCondition : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * playtime;
@property (nonatomic, retain) NSString * researcher;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSString * identifer;
@property (nonatomic, retain) NSSet* Games;
@property (nonatomic, retain) NSNumber * GameCounter;

@end
