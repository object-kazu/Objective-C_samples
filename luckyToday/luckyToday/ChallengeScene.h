//
//  ChallengeScene.h
//  luckyToday
//
//  Created by 清水 一征 on 12/09/04.
//  Copyright 2012年 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Defs.h"
#import "EndingScene.h"
#import "Operands.h"
#import "Calc.h"
#import "DataController.h"
#import "Effector.h"

@interface ChallengeScene : CCLayer {
    
}

@property (nonatomic,assign) bool endingFlag;
@property (nonatomic,assign) CCLabelTTF *num1, *num2, *num3, *num4, *num5;
@property (nonatomic, assign) CCLabelTTF *op1,*op2,*op3,*op4;
@property (nonatomic, assign) NSInteger op1_state, op2_state, op3_state, op4_state;

@property (nonatomic,assign) CCLabelTTF *doneButton;

@property (nonatomic,assign) NSMutableArray* numList;
@property (nonatomic, assign) NSArray* labelArray;
@property (nonatomic,assign) CCLabelTTF *upLabel, *downLable, *playTimesLabel;

@property (nonatomic) float ope_1_x,ope_2_x,ope_3_x,ope_4_x;
@property (nonatomic) float num_1_x,num_2_x,num_3_x,num_4_x,num_5_x;
@property (nonatomic) float scorePosi_y, numberPosi_y, opePosi_y, donePosi_y;

@property (nonatomic, assign) CCParticleSystem *particle;
@property (nonatomic) CGPoint ParticlePosition;
@property (nonatomic) float upScore, downScore,playTimes;

//sound effect
@property (nonatomic,assign) NSString *SEffect;


+(CCScene*)scene;
-(void)scoreLabelInit;
+(ChallengeScene*)shareChallengeScene;
//make question
-(void) makeQuestion;
-(void) makeQuestionOfNumbers;
-(void)displayQuestion;

//operands
-(void) operatorInit;
-(void) push:(id)sender;
-(NSString*)operators:(NSInteger)ope;
-(NSInteger)operatorRegulate:(NSInteger)state;
-(float) averagePosition:(float)pre post:(float)post;
//result
-(void) showResult:(id)sender;



@end
