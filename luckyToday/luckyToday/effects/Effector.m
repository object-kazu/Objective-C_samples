//
//  Effector.m
//  from MonsterHockey3
//
//  Created by 清水 一征 on 12/06/13.
//  Copyright 2012年 momiji-mac.com. All rights reserved.
//

#import "Effector.h"


@implementation Effector

-(id) init
{

	if( (self=[super init])) {
        _sleepingCounter = INITIAL0;
        [self effectInit];
	}
	return self;
}
-(void)preLoadParticleEffect:(NSString*)fileName{
    
    [CCParticleSystemQuad particleWithFile:fileName];
}


-(void)effectInit{
    
    /*
     particle effect
     file name should be xxxEffect.plist
     */
    
    
    //particle effect pre-load
    NSArray *fileList;
    NSString *filePath = [[NSBundle mainBundle] resourcePath];
    
    NSError* error;
    NSFileManager* fm = [NSFileManager defaultManager];
    fileList = [fm contentsOfDirectoryAtPath:filePath error:&error];
    
    CCLOG(@"file count %d",[fileList count]);
    
    for (NSString* file in fileList) {
        NSRange searchResult = [file rangeOfString:@"Effect.plist"];
        if(searchResult.location != NSNotFound){
            CCLOG(@"particle effect file name is %@",file);
            [self preLoadParticleEffect:file];
        }
    }
}

//effect
-(void) runJudgeEffect{
    NSString *target = @"ticketEffect.plist";
    _particle = [CCParticleSystemQuad particleWithFile:target];
   
    [self setParticleOptions];
    
    _particle.duration = EffectInterval;
    [[ChallengeScene shareChallengeScene] addChild:_particle];
}
-(void) runGoodEndingEffect{
    NSString *target = @"upEffect.plist";
    _particle = [CCParticleSystemQuad particleWithFile:target];
    
    [self setParticleOptions];
    
    [[EndingScene shareEndingScene] addChild:_particle];
    
}
-(void) runBadEndingEffect{
    NSString *target = @"downEffect.plist";
    _particle = [CCParticleSystemQuad particleWithFile:target];
    
    [self setParticleOptions];
    
    [[EndingScene shareEndingScene] addChild:_particle];
    
}

-(void)setParticleOptions{
    _particle.positionType = kCCPositionTypeGrouped;
    _particle.autoRemoveOnFinish = YES;
    
    
}



@end
