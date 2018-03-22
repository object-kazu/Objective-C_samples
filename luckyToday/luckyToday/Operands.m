//
//  Operands.m
//  luckyToday
//
//  Created by 清水 一征 on 12/09/20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Operands.h"


@implementation Operands


+(id) Operands
{
	
    return [[[self alloc] initWithOperandsImage] autorelease];
}

-(id) initWithOperandsImage
{
    if (self = [super initWithFile:@"operands.png"]) {
        
        ChallengeScene *challenge = [ChallengeScene shareChallengeScene];

        //pack initial position
        [challenge addChild:self];

        
    }
	return self;
}


@end
