//
//  EndingScene.h
//  luckyToday
//
//  Created by 清水 一征 on 12/09/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Defs.h"
#import "ChallengeScene.h"
#import "Effector.h"
#import "StartScene.h"

@interface EndingScene : CCLayer {
    
}

@property (nonatomic, assign) bool endingFlag;
@property(nonatomic,assign) CCLabelTTF *Ending;


+(CCScene *) scene;
+(EndingScene*)shareEndingScene;
-(void) massage;

@end
