//
//  KSViewController.m
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/29.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#warning Do not Call MasuManager and CardManager!

#import "KSStartViewController.h"
#import "KSRecordViewController.h"
#import "KSDiviceHelper.h"
#import "KSGameMainViewController.h"
#import "KSMenuButton.h"
#import "KSModeButton.h"

//mode
#import "KSModeContex.h"
#import "KSModeSeven.h"
#import "KSModeForteen.h"
#import "KSModeTwentyOne.h"

//card
//#import "KSCardManager.h" // do not use!
#import "KSCard.h"

//masu
//#import "KSMasuManager.h" // do not use!

@interface KSStartViewController ()

@property (nonatomic, retain) KSMenuButton                *StartButton;
@property (nonatomic, retain) KSMenuButton                *ShowRecordButton;

@property (nonatomic, retain) KSMenuAnimationHelper       *animationHelper;
@property (nonatomic, retain) KSGameMainViewController    *mainViewController;

@property (nonatomic, retain) KSModeButton                *modeSevenButton;
@property (nonatomic, retain) KSModeButton                *modeFourTeenButon;
@property (nonatomic, retain) KSModeButton                *modeTwentyoneButton;
@property (nonatomic, retain) NSArray                     *modeButtonArray;
@property (nonatomic) NSInteger                           modeButtonIndex;

//card Layoutとなどの確認のため外に出した。
@property (nonatomic, retain)  UILabel                    *titleSentence;

@end

@implementation KSStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startViewTitle]; //title display
    
    
    //game start button
    self.StartButton     = [[KSMenuButton new] startButton];
    self.StartButton.tag = START_BUTTON_TAG;
    [self.StartButton addTarget:self
                         action:@selector(hideMenu:)
               forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.StartButton];
    
#warning - 仮申請のために表示を消しておく
    //TODO:results button inactivate
    // show results button
    self.ShowRecordButton     = [[KSMenuButton new] showRecordButton];
    /*

     self.ShowRecordButton.tag =  RECORD_BUTTON_TAG;
     [self.ShowRecordButton addTarget:self action:@selector(hideMenu:) forControlEvents:UIControlEventTouchDown];
     [self.view addSubview:self.ShowRecordButton];
     
     //*/

    
    //animationHelper
    NSArray    *viewArray = @[self.StartButton, self.ShowRecordButton];
    self.animationHelper          = [[KSMenuAnimationHelper alloc] initWithViewsArray:viewArray];
    self.animationHelper.delegate = self;
    
    // main scene prep
    UIStoryboard    *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.mainViewController = [storyboard instantiateViewControllerWithIdentifier:Main_sceen];
    
    //mode button
    [self modeButtonInit];
    [self modeButtonControl];
    
    //mode button guid image
    UIImage* allow = [UIImage imageNamed:@"allow2.png"];
    UIImageView* backAllow = [[UIImageView alloc] initWithImage:allow];
    backAllow.alpha = 0.5;
    
    UIImageView* forwardAllow = [[UIImageView alloc] initWithImage:allow];
    forwardAllow.alpha = 0.5f;
    float angle = 180.0 * M_PI / 180;
    CGAffineTransform t = CGAffineTransformMakeRotation(angle);
    forwardAllow.transform = t;
    
    CGPoint tempCenter = self.modeSevenButton.center;
    CGSize  buttonSize = self.modeSevenButton.frame.size;
    backAllow.center = CGPointMake(tempCenter.x + buttonSize.width * 0.9 , tempCenter.y);
    [self.view addSubview:backAllow];
    
    forwardAllow.center = CGPointMake(tempCenter.x - buttonSize.width * 0.9, tempCenter.y);
    [self.view addSubview:forwardAllow];

    
    //notice
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modeButtonControl) name:BUTTON_SLIDE object:nil];
    
    //動作確認コード
    if ( [KSDiviceHelper is568h] ) {
        NSLog(@"yes!");
    } else {
        NSLog(@"no");
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self showMenu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)modeButtonInit {
    
    //game mode button
    self.modeSevenButton     = [[KSModeButton new] modeButton:MAX_7];
    self.modeSevenButton.tag = MODE_SEVEN_BUTTON_TAG;

    self.modeFourTeenButon     = [[KSModeButton new] modeButton:MAX_14];
    self.modeFourTeenButon.tag = MODE_FORUTEEN_BUTTON_TAG;

    self.modeTwentyoneButton     = [[KSModeButton new] modeButton:MAX_21];
    self.modeTwentyoneButton.tag = MODE_TWENTYONE_BUTTON_TAG;

    self.modeButtonArray = @[self.modeSevenButton, self.modeFourTeenButon, self.modeTwentyoneButton];
    self.modeButtonIndex = [self.modeButtonArray count] -1;
    for (KSModeButton* btn in self.modeButtonArray) {
        [self.view addSubview:btn];
        btn.hidden = YES;
    }
    
}

