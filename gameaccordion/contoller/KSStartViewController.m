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
#import "KSHelpViewController.h"
#import "KSGameMainViewController.h"

#import "KSDiviceHelper.h"
#import "KSMenuButton.h"
#import "KSModeButton.h"

//mode
#import "KSModeContex.h"
#import "KSModeSeven.h"
#import "KSModeForteen.h"
#import "KSModeTwentyOne.h"

//card
#import "KSCard.h"

//level
#import "SVSegmentedControl.h"
#import <QuartzCore/QuartzCore.h>

@interface KSStartViewController ()


@property (nonatomic, retain) KSMenuButton                *StartButton;
@property (nonatomic, retain) KSMenuButton                *ShowRecordButton;

@property (nonatomic, retain) KSMenuAnimationHelper       *animationHelper;
@property (nonatomic, retain) KSGameMainViewController    *mainViewController;

@property (nonatomic, retain) KSModeButton                *modeSevenButton;
@property (nonatomic, retain) KSModeButton                *modeFourTeenButon;
@property (nonatomic, retain) KSModeButton                *modeTwentyoneButton;
@property (nonatomic, retain) NSArray                     *modeButtonArray;

@property (nonatomic) NSUserDefaults                      *modeUserDefaults;

//card Layoutとなどの確認のため外に出した。
@property (nonatomic, retain)  UILabel                    *titleSentence;

//game level
@property (nonatomic) GAME_LEVEL gamelevel;

@end

@implementation KSStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //status bar hidden
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }

    
    //save and load >>> mode (only)
    self.modeUserDefaults = [NSUserDefaults standardUserDefaults];
    
    [self startViewTitle]; //title display
    
    //game start button
    self.StartButton     = [[KSMenuButton new] startButton];
    self.StartButton.tag = START_BUTTON_TAG;
    [self.StartButton addTarget:self
                         action:@selector(hideMenu:)
               forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.StartButton];
    
    UIButton    *options = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    options.frame = CGRectMake(10, 10, 60, 60);
    [options addTarget:self action:@selector(showOptions) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:options];
    
    //animationHelper
    NSArray    *viewArray = @[self.StartButton];
    self.animationHelper          = [[KSMenuAnimationHelper alloc] initWithViewsArray:viewArray];
    self.animationHelper.delegate = self;
    
    // main scene prep
    UIStoryboard    *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.mainViewController = [storyboard instantiateViewControllerWithIdentifier:Main_sceen];
    
    //mode button
    [self loadMode];
    [self modeButtonInit];
    [self showModeButtonByMode];
    
    //mode button guid image
    UIImage              *allow     = [UIImage imageNamed:@"allow.png"];
    UIImageView          *backAllow = [[UIImageView alloc] initWithImage:allow];
    backAllow.alpha = 0.5;
    
    UIImageView          *forwardAllow = [[UIImageView alloc] initWithImage:allow];
    forwardAllow.alpha = 0.5f;
    float                angle = 180.0 * M_PI / 180;
    CGAffineTransform    t     = CGAffineTransformMakeRotation(angle);
    forwardAllow.transform = t;
    
    CGPoint              tempCenter = self.modeSevenButton.center;
    CGSize               buttonSize = self.modeSevenButton.frame.size;
    backAllow.center = CGPointMake(tempCenter.x + buttonSize.width * 0.9, tempCenter.y);
    [self.view addSubview:backAllow];
    
    forwardAllow.center = CGPointMake(tempCenter.x - buttonSize.width * 0.9, tempCenter.y);
    [self.view addSubview:forwardAllow];
    
    //notice
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modeButtonControlPlus) name:BUTTON_SLIDE_LEFT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modeButtonConrolMinus) name:BUTTON_SLIDE_RIGHT object:nil];
    
    //game level
    self.gamelevel = LEVEL_NORMAL; //default
    SVSegmentedControl* svs = [[SVSegmentedControl alloc]initWithSectionTitles:@[@"normal",@"easy",@"easier"]];
    svs.height = CARD_HEIGHT * 0.5;
    
    svs.textColor  = [UIColor grayColor];
    svs.font = [UIFont fontWithName:APPLI_FONT size:16];
    svs.textShadowOffset = CGSizeMake(0, 0);
    svs.backgroundTintColor = [UIColor blackColor];
    
    svs.thumb.textColor = [UIColor whiteColor];
    svs.thumb.tintColor = ACCENT_yellow;
    svs.thumb.textShadowColor = [UIColor yellowColor];
    svs.thumb.textShadowOffset = CGSizeMake(0, 0.5);
    
    svs.changeHandler =^(NSUInteger index){
        switch (index) {
            case 0:
                self.gamelevel = LEVEL_NORMAL;
                break;
            case 1:
                self.gamelevel = LEVEL_EASY;
                break;
            case 2:
                self.gamelevel = LEVEL_VERY_EASY;
                break;
                
                
            default:
                NSAssert(0, @"segment index check");
                break;
        }
    };
    
    [self.view addSubview:svs];
    CGFloat x = self.titleSentence.center.x;
    CGFloat y = self.titleSentence.center.y + (CARD_HEIGHT * 0.6);
    svs.center = CGPointMake(x, y);
    
    
    
    
    //動作確認コード
//    if ( [KSDiviceHelper is568h] ) {
//        NSLog(@"yes!");
//    } else {
//        NSLog(@"no");
//    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self showMenu];
    [self loadMode];
    [self showModeButtonByMode];

    
}

