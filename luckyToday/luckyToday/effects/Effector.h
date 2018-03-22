//
//  Effector.h
//  from MonsterHockey3 
//
//  Created by 清水 一征 on 12/06/13.
//  Copyright 2012年 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ChallengeScene.h"
#import "Defs.h"
#import "EndingScene.h"

@interface Effector : CCLayer {
        
}
@property (nonatomic) NSInteger sleepingCounter;
@property (nonatomic, assign) CCParticleSystem *particle;
@property (nonatomic)     CGPoint ParticlePosition_;
@property (nonatomic) float pack_Radius;

-(void) runJudgeEffect;
-(void) runGoodEndingEffect;
-(void) runBadEndingEffect;
-(void) effectInit;
-(void)preLoadParticleEffect:(NSString*)fileName;
-(void)setParticleOptions;


@end
