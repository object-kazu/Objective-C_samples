//
//  KSFaceDataManager.m
//  smileMaker
//
//  Created by 清水 一征 on 13/02/27.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSFaceDataManager.h"

@implementation KSFaceDataManager

#pragma mark -- 初期化 --
static KSFaceDataManager * _sharedInstance = nil;

+ (KSFaceDataManager *)sharedManager {
    if ( !_sharedInstance ) {
        _sharedInstance = [[KSFaceDataManager alloc]init];
    }
    
    return _sharedInstance;
    
}

#pragma mark -- プロパティ --

- (NSManagedObjectContext *)managedObjectContext {
    NSError    *error;
    
    // インスタンス変数のチェック
    if ( managedObjectContext_ ) {
        return managedObjectContext_;
    }
    
    // 管理対象オブジェクトモデルの作成
    NSManagedObjectModel    *managedObjectModel;
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // 永続ストアコーディネータの作成
    NSPersistentStoreCoordinator    *persistentStoreCoordinator;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:managedObjectModel];
    
    // 保存ファイルの決定
    NSArray     *paths;
    NSString    *path = nil;
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ( [paths count] > 0 ) {
        path = [paths objectAtIndex:0];
        path = [path stringByAppendingPathComponent:@".face"];
        path = [path stringByAppendingPathComponent:@"faceimage.db"];
    }
    
    if ( !path ) {
        return nil;
    }
    
    // ディレクトリの作成
    NSString         *dirPath;
    NSFileManager    *fileMgr;
    dirPath = [path stringByDeletingLastPathComponent];
    fileMgr = [NSFileManager defaultManager];
    if ( ![fileMgr fileExistsAtPath:dirPath] ) {
        if ( ![fileMgr  createDirectoryAtPath:dirPath
                  withIntermediateDirectories:YES attributes:nil error:&error] ) {
            NSLog(@"Failed to create directory at path %@, erro %@",
                  dirPath, [error localizedDescription]);
        }
    }
    
    // ストアURLの作成
    NSURL    *url = nil;
    url = [NSURL fileURLWithPath:path];
    
    // 永続ストアの追加
    NSPersistentStore    *persistentStore;
    persistentStore = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                               configuration:nil URL:url options:nil error:&error];
    if ( !persistentStore && error ) {
        NSLog(@"Failed to create add persitent store, %@", [error localizedDescription]);
    }
    
    // 管理対象オブジェクトコンテキストの作成
    managedObjectContext_ = [[NSManagedObjectContext alloc] init];
    
    // 永続ストアコーディネータの設定
    [managedObjectContext_ setPersistentStoreCoordinator:persistentStoreCoordinator];
    
    return managedObjectContext_;
}

-(NSArray*) sortedDietNewOld{
    // 管理対象オブジェクトコンテキストを取得する
    NSManagedObjectContext* context;
    context = self.managedObjectContext;
    
    // 取得要求を作成する
    NSFetchRequest*         request;
    NSEntityDescription*    entity;
    NSSortDescriptor*       sortDescriptor;
    request = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"Face" inManagedObjectContext:context];
    [request setEntity:entity];
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    // 取得要求を実行する
    NSArray*    result;
    NSError*    error = nil;
    result = [context executeFetchRequest:request error:&error];
    if (!result) {
        // エラー
        NSLog(@"executeFetchRequest: failed, %@", [error localizedDescription]);
        
        return nil;
    }
    
    return result;
    
}



#pragma mark -- アイテムの操作 --
- (Face *)insertNewFace {
    NSManagedObjectContext    *context;
    context = self.managedObjectContext;
    
    Face                      *face;
    face = [NSEntityDescription insertNewObjectForEntityForName:@"Face" inManagedObjectContext:context];
    
    return face;
}

#pragma mark -- 永続化 --
- (void)save {
    // 保存
    NSError    *error;
    if ( ![self.managedObjectContext save:&error] ) {
        // エラー
        NSLog(@"Error, %@", error);
    }
}

@end
