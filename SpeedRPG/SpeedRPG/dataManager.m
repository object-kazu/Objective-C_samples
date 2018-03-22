//  templete from
//  dataManager.m
//  concentration
//
//  Created by 清水 一征 on 11/07/13.
//  Copyright 2011 momiji-mac.com. All rights reserved.
//

#import "dataManager.h"
#import "GameData.h"   // xxxxxxxxxxxxxxxxxxxxxx modify xxxxxxxxxxxxxxxxxxxxxxxxxxx //

@implementation dataManager
//--------------------------------------------------------------//
#pragma mark -- 初期化 --
//--------------------------------------------------------------//

static dataManager* _sharedInstance = nil;

+ (dataManager*)sharedManager
{
    // インスタンスを作成する
    if (!_sharedInstance) {
        _sharedInstance = [[dataManager alloc] init];
    }
    
    return _sharedInstance;
}

- (void)dealloc
{
    // インスタンス変数を解放する
    [_managedObjectContext release], _managedObjectContext = nil;
    
    // 親クラスのdeallocを呼び出す
    [super dealloc];
}

//--------------------------------------------------------------//
#pragma mark -- プロパティ --
//--------------------------------------------------------------//

- (NSManagedObjectContext*)managedObjectContext
{
    NSError*    error;
    
    // インスタンス変数のチェック
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    // 管理対象オブジェクトモデルの作成
    NSManagedObjectModel*   managedObjectModel;
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // 永続ストアコーディネータの作成
    NSPersistentStoreCoordinator*   persistentStoreCoordinator;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] 
                                  initWithManagedObjectModel:managedObjectModel];
    [persistentStoreCoordinator autorelease];
    
    // 保存ファイルの決定
    NSArray*    paths;
    NSString*   path = nil;
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        path = [paths objectAtIndex:0];
        path = [path stringByAppendingPathComponent:@".gamedata"];
        path = [path stringByAppendingPathComponent:@"gamedata.db"];
    }
    
    if (!path) {
        return nil;
    }
    
    // ディレクトリの作成
    NSString*       dirPath;
    NSFileManager*  fileMgr;
    dirPath = [path stringByDeletingLastPathComponent];
    fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:dirPath]) {
        if (![fileMgr createDirectoryAtPath:dirPath 
                withIntermediateDirectories:YES attributes:nil error:&error])
        {
            NSLog(@"Failed to create directory at path %@, erro %@", 
                  dirPath, [error localizedDescription]);
        }
    }
    
    // ストアURLの作成
    NSURL*  url = nil;
    url = [NSURL fileURLWithPath:path];
    
    // 永続ストアの追加
    NSPersistentStore*  persistentStore;
    persistentStore = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType 
                                                               configuration:nil URL:url options:nil error:&error];
    if (!persistentStore && error) {
        NSLog(@"Failed to create add persitent store, %@", [error localizedDescription]);
    }
    
    // 管理対象オブジェクトコンテキストの作成
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    
    // 永続ストアコーディネータの設定
    [_managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    
    return _managedObjectContext;
}

-(NSArray*)getData{
    // 管理対象オブジェクトコンテキストを取得する
    NSManagedObjectContext* context;
    context = self.managedObjectContext;
    
    // 取得要求を作成する
    NSFetchRequest*         request;
    NSEntityDescription*    entity;
    request = [[NSFetchRequest alloc] init];
    [request autorelease];
    entity = [NSEntityDescription entityForName:@"GameData" inManagedObjectContext:context];// xxxxxxxxxxxxxxxxxxxxxx modify xxxxxxxxxxxxxxxxxxxxxxxxxxx //
    [request setEntity:entity];
    
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

- (GameData*)insertNewData
{
    // 管理対象オブジェクトコンテキストを取得する
    NSManagedObjectContext* context;
    context = self.managedObjectContext;
    
    // アイテムを作成する
    GameData*    newData;
    newData = [NSEntityDescription insertNewObjectForEntityForName:@"GameData" // xxxxxxxxxxxxxxxxxxxxxx modify xxxxxxxxxxxxxxxxxxxxxxxxxxx //
                                           inManagedObjectContext:context];
    
    return newData;
}

//--------------------------------------------------------------//
#pragma mark -- 永続化 --
//--------------------------------------------------------------//

- (void)save
{
    // 保存
    NSError*    error;
    if (![self.managedObjectContext save:&error]) {
        // エラー
        NSLog(@"Error, %@", error);
    }
}

@end
