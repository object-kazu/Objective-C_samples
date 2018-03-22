//
//  SpeedRPGViewController.m
//  SpeedRPG
//
//  Created by 清水 一征 on 11/09/21.
//  Copyright 2011 momiji-mac.com. All rights reserved.
//

#import "SpeedRPGViewController.h"
#import "def.h"

@implementation SpeedRPGViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //game status
    game_status = _GAME_START;
    //timer setting　0.1 sec interval
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(gameController:) userInfo:nil repeats:YES];

    
//    //tag setting
//    [self tages_define];
//    
//    //card class
//    cards_ = [[cards alloc]init];
//    open_counter = 0;
//    
//    //card initialize
//    [cards_ Deal_Cards];
//    [cards_ Deal_EnemyCards];
//    
//    //teki_cards
//    
//    
//    //card image
//    card_ura = [UIImage imageNamed:@"card_ura.png"]; //common design
//    card_ura_active = [UIImage imageNamed:@"card_ura_active.png"];
//    
//    card_one =[UIImage imageNamed:@"one.png"];
//    card_two =[UIImage imageNamed:@"two.png"];
//    card_three=[UIImage imageNamed:@"three.png"];
//    card_four = [UIImage imageNamed:@"four.png"];
//    card_five=[UIImage imageNamed:@"five.png"];
//    card_six = [UIImage imageNamed:@"six.png"];
//    card_seven=[UIImage imageNamed:@"seven.png"];
//    card_eight=[UIImage imageNamed:@"eight.png"];
//    
//    [self Card_Animation_AllReFresh];
//    
//    [teki_Button setImage:card_ura forState:UIControlStateNormal];
//    
//    ChainAttackCounter  = 0;
//    
//    AnimationCounter = 0;
//    
//    //parameter display
//    HpH.text = [NSString stringWithFormat:@"%d",[cards_ diplay:HERO_HP]];
//    MpH.text = [NSString stringWithFormat:@"%d",[cards_ diplay:HERO_MP]];
//    AtH.text = [NSString stringWithFormat:@"%d",[cards_ diplay:HERO_AT]];
//    DfH.text = [NSString stringWithFormat:@"%d",[cards_ diplay:HERO_DF]];
//    
//    HpE.text = [NSString stringWithFormat:@"%d",[cards_ diplay:ENEMY_HP]];
//    MpE.text = [NSString stringWithFormat:@"%d",[cards_ diplay:ENEMY_MP]];
//    AtE.text = [NSString stringWithFormat:@"%d",[cards_ diplay:ENEMY_AT]];
//    DfE.text = [NSString stringWithFormat:@"%d",[cards_ diplay:ENEMY_DF]];
//    
//    //message display
//    message_H.text = @"slime is for beginner";
//    message_E.text = @"Come on!";
//    
//    
//    //test codes
//    [cards_ getHeroCardKindFromTag:0];
//
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Game_State
//timer call
-(void)gameController:(NSTimer*)timer{
    //Game State Controll
    
    switch (game_status) {
        case _GAME_START:
            //Game start treatment
            [self GameStartController];
            break;
        case _GAME_END:
            //Game END treatment
            [self GameEndController];
            break;
        case _GAME_PRE:
            //Game start pre-treatment
            [self GamePreController];
            break;
        case _GAME_RECORD:
            //Game Record treatment
            [self GameRecordController];
            break;
        case _GAME_RESULTS:
            //Game results treatment
            [self GameResultsController];
            break;
        case _GAME_RULES:
            //Game Rules treatment
            [self GameRulesController:game_status];
            break;
        case _GAME_SETTING:
            //Game setting treatment
            [self GameSettingController];
            break;
        case _GAME_PLAY:
            //Game play treatment
            [self GamePlayContoller];
            break;
        case _GAME_CARDSELECT:
            [self GameCardSelectController];
            break;
        default:
            NSLog(@"error at gameController:timer");
            break;
    }

}

//Game status call these method!
-(void) GameStartController{
    
}
-(void) GamePlayContoller{
    
}
-(void) GamePreController{
    
}
-(void) GameEndController{
    
}
-(void) GameRulesController:(int)page{
    
}
-(void) GameRecordController{
    
}
-(void) GameResultsController{
    
}
-(void) GameSettingController{
    
}
-(void) GameCardSelectController{
    
}


@end
