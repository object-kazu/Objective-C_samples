//
//  SpeedRPGAppDelegate.h
//  SpeedRPG
//
//  Created by 清水 一征 on 11/09/21.
//  Copyright 2011 momiji-mac.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpeedRPGViewController;

@interface SpeedRPGAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SpeedRPGViewController *viewController;

@end
