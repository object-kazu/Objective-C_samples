//
//  KSCoreDataController.h
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/30.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KSGlobalConst.h"
#import "Data.h"

@interface KSCoreDataController : NSObject
{
    NSManagedObjectContext    *_managedObjectContext;
}


@property (nonatomic, readonly) NSManagedObjectContext    *managedObjectContext;


// 初期化
+ (KSCoreDataController *)sharedManager;

// アイテムの操作
- (Data *)insertNewEntity;
- (NSArray *)sortedEntity:(BOOL)fromOld_toNew;
- (NSArray *)sortedEntityByScore;

// 永続化
- (void)save;


@end
