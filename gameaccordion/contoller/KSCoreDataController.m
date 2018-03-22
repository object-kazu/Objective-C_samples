//
//  KSCoreDataController.m
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/30.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSCoreDataController.h"

#define ENTITY_NAME @"Data"
#define ATTRI_DATE  @"date"
#define ATTRI_MODE  @"mode"
#define ATTRI_SCORE @"remainCards"

@implementation KSCoreDataController

#pragma mark - ---------- init ----------

static KSCoreDataController * _sharedInstance = nil;

+ (KSCoreDataController *)sharedManager {
    
    if ( !_sharedInstance ) {
        _sharedInstance = [[KSCoreDataController alloc]init];
    }
    
    return _sharedInstance;
}

#pragma mark - --------- property ----------

- (NSManagedObjectContext *)managedObjectContext {
    
    NSError    *error;
    
    // インスタンス変数のチェック
    
    if ( _managedObjectContext ) {
        return _managedObjectContext;
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
        path = [path stringByAppendingPathComponent:@".results"];
        path = [path stringByAppendingPathComponent:@"results.db"];
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
    
    //CoreDataの自動マイグレーションオプションを設定
    NSDictionary *_options_ = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
    
    
    NSPersistentStore    *persistentStore;
    persistentStore = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                               configuration:nil
                                                                         URL:url
                                                                     options:_options_
                                                                       error:&error];
    if ( !persistentStore && error ) {
        NSLog(@"Failed to create add persitent store, %@", [error localizedDescription]);
    }
    
    // 管理対象オブジェクトコンテキストの作成
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    
    // 永続ストアコーディネータの設定
    [_managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    
    return _managedObjectContext;
}

#pragma mark - --------- item operate ----------

// アイテムの操作
- (Data *)insertNewEntity {
    
    NSManagedObjectContext    *context;
    context = self.managedObjectContext;
    Data                      *playResults;
    playResults = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
    
    return playResults;
}


-(NSArray*) sortedEntityByMode7{
    NSString* str = [NSString stringWithFormat:@"%ld",(long)GAME_MODE_7];
    return [self sortedEntityByMode:str];
}

-(NSArray*) sortedEntityByMode14{
    NSString* str = [NSString stringWithFormat:@"%ld",(long)GAME_MODE_14];
    return [self sortedEntityByMode:str];
    
}

-(NSArray*)sortedEntityByMode21{
    NSString* str = [NSString stringWithFormat:@"%ld",(long)GAME_MODE_21];
    return [self sortedEntityByMode:str];
    
}
- (NSArray *)sortedEntityByMode:(NSString*)mode {
    // 管理対象オブジェクトコンテキストを取得する
    NSManagedObjectContext    *context;
    context = self.managedObjectContext;
    
    // NSFetchRequestは、検索条件などを保持させるオブジェクトです。
    // 後続処理では、このインスタンスに色々と検索条件を設定します。
    NSFetchRequest         *request;
    NSEntityDescription    *entity;
    NSSortDescriptor       *sortDescriptor;
    
    request = [[NSFetchRequest alloc] init];
    entity  = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:context];
    [request setEntity:entity];
    
    // 一度に読み込むサイズを指定します。
    [request setFetchBatchSize:5];
    
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:ATTRI_SCORE ascending:YES]; // "date" should be check!
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    // 続いて検索条件を指定します。
    // NSPredicateを用いて、検索条件の表現（述語）を作成します。
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"mode = %@", mode];
    [request setPredicate:pred];

    
    
    // 取得要求を実行する
    NSArray    *result;
    NSError    *error = nil;
    result = [context executeFetchRequest:request error:&error];
    if ( !result ) {
        // エラー
        NSLog(@"executeFetchRequest: failed, %@", [error localizedDescription]);
        
        return nil;
    }
    
    return result;
    
}

- (NSArray *)sortedEntityByDate:(BOOL)fromOldToNew {
    
    // 管理対象オブジェクトコンテキストを取得する
    NSManagedObjectContext    *context;
    context = self.managedObjectContext;
    
    // 取得要求を作成する
    NSFetchRequest         *request;
    NSEntityDescription    *entity;
    NSSortDescriptor       *sortDescriptor;
    request = [[NSFetchRequest alloc] init];
    
    entity = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:ATTRI_DATE ascending:fromOldToNew]; // "date" should be check!
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    // 取得要求を実行する
    NSArray    *result;
    NSError    *error = nil;
    result = [context executeFetchRequest:request error:&error];
    if ( !result ) {
        // エラー
        NSLog(@"executeFetchRequest: failed, %@", [error localizedDescription]);
        
        return nil;
    }
    
    return result;
    
}

- (NSArray *)sortedEntityByScore {
    
    // 管理対象オブジェクトコンテキストを取得する
    NSManagedObjectContext    *context;
    context = self.managedObjectContext;
    
    // 取得要求を作成する
    NSFetchRequest         *request;
    NSEntityDescription    *entity;
    NSSortDescriptor       *sortDescriptor;
    request = [[NSFetchRequest alloc] init];
    
    entity = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:ATTRI_SCORE ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    // 取得要求を実行する
    NSArray    *result;
    NSError    *error = nil;
    result = [context executeFetchRequest:request error:&error];
    if ( !result ) {
        // エラー
        NSLog(@"executeFetchRequest: failed, %@", [error localizedDescription]);
        
        return nil;
    }
    
    return result;
    
}

#pragma mark -  ----------  永続化  ----------

- (void)save {
    // 保存
    NSError    *error;
    if ( ![self.managedObjectContext save:&error] ) {
        // エラー
        NSLog(@"Error, %@", error);
    }
    
}

@end
