//  templete from
//  dataManager.h
//  concentration
//
//  Created by 清水 一征 on 11/07/13.
//  Copyright 2011 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameData; // xxxxxxxxxxxxxxxxxxxxxx modify xxxxxxxxxxxxxxxxxxxxxxxxxxx //

@interface dataManager : NSObject {
    NSManagedObjectContext *_managedObjectContext;
    
}

@property (nonatomic, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, readonly) NSArray *getData;
// 初期化
+ (dataManager*)sharedManager;

// アイテムの操作
- (GameData*)insertNewData;


// 永続化
- (void)save;

@end
