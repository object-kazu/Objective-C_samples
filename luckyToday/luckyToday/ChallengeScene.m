//
//  ChallengeScene.m
//  luckyToday
//
//  Created by 清水 一征 on 12/09/04.
//  Copyright 2012年 momiji-mac.com. All rights reserved.
//

#import "ChallengeScene.h"
#import "SimpleAudioEngine.h"


const NSString *Operators = @"+-x/";

@implementation ChallengeScene

static ChallengeScene* instanceOfChallenge;


+(CCScene *) scene{
	CCScene *scene = [CCScene node];
    ChallengeScene *layer =[ChallengeScene node];
    
    [scene addChild:layer z:-1 tag:ChallengeSceneTag];
    
	return scene;
    
}
+(ChallengeScene*)shareChallengeScene{
    NSAssert(instanceOfChallenge != nil, @" ChallengeScene instance not yet init! ");
    return instanceOfChallenge;
}


-(id) init{
    
	if( (self=[super init])) {
        
        instanceOfChallenge = self;
        
        //position base value
        CGSize size = [[CCDirector sharedDirector] winSize];
        CGPoint home = ccp(size.width /2, size.height/2);
        float marge = size.width * 0.02;
        float body = size.width - (marge *2);
        float ope = body / 5;
        _numberPosi_y = 200;
        _scorePosi_y = size.height -30;


        //operation position x
        _ope_1_x = marge + ope;
        _ope_2_x = marge +(ope *2);
        _ope_3_x = marge +(ope *3);
        _ope_4_x = marge +(ope *4);

        //number position x
        _num_1_x = [self averagePosition:marge post:_ope_1_x];
        _num_2_x = [self averagePosition:_ope_1_x post:_ope_2_x];
        _num_3_x = [self averagePosition:_ope_2_x post:_ope_3_x];
        _num_4_x = [self averagePosition:_ope_3_x post:_ope_4_x];
        float endOfNum = size.width - marge;
        _num_5_x = [self averagePosition:_ope_4_x post:endOfNum];
                
        //background
        CCSprite *backGround = [CCSprite spriteWithFile:@"backTicket.png"];
        backGround.position = home;
        [self addChild:backGround z:-1];

        // make question
        [self makeQuestion];
        
        //operators
        _op1_state = 0;
        _op2_state = 0;
        _op3_state = 0;
        _op4_state = 0;
       
        [self operatorInit];
        
        //done button
        _doneButton = [CCLabelTTF labelWithString:@"PUSH" fontName:MF fontSize:36];
        CCMenuItemImage *done = [CCMenuItemImage itemWithNormalImage:@"done_n.png" selectedImage:@"done_h.png" target:self selector:@selector(showResult:)];
        CCMenu *menu_show = [CCMenu menuWithItems:done, nil];
        _donePosi_y = _numberPosi_y +(_scorePosi_y - _numberPosi_y) *0.5;
        [menu_show setPosition:ccp(size.width/2, _donePosi_y)];
        [self addChild:menu_show];
        
        //touch
        self.isTouchEnabled = YES;
        CCLOG(@"%@ : %@",NSStringFromSelector(_cmd), self);
        
        
        //score label
        [self scoreLabelInit];
        
        //ending
        _endingFlag = YES;
        
        
        //sound
        _SEffect = @"doneSound.caf";
        [[SimpleAudioEngine sharedEngine] preloadEffect:_SEffect];

        
    }
	return self;
}

-(float)averagePosition:(float)pre post:(float)post{
    return (pre + post)*0.5;
}


