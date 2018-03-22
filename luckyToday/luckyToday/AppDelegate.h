//
//  AppDelegate.h
//  luckyToday
//
//  Created by 清水 一征 on 12/09/03.
//  Copyright momiji-mac.com 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import <CoreLocation/CoreLocation.h>

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