- (void)startViewTitle {
    
    CGPoint          titleCenter;
    titleCenter = CGPointMake(LAND_SCREEN_SIZE.width * 0.5, LAND_SCREEN_SIZE.height * 0.33);
    const CGFloat    TITLE_WIDTH  = 200.0f;
    const CGFloat    TITLE_HEIGHT = 30.0f;
    
    self.titleSentence = ({
        UILabel *sentence = [UILabel new];
        sentence.frame = CGRectMake(0, //仮の値として代入
                                    0, //しておく。
                                    TITLE_WIDTH,
                                    TITLE_HEIGHT);
        
        sentence.center = titleCenter;
        sentence.backgroundColor = [UIColor clearColor];
        sentence.textAlignment = NSTextAlignmentCenter;
        sentence.font  = [UIFont fontWithName:APPLI_FONT size:24];
        sentence.text  = @"Game:Accordion";
        sentence;
        
    });
    [self.view addSubview:self.titleSentence];
    
    // divice
    //    CGFloat    credit_posi_y = SCREEN_SIZE.height - TITLE_SENTENCE_hight - 10;
    //    UILabel    *creditLabel  = ({
    //        UILabel *sentence = [UILabel new];
    //        sentence.frame = CGRectMake(TITLE_SENTENCE_POSI_X,
    //                                    credit_posi_y,
    //                                    TITLE_SENTENCE_width,
    //                                    TITLE_SENTENCE_hight);
    //
    //        sentence.font  = [UIFont fontWithName:APPLI_FONT size:18];
    //        sentence.text  = @"Momiji-Mac.com";
    //        sentence.textAlignment = NSTextAlignmentRight;
    //        sentence;
    //
    //    });
    //    [self.view addSubview:creditLabel];
    //
}

#pragma mark - ---------- menu animation ----------

- (void)showMenu {
    
    [self.animationHelper showMenu];
    
}

- (void)hideMenu:(id)sender {
    
    [self.animationHelper hideMenu:sender];
    
}

- (void)modeButtonMenu {
    
}

#pragma mark - Notifocation
- (void)testNotificatiion {
    
//    NSLog(@"sucess notification");
}

#pragma mark - --------- delegate method ----------

- (void)pushedStartButton:(KSMenuAnimationHelper *)helper {
    // game start
    self.mainViewController.gameMode = self.gameMode;
    [self presentViewController:self.mainViewController
                       animated:YES
                     completion:^{
                     }];
}

- (void)pushedShowResultsButton:(KSMenuAnimationHelper *)helper {
    // show game score list
    UIStoryboard              *storyboard           = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KSRecordViewController    *recordViewController = [storyboard instantiateViewControllerWithIdentifier:Record_sceen];
    [self presentViewController:recordViewController animated:YES completion:nil];
    
}

- (void)changeGameMode:(NSInteger)modeButtonTag {
    //game mode
    if ( modeButtonTag == MODE_SEVEN_BUTTON_TAG ) {
        self.gameMode = GAME_MODE_7;
    } else if ( modeButtonTag == MODE_FORUTEEN_BUTTON_TAG ) {
        self.gameMode = GAME_MODE_14;
    } else if ( modeButtonTag == MODE_TWENTYONE_BUTTON_TAG ) {
        self.gameMode = GAME_MODE_21;
    } else {
        NSLog(@"mode setting error at %@", NSStringFromSelector(_cmd));
        
    }

}

-(void) modeButtonControl{
    
    KSModeButton* btn_hide = (KSModeButton*)[self.modeButtonArray objectAtIndex:self.modeButtonIndex];
    self.modeButtonIndex ++;
    if (self.modeButtonIndex > [self.modeButtonArray count] -1) {
        self.modeButtonIndex = 0;
    }
    KSModeButton* btn_show = (KSModeButton*)[self.modeButtonArray objectAtIndex:self.modeButtonIndex];

    [self.animationHelper changeModeFromHidden:btn_hide ToShow:btn_show];
    [self changeGameMode:btn_show.tag];
}

@end