-(void)scoreLabelInit{
    
    /*
     play times is not display in this version.
     */
    
    DataController *dc = [[DataController alloc]init];
    NSArray* array = [dc load_Score];
    NSAssert([array count] == 3,@" score is not correct "  );
    
    _upScore = [[array objectAtIndex:0] floatValue];
    _downScore = [[array objectAtIndex:1] floatValue];
//    _playTimes = [[array objectAtIndex:2] floatValue];
    
    NSString *upMess = [NSString stringWithFormat:@"Up: %d",(int)_upScore];
    NSString *downMess = [NSString stringWithFormat:@"Down: %d",(int)_downScore];
//    NSString *playTimesMess = [NSString stringWithFormat:@"PlayTimes: %d",(int)_playTimes];
    
    NSInteger scoreLabelFontSize = 18;
    _upLabel = [CCLabelTTF labelWithString:upMess fontName:MF fontSize:scoreLabelFontSize];
    _downLable = [CCLabelTTF labelWithString:downMess fontName:MF fontSize:scoreLabelFontSize];
//    _playTimesLabel = [CCLabelTTF labelWithString:playTimesMess fontName:MF fontSize:scoreLabelFontSize];
    
    static const ccColor3B scoreColor = {234,85,20};
    _upLabel.color = scoreColor;
    _downLable.color = scoreColor;
//    _playTimesLabel.color = scoreColor;
    
    CCMenuItem *upM = [CCMenuItemLabel itemWithLabel:_upLabel];
    CCMenuItem *downM = [CCMenuItemLabel itemWithLabel:_downLable];
//    CCMenuItem *pM = [CCMenuItemLabel itemWithLabel:_playTimesLabel];
    
    CCMenu *Scores = [CCMenu menuWithItems:upM,downM, nil];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    [Scores setPosition:ccp(size.width /2, _scorePosi_y)];
    [Scores alignItemsHorizontallyWithPadding:30];
    [self addChild:Scores z:1];
    
    [dc release];

}


-(void) makeQuestion{
    [self makeQuestionOfNumbers];
    [self displayQuestion];
    
}
-(void) makeQuestionOfNumbers{
    _numList = [NSMutableArray array];
    NSInteger element;
        
    for (int i=0; i<5; i++) {
        element = arc4random() % 10;
        NSNumber *temp = @(element);
        [_numList addObject:temp];
    }
}

-(void) displayQuestion{
    if ([_numList count] == 5) {
        
        NSInteger fontSize = 64;
        
        NSString *temp = [NSString stringWithFormat:@"%d",[[_numList objectAtIndex:0] intValue]];
        _num1 = [CCLabelTTF labelWithString:temp fontName:MF fontSize:fontSize];
        _num1.position = ccp(_num_1_x, _numberPosi_y);
        [self addChild:_num1];
        
        temp = [NSString stringWithFormat:@"%d",[[_numList objectAtIndex:1] intValue]];
        _num2 = [CCLabelTTF labelWithString:temp fontName:MF fontSize:fontSize];
        _num2.position = ccp(_num_2_x, _numberPosi_y);
        [self addChild:_num2];
        
        temp = [NSString stringWithFormat:@"%d",[[_numList objectAtIndex:2] intValue]];
        _num3 = [CCLabelTTF labelWithString:temp fontName:MF fontSize:fontSize];
        _num3.position =ccp(_num_3_x, _numberPosi_y);
        [self addChild:_num3];
        
        temp = [NSString stringWithFormat:@"%d",[[_numList objectAtIndex:3] intValue]];
        _num4 = [CCLabelTTF labelWithString:temp fontName:MF fontSize:fontSize];
        _num4.position = ccp(_num_4_x, _numberPosi_y);
        [self addChild:_num4];
        
        temp = [NSString stringWithFormat:@"%d",[[_numList objectAtIndex:4] intValue]];
        _num5 = [CCLabelTTF labelWithString:temp fontName:MF fontSize:fontSize];
        _num5.position = ccp(_num_5_x, _numberPosi_y);
        [self addChild:_num5];

    }else{
        CCLOG(@"_numlist is void, check makeQuestionOfNumber");
    }
    [_numList retain]; // _numlist should retain, because _numlist release in this method
}

-(void) showResult:(id)sender{

    NSNumber *num1 = [NSNumber numberWithInteger:_op1_state];
    NSNumber *num2 = [NSNumber numberWithInteger:_op2_state];
    NSNumber *num3 = [NSNumber numberWithInteger:_op3_state];
    NSNumber *num4 = [NSNumber numberWithInteger:_op4_state];

    
    NSMutableArray *_operators = [NSMutableArray arrayWithObjects:num1,num2,num3,num4, nil];
    
    Calc* calcu = [[Calc alloc]init];
    CCLOG(@"keep is %d", [_numList count]);
    
    DataController *dc = [[DataController alloc]init];
    [dc load_data];
    
    if([calcu result:_numList operators:_operators]){
            
        dc.upData ++;
        _endingFlag = YES;
        CCLOG(@"YES");
    }else{
        dc.downData ++;
        _endingFlag = NO;
            CCLOG(@"NO");
    }
    CCLOG(@"dc play times is %d", (int)dc.playTimeData);
    dc.playTimeData ++;
    
    [dc save_data];
    
    [calcu release];
    [dc release];
    
    
    //game finishing treatment
    [[SimpleAudioEngine sharedEngine] playEffect:_SEffect];

    Effector *judgeEffect = [[[Effector alloc]init]autorelease];
    [judgeEffect runJudgeEffect];
    
    [self scheduleOnce:@selector(update:) delay:0.6f];
}


