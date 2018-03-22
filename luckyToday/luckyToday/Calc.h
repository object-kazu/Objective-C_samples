//
//  Calc.h
//  luckyToday
//
//  Created by 清水 一征 on 12/09/20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ChallengeScene.h"

@interface Calc : CCLayer {
    
}
@property (nonatomic,assign) NSMutableArray* list;
-(NSInteger)calcurate:(NSInteger)first second:(NSInteger)second ope:(NSInteger)ope;
-(Boolean)result:(NSMutableArray*)array operators:(NSMutableArray*)operators;

@end
