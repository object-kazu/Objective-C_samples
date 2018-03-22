//
//  SpeedRPGViewController.h
//  SpeedRPG
//
//  Created by 清水 一征 on 11/09/21.
//  Copyright 2011 momiji-mac.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeedRPGViewController : UIViewController {
 
    //game state
    int game_status;
    // Timer
    NSTimer *gameTimer;

}
//Game_state control and timer call
-(void)gameController:(NSTimer*)timer;
//Game status call these method!
-(void) GameStartController;
-(void) GamePlayContoller;
-(void) GamePreController;
-(void) GameEndController;
-(void) GameRulesController:(int)page;
-(void) GameRecordController;
-(void) GameResultsController;
-(void) GameSettingController;
-(void) GameCardSelectController;


@end
