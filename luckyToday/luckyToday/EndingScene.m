//
//  EndingScene.m
//  luckyToday
//
//  Created by 清水 一征 on 12/09/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EndingScene.h"


@implementation EndingScene

static EndingScene* instanceOfEndingScene;

+(EndingScene*) shareEndingScene{
    NSAssert(instanceOfEndingScene != nil, @"EndingScene instance not yey init");
    return instanceOfEndingScene;
}



+(CCScene*)scene{

	CCScene *scene = [CCScene node];
	
    EndingScene *layer = [EndingScene node];
	
    [scene addChild: layer];
	
    return scene;

}

-(id) init{
    if( (self=[super init])) {
        //ending message
        _endingFlag = [ChallengeScene shareChallengeScene].endingFlag;
        instanceOfEndingScene = self;
        
        [self massage];
        
        
    }
    return  self;
}

-(void) massage{
    NSString *massage;
    Effector *effect = [[[Effector alloc]init]autorelease];
    
    if (_endingFlag) {
        [effect runGoodEndingEffect];

        massage = @"Up";
    }else{
        [effect runBadEndingEffect];

        massage = @"Down";
    }
    
    _Ending = [CCLabelTTF labelWithString:massage fontName:MF fontSize:45];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    _Ending.position = ccp(size.width /2, size.height /2);
    [self addChild:_Ending];
    

    
}

@end
