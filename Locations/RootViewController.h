//
//  RootViewController.h
//  Locations
//
//  Created by 清水 一征 on 11/05/28.
//  Copyright 2011 momiji-mac.com. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RootViewController : UITableViewController <CLLocationManagerDelegate> {
    
    NSMutableArray *eventsArray;
    NSManagedObjectContext *managedObjectContex;
    
    CLLocationManager *locationManager;
    UIBarButtonItem *addButton;
    
}

@property(nonatomic,retain) NSMutableArray *eventsArray;
@property(nonatomic,retain) NSManagedObjectContext *managedObjectContex;

@property(nonatomic,retain) CLLocationManager *locationManager;
@property(nonatomic,retain) UIBarButtonItem *addButton;

-(void) addEvent;

@end