-(void)update:(ccTime)delta{
    
    [self gameFinishConroller];
}

-(void) operatorInit{
    NSString *str = [self operators:0];
    NSInteger fontSize = 42;
    
    _op1 = [CCLabelTTF labelWithString:str fontName:MF fontSize:fontSize];
    _op2 = [CCLabelTTF labelWithString:str fontName:MF fontSize:fontSize];
    _op3 = [CCLabelTTF labelWithString:str fontName:MF fontSize:fontSize];
    _op4 = [CCLabelTTF labelWithString:str fontName:MF fontSize:fontSize];

    CGSize size = [[CCDirector sharedDirector] winSize];
    NSInteger position_y = size.height/2 - 85;
    _op1.position = ccp(_ope_1_x, position_y);
    _op2.position = ccp(_ope_2_x, position_y);
    _op3.position = ccp(_ope_3_x, position_y);
    _op4.position = ccp(_ope_4_x, position_y);
    [self addChild:_op1 z:Z_label];
    [self addChild:_op2 z:Z_label];
    [self addChild:_op3 z:Z_label];
    [self addChild:_op4 z:Z_label];
    
    NSString *normal_Button = @"button_n.png";
    NSString *select_Button = @"button_h.png";
    
    CCMenuItem *first = [CCMenuItemImage itemWithNormalImage:normal_Button selectedImage:select_Button target:self selector:@selector(push:)];
    CCMenuItem *second =[CCMenuItemImage itemWithNormalImage:normal_Button selectedImage:select_Button target:self selector:@selector(push:)];
    CCMenuItem *third = [CCMenuItemImage itemWithNormalImage:normal_Button selectedImage:select_Button target:self selector:@selector(push:)];
    CCMenuItem *forth = [CCMenuItemImage itemWithNormalImage:normal_Button selectedImage:select_Button target:self selector:@selector(push:)];
    
    
    first.tag = button_1;
    second.tag = button_2;
    third.tag = button_3;
    forth.tag = button_4;
    
    NSInteger position_y_button = position_y +10;
    first.position = ccp(_ope_1_x, position_y_button);
    second.position = ccp(_ope_2_x, position_y_button);
    third.position = ccp(_ope_3_x, position_y_button);
    forth.position = ccp(_ope_4_x, position_y_button);
    
    CCMenu *tm = [CCMenu menuWithItems:first,second,third,forth, nil];
    tm.position = CGPointZero;
    [self addChild:tm z:1];
    

}

-(void) push:(id)sender{
    switch ([sender tag]) {
        case button_1:
            _op1_state ++;
            _op1_state = [self operatorRegulate:_op1_state];
            [_op1 setString:[self operators:_op1_state]];
            break;
        case button_2:
            _op2_state ++;
            _op2_state = [self operatorRegulate:_op2_state];
            [_op2 setString:[self operators:_op2_state]];

            break;
        case button_3:
            _op3_state ++;
            _op3_state = [self operatorRegulate:_op3_state];
            [_op3 setString:[self operators:_op3_state]];

            break;
        case button_4:
            _op4_state ++;
            _op4_state = [self operatorRegulate:_op4_state];
            [_op4 setString:[self operators:_op4_state]];
            break;
        default:
            CCLOG(@"Error at push:, illigal button tag is sended");
            break;
    }
    
}
-(NSInteger)operatorRegulate:(NSInteger)state{
    state = state % 4;
    return state;
}
-(NSString*) operators:(NSInteger)ope{
    NSString *str = [Operators substringWithRange:NSMakeRange(ope, 1)];
    return str;
}

-(void)gameFinishConroller{
        
    CCScene *ending = [CCTransitionFade transitionWithDuration:0.7f scene:[EndingScene scene]];
    [[CCDirector sharedDirector] replaceScene:ending];
    
}

- (void) dealloc
{

	[super dealloc];
}



@end
