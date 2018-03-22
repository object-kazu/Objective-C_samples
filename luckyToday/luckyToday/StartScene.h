//
//  luckyToday
//
//  Created by 清水 一征 on 12/09/03.
//  Copyright momiji-mac.com 2012年. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "ChallengeScene.h"
#import "DataController.h"


@interface StartScene : CCLayer
{

}


@property (nonatomic,assign) CCLabelTTF *startLabel;
@property (nonatomic, assign) DataController* dateContorol;
@property (nonatomic,assign) float upPoint;
@property (nonatomic, assign) float downPoint;
@property (nonatomic, assign) NSString* SEffect;


+(CCScene *) scene;
-(void) gameStart;
-(void) startController;
@end