//status bar hidden
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationFade;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startViewTitle {
    
    CGPoint          titleCenter;
    titleCenter = CGPointMake(LAND_SCREEN_SIZE.width * 0.5, LAND_SCREEN_SIZE.height * 0.1); //0.33
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
    
  
}

#pragma mark -  ---------- mode button ready  ----------
- (void)modeButtonInit {
    
    //game mode button
    self.modeSevenButton     = [[KSModeButton new] modeButton:MAX_7];
    self.modeSevenButton.tag = MODE_SEVEN_BUTTON_TAG;
    
    self.modeFourTeenButon     = [[KSModeButton new] modeButton:MAX_14];
    self.modeFourTeenButon.tag = MODE_FORUTEEN_BUTTON_TAG;
    
    self.modeTwentyoneButton     = [[KSModeButton new] modeButton:MAX_21];
    self.modeTwentyoneButton.tag = MODE_TWENTYONE_BUTTON_TAG;
    
    self.modeButtonArray = @[self.modeSevenButton, self.modeFourTeenButon, self.modeTwentyoneButton];
    
    for ( KSModeButton *btn in self.modeButtonArray ) {
        [self.view addSubview:btn];
        btn.hidden = YES;
    }
    
}

- (NSInteger)gameModePlus {
    self.gameMode++;
    if ( self.gameMode >= [self.modeButtonArray count] ) {
        self.gameMode = 0;
    }
    
    return self.gameMode;
}

- (NSInteger)gameModeMinus {
    self.gameMode--;
    if ( self.gameMode < 0 ) {
        self.gameMode = [self.modeButtonArray count] - 1;
    }
    
    return self.gameMode;
}

#pragma mark - ---------- menu animation ----------

- (void)showMenu {
    
    [self.animationHelper showMenu];
    
}

- (void)hideMenu:(id)sender {
    
    [self.animationHelper hideMenu:sender];
    
}

- (void)showOptions {
    NSInteger    numberOfOptions = 3;
    NSArray      *options        = @[
                                     @"Score",
                                     @"Help",
                                     @"Cancel"
                                                                          ];
    RNGridMenu    *av = [[RNGridMenu alloc] initWithTitles:[options subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    av.itemFont = [UIFont boldSystemFontOfSize:18];
    av.itemSize = CGSizeMake(150, 55);
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width / 2.f, self.view.bounds.size.height / 2.f)];
    
}


#pragma mark -  ---------- delegate from RNGridMenu  ----------
- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    
    if ( itemIndex == 0 ) { // Score
        [self showScore];
        
    } else if ( itemIndex == 1 ) { // Help
        [self showHelp];
        
    } else if ( itemIndex == 2 ) { // Cancel
        
    } else {
        NSLog(@"itemIndes has error at %@", NSStringFromSelector(_cmd));
    }
    
}

- (void)showScore {
    UIStoryboard              *storyboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KSRecordViewController    *recordsView = [storyboard instantiateViewControllerWithIdentifier:Record_sceen];
    [self presentViewController:recordsView
                       animated:YES
                     completion:^{
                     }];
    
}

- (void)showHelp {
    UIStoryboard            *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KSHelpViewController    *helpView   = [storyboard instantiateViewControllerWithIdentifier:Help_sceen];
    [self presentViewController:helpView
                       animated:YES
                     completion:^{
                     }];
    
}

#pragma mark - --------- delegate method ----------

- (void)pushedStartButton:(KSMenuAnimationHelper *)helper {
    // game start
    [self saveMode];
    self.mainViewController.gameMode = self.gameMode;
    self.mainViewController.gameLevel = self.gamelevel;
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

- (void)modeButtonControlPlus {
    KSModeButton    *btn_hide = [self hideModeButton:self.gameMode];
    
    [self showModeButton:[self gameModePlus] hideBuuton:btn_hide];
    
}

-(void) modeButtonConrolMinus{
    KSModeButton    *btn_hide = [self hideModeButton:self.gameMode];
    
    [self showModeButton:[self gameModeMinus] hideBuuton:btn_hide];

}

- (KSModeButton *)hideModeButton:(NSInteger)index {
    KSModeButton    *btn_hide = (KSModeButton *)[self.modeButtonArray objectAtIndex:self.gameMode];
    
    return btn_hide;
}

- (void)showModeButtonByMode {
    KSModeButton    *btn_show = (KSModeButton *)[self.modeButtonArray objectAtIndex:self.gameMode];
    btn_show.hidden = NO;
    [self changeGameMode:btn_show.tag];
    
}

- (void)showModeButton:(NSInteger)index hideBuuton:(KSModeButton *)btn_hide {
    
//    NSLog(@"index is %ld", (long)index);
    KSModeButton    *btn_show = (KSModeButton *)[self.modeButtonArray objectAtIndex:index];
    
    [self.animationHelper changeModeFromHidden:btn_hide ToShow:btn_show];
    [self changeGameMode:btn_show.tag];
    
}

#pragma mark -  ---------- save mode  ----------

- (void)saveMode {
//    NSLog(@"save :%ld", (long)self.gameMode);
    
    [self.modeUserDefaults setInteger:self.gameMode forKey:MODEDEFAULTS];
    [self.modeUserDefaults synchronize]; //省略するとOSのタイミングでsaveされるので半強制
}

#pragma mark - --------- load ----------

- (void)loadMode {
//    NSLog(@"load :%ld", (long)self.gameMode);
    
    self.gameMode = [self.modeUserDefaults integerForKey:MODEDEFAULTS];
    
}

@end
