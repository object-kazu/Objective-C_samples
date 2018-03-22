//
//  KSFaceDataManager.h
//  smileMaker
//
//  Created by 清水 一征 on 13/02/27.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Face.h"

@interface KSFaceDataManager : NSObject{
    NSManagedObjectContext* managedObjectContext_;
}

@property (nonatomic, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, readonly) NSArray* sortedDietNewOld;


// 初期化
+(KSFaceDataManager*)sharedManager;

// アイテムの操作
-(Face*)insertNewFace;


// 永続化
- (void)save;


@end
