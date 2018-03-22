//
//  virusCrusaderAppDelegate.h
//  virusCrusader
//
//  Created by 清水 一征 on 11/05/22.
//  Copyright 2011 momiji-mac.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class virusCrusaderViewController;

@interface virusCrusaderAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet virusCrusaderViewController *viewController;


//core Data copy and paste block
//@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
//@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//
//
//- (void)saveContext;
//- (NSURL *)applicationDocumentsDirectory;
//


@end
