//
//  KSViewController.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/07/30.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

#import "KSMainViewController.h"
#import "KSScoreViewController.h"
#import "KSDiviceHelper.h"
#import "KSMenuButton.h"
#import "KSResults.h"
#import "KSCoreDataController.h"
#import "KSMenuAnimationHelper.h"
#import "KSCardManager.h"
#import "KSMasuManager.h"
#import "KSCardNumberManager.h"
#import "KSCard.h"
#import "deff.h"
#import "KSMarkManager.h"
#import "KSYakuManager.h"
#import "KSMenuView.h"
#import "KSDataFormatter.h"

//divice state
#import "KSDiviceStateContext.h"
#import "KSButtonDown.h"
#import "KSButtonTop.h"
#import "KSButtonLeft.h"
#import "KSButtonRight.h"

@interface KSMainViewController ()

@property (nonatomic, retain) KSMasuManager     *masuManager;
@property (nonatomic, retain) KSYakuManager     *yakuManager;
@property (nonatomic, retain) KSMarkManager     *markManager;

@property (nonatomic, retain) NSMutableArray    *removedAddress;
@property (nonatomic, retain) NSMutableArray    *masuArray;
@property (nonatomic, retain) NSMutableArray    *touchedCardArray;
@property (nonatomic, retain) NSMutableArray    *touchedNumberArray;
@property (nonatomic) BOOL                      isMasuFilled;

//divice kindsによってマス数を変える
@property (nonatomic) NSInteger                 masuMax_y;

// divice orientation
@property (nonatomic) deviceDirection           interfaceOrientation;

//observer for touch ending
@property (nonatomic) BOOL                      isTouchEndEnding;
@property (nonatomic, retain) NSTimer           *touchEndingTimer;

//タッチしたマスにemptyが含まれるかどうか
//含まれる場合はYaku判断しない
@property (nonatomic) BOOL                             isTouchedCardIncludeEmpty;

//play timer
@property (nonatomic, retain) NSTimer                  *play;

//muneButton
@property (nonatomic, retain) KSMenuButton             *time_menuButton;
@property (nonatomic, retain) KSMenuButton             *socre_menuButton;
@property (nonatomic, retain) KSMenuView               *menuView;            //透明な背景
@property (nonatomic, retain) KSMenuAnimationHelper    *mAnimationHelper;

//save data
@property (nonatomic) NSInteger                        totalScore;
@property (nonatomic) CGFloat                          playTime;
@property (nonatomic) NSInteger                        remainCards;

//display card number
- (void)displayCardNumber:(KSCard *)card number:(NSInteger)number;

// giveUP indicate label
@property (nonatomic, retain) UILabel                 *giveUpLabel;
@property (nonatomic, retain) NSTimer                 *giveUpTimer;
@property (nonatomic) CGFloat                         noTouchedTime;
@property (nonatomic) BOOL                            isNoMoreTouched;
@property (nonatomic) BOOL                            isPuruPuruAnimation;

//score label
@property (nonatomic, retain) UILabel                 *yakuScoreLabel;

//state pattern
@property (nonatomic, retain) KSDiviceStateContext    *stateContex;

//SE & BGM
@property (nonatomic, retain) AVAudioPlayer           *audio;

//ending
@property (nonatomic, retain) UIView                  *endingView;

@end

@implementation KSMainViewController

#pragma mark -
#pragma mark ---------- life cycle ----------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    NSLog(@"mode %@",self.gameMode);
    
    // divice
    if ( [KSDiviceHelper is568h] ) {
        self.masuMax_y = MASU_Y_MAX;
    } else {
        self.masuMax_y = MASU_Y_MAX_EXCEPT_iPhone5;
    }
    
    NSNotificationCenter    *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(applicationWillEnterForeground:)
                   name:UIApplicationWillEnterForegroundNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(didRotate:)
                   name:@"UIDeviceOrientationDidChangeNotification"
                 object:nil];
    
    // manu animation helper
    self.mAnimationHelper          = [KSMenuAnimationHelper new];
    self.mAnimationHelper.delegate = self;
    
    //display timer
    self.time_menuButton = [[KSMenuButton new] timerButton];
    [self.time_menuButton addTarget:self
                             action:@selector(showMenu)
                   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.time_menuButton];
    
    //display score
    self.socre_menuButton = [[KSMenuButton new] scoreButton];
    [self.view addSubview:self.socre_menuButton];
    
    // yaku score label
    self.yakuScoreLabel = ({
        UILabel *lab = [UILabel new];
        CGRect rect = self.socre_menuButton.frame;
        rect.origin.x = SCREEN_SIZE.width;
        lab.frame = rect; // 画面の外に待機
        lab.font = [UIFont fontWithName:APPLI_FONT size:20];
        lab.textColor = [UIColor whiteColor];
        lab.backgroundColor = COLOR_red;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"yaku score";
        lab.alpha = 0;
        [self.view addSubview:lab];
        lab;
    });
    
    //giveUp indicate Label
    
    self.giveUpLabel = ({
        UILabel *lab = [UILabel new];
        lab.frame = CGRectMake(GIVE_UP_INDICATOR_X_POSI,
                               -1 * GIVE_UP_INDICATOR_height,
                               GIVE_UP_INDICATOR_width,
                               GIVE_UP_INDICATOR_height);
        lab.text = @"Give Up? Push it";
        lab.backgroundColor = [UIColor clearColor];
        lab.alpha = 1.0;
        lab.font = [UIFont fontWithName:APPLI_FONT size:GIVE_UP_INDICATOR_FONT_SIZE];
        lab.textColor = COLOR_red;
        [self.view addSubview:lab];
        lab;
    });
    
    //state
    self.stateContex = [KSDiviceStateContext new];
    [self.stateContex changeState:[KSButtonDown sharedState]];
    
    //SE and BGM
    
    NSString    *path = [[NSBundle mainBundle]
                         pathForResource:@"ppBGM" ofType:@"caf"]; //bgm1.mp3ってファイルを読み込んでます。
    NSURL       *url = [NSURL fileURLWithPath:path];
    self.audio = [[AVAudioPlayer alloc]
                  initWithContentsOfURL:url error:nil];
    self.audio.volume        = 0.5;
    self.audio.numberOfLoops = -1;
    
}

- (void)viewWillAppear:(BOOL)animated { //restart時に必要な処理
    
    [super viewWillAppear:animated];
    
    
    // touchEnd イベントを捉える
    self.touchEndingTimer = [NSTimer scheduledTimerWithTimeInterval:TOUCH_EVENT_INTERVAL
                                                             target:self
                                                           selector:@selector(touchEndingTreatment:) userInfo:nil repeats:YES];
    self.isTouchEndEnding = NO;
    
    _isMasuFilled   = NO,
    _removedAddress = @[].mutableCopy;
    
    // yaku manager
    if ( self.yakuManager == nil ) {
        self.yakuManager = [KSYakuManager new];
    }
    self.isTouchedCardIncludeEmpty = NO;
    
    //touched
    self.touchedCardArray = @[].mutableCopy;
    
    // masu manager
    if ( self.markManager == nil ) {
        self.masuManager = [KSMasuManager new];
    }
    self.masuArray = _masuManager.masuArray;
    
    //marker manager
    if ( self.markManager == nil ) {
        self.markManager = [KSMarkManager new];
    }
    _markerArray                 = [self.markManager makeMarkSets:CARD_SET_NUMBER_DEFAULT];
    self.markManager.markerCount = [_markerArray count];
    
    //card appear
    [self prepCards];
    
    //play timer
#define INTERVAL_PLAY_TIMER 0.1f
    self.playTime = 0.0f;
    self.play     = [NSTimer scheduledTimerWithTimeInterval:INTERVAL_PLAY_TIMER
                                                     target:self
                                                   selector:@selector(displayPlayTime)
                                                   userInfo:nil
                                                    repeats:YES];
    
    //save data init
    self.totalScore = 0;
    [self displayScore];
    
    //give-up and cancel menu prep
    [self prepGiveAndCancelMenu];
    
    self.isPuruPuruAnimation = NO;
    self.isNoMoreTouched     = NO;
    self.noTouchedTime       = 0;
    self.giveUpTimer         = [NSTimer scheduledTimerWithTimeInterval:INTERVAL_GIVE_UP_TIMER
                                                                target:self
                                                              selector:@selector(giveUpAnimationTrigger)
                                                              userInfo:nil
                                                               repeats:YES];
    
    [self.audio play];
    
    [self deviceOrientationInit];
    
    
#warning game ending testing
    //TODO:game ending test
//    [self gameEnding];

    
}

- (void)viewDidAppear:(BOOL)animated {
    // [self.mAnimationHelper showCard:[[KSCardManager sharedManager] cardArray]];
    
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    NSLog(@"application will enter forground called");
    [self deviceOrientationInit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -
#pragma mark ---------- divice orientation ----------
- (void)deviceOrientationInit {
    
    [self didRotate:self];
    
}

#pragma mark -
#pragma mark ---------- display: time & score ----------

- (void)prepCards {
    
    int    indexSmall = 1;
    int    indexLarge = 1;
    for ( KSMasu *masu in self.masuArray ) {
        
        KSCard    *card = [[KSCard alloc] initWithMasu:masu.masuPoint];
        card.tag = indexSmall + (indexLarge * CARD_TAG_SECOND_DIGIT);
        
        // marker set
        card.mark = [_markerArray objectAtIndex:indexSmall];
        self.markManager.markerCount--;
        [self displayCardNumber:card number:card.mark.number];
        UIImage    *img = [[KSCardManager sharedManager] cardColorConvertUIimage:card.mark.color];
        [card.backImg setImage:img];
        [[KSCardManager sharedManager] addCard:card];
        [self.view addSubview:card];
        
#warning game ending testing
        // should be NO;
        card.hidden = NO;
        
        indexSmall++;
        indexLarge++;
        
    }
    
}

- (void)removeCardsForInit {
    NSArray    *cards = [KSCardManager sharedManager].cardArray;
    for ( KSCard *card in cards ) {
        [card removeFromSuperview];
    }
    [KSCardManager sharedManager].cardArray = @[].mutableCopy;
}

- (void)displayCardNumber:(KSCard *)card number:(NSInteger)number {
    card.marker.text = [NSString stringWithFormat:@"%d", card.mark.number ];
    
}

- (void)displayPlayTime {
    self.playTime += INTERVAL_PLAY_TIMER;
    
    int    hour   = 0;
    int    minute = 0;
    int    second = 0;
    
    hour   = self.playTime / 3600;
    minute = (self.playTime - (hour * 3600)) / 60;
    second = (self.playTime - (hour * 3600) - (minute * 60));
    
    self.time_menuButton.numberLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second];
    
}

- (void)displayScore {
    
    KSDataFormatter    *df       = [KSDataFormatter new];
    NSString           *scoreStr = [df scoreFormatted:self.totalScore];
    self.socre_menuButton.numberLabel.text = [NSString stringWithFormat:@"%@", scoreStr];
}

- (void)displayYakuScore {
    self.yakuScoreLabel.text = [NSString stringWithFormat:@"+ %d", [self.yakuManager calculatedScore]];
    [self.mAnimationHelper showYakuScoreLabel:self.yakuScoreLabel];

}

- (void)giveUpAnimationTrigger {
    self.noTouchedTime += INTERVAL_GIVE_UP_TIMER;
    
    if ( !self.isPuruPuruAnimation ) { // puru puru aninationしていない
        if ( self.noTouchedTime > NO_ACTION_TIME_LIMIT ) {
            //give up indicator apperar
            [self.mAnimationHelper giveUpLabelBound:self.giveUpLabel]; //indicator apperar
            self.noTouchedTime       = 0;
            self.isPuruPuruAnimation = YES; // puru puru aninationする
        }
    } else {
        if ( self.noTouchedTime > PURU_PURU_INTERVAL ) {
            [self.mAnimationHelper giveUpLabelPuruPuru:self.giveUpLabel];
            self.noTouchedTime = 0;
        }
        
    }
    
}

- (void)hideGuveUpIndicator {
    if ( self.giveUpLabel.frame.origin.y == GIVE_UP_INDICATOR_Y_POSI ) { // indicator appear
        [self.mAnimationHelper giveUpLabelHidden:self.giveUpLabel];
        
    }
    
}

#pragma mark -
#pragma mark ---------- 画面遷移 ----------
- (void)prepGiveAndCancelMenu {
    // give-up and cancel menu
    self.menuView = ({
        KSMenuView *menu = [[KSMenuView new] GiveAndCancelMenu];
        [self.view addSubview:menu];
        menu;
    });
    
}

- (void)showMenu {
    [self.audio pause];
    
    KSMenuButton    *giveUpButton = [[KSMenuButton new] giveUpButton];
    [giveUpButton addTarget:self
                     action:@selector(showScoreView)
           forControlEvents:UIControlEventTouchDown];
    [self.menuView addSubview:giveUpButton];
    
    KSMenuButton    *CancelButton = [[KSMenuButton new] cancelButton];
    [CancelButton addTarget:self
                     action:@selector(cancelMenu)
           forControlEvents:UIControlEventTouchDown];
    [self.menuView addSubview:CancelButton];
    
    //animation
    [self.mAnimationHelper showGiveUpMenu:self.menuView];
}

- (void)cancelMenu {
    
    [UIView animateWithDuration:0.6f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         CGRect rect = self.menuView.frame;
                         rect.origin.x = SCREEN_SIZE.width;
                         self.menuView.frame = rect;
                         
                     } completion:^(BOOL finished) {
                         [self.menuView removeFromSuperview];
                         [self prepGiveAndCancelMenu];
                         [self.audio play];
                     }];
    
}

- (void)showScoreView {
    
    //save data
    [self saveScore];
    
    UIStoryboard             *storyboard          = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    KSScoreViewController    *scoreViewController = [storyboard instantiateViewControllerWithIdentifier:SCORE_SCENE];
    
    scoreViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:scoreViewController animated:YES completion:^{
        
        // data 受け渡しに利用できる
        //        scoreViewController.label.text = @"shimizu";
        
        // menuView破棄
        [self.menuView removeFromSuperview];
        // card 破棄
        [self removeCardsForInit];
        // each yaku counter init
        [self.yakuManager clearAllYaluCount];
        
        // BGM
        [self.audio stop];
        
        //ending view破棄
        [self.endingView removeFromSuperview];
        
    }];
    
}

#pragma mark -
#pragma mark ---------- touch ----------
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    self.noTouchedTime = 0; // touchがあればタイマーをリセットする
    
    // give up indicator
    self.isPuruPuruAnimation = NO; // puru puru animation end
    [self hideGuveUpIndicator];
    
    _isTouchEndEnding = NO;
    
    // touchで選択Cardの色を変化させる
    UITouch    *touch = [touches anyObject];
    CGPoint    cp     = [touch locationInView:self.view];
    
    //ending
    if (touch.view.tag == ENDING_VIEW_TAG) {
        NSLog(@"ending view touched");
        [self showScoreView];
        
    }
    
    //masuにカード有るか？
    BOOL       isCardNotExist = [[KSCardManager sharedManager] isEmptyCardAtPoint:cp];
    if ( isCardNotExist ) { //masuにカードなし
        self.isTouchedCardIncludeEmpty = YES;
        
    } else { //masuにカードあり
        self.isTouchedCardIncludeEmpty = NO;
        [[KSCardManager sharedManager] startingTouchingCard:cp];
        [[KSCardManager sharedManager] beginingColordCard:cp];
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if ( !self.isTouchedCardIncludeEmpty ) { //masuにカードがある状態なら
        
        UITouch    *touch = [touches anyObject];
        CGPoint    cp     = [touch locationInView:self.view];
        
        //移動先のmasuにカード有るか？も確認
        BOOL       isCardNotExist = [[KSCardManager sharedManager] isEmptyCardAtPoint:cp];
        if ( isCardNotExist ) {   //masuにカードなし
            self.isTouchedCardIncludeEmpty = YES;
            
        } else {   //masuにカードあり
            // masu処理
            [_masuManager didMasuTouchedAt:cp];
            
            // card処理
            [[KSCardManager sharedManager] touchedCardAt:cp];
            [[KSCardManager sharedManager] coloredCard:cp];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //color refresh
    [[KSCardManager sharedManager] refreshColoredCard];
    
    if ( !self.isTouchedCardIncludeEmpty ) {
        
        //役判断
        [self judgeYaku];
        
        //card捜査
        
        if ( self.yakuManager.score == 0 ) {
            [self touchedParametersReset];
            [self.touchedCardArray removeAllObjects];
            
            return;
            
        } else {
            
            [self removeCard];
            
        }
    }
    
    [self touchedParametersReset];
}

- (void)touchedParametersReset {
    
    [[KSCardNumberManager sharedManager] clearCardNumberArray];
    [self.yakuManager clearScore];
    [self.yakuManager clearYakuArray];
    [self.touchedNumberArray removeAllObjects];
        
}

#pragma mark -
#pragma mark ---------- touched treatment ----------

- (NSMutableArray *)touchedCards {
    
    self.touchedNumberArray = [KSCardNumberManager sharedManager].cardNumberArray;
    
    NSMutableArray    *cardArray    = [KSCardManager sharedManager].cardArray;
    NSMutableArray    *touchedArray = @[].mutableCopy;
    
    for ( int i = 0; i < [self.touchedNumberArray count]; i++ ) {
        NSInteger    targetNumber = [self.touchedNumberArray[i] integerValue];
        for ( KSCard *card in cardArray ) {
            if ( targetNumber == card.tag ) {
                [touchedArray addObject:card];
                
                break;
            }
        }
    }
    
    return touchedArray;
}

- (NSMutableArray *)touchedMarks {
    
    NSMutableArray    *markArray = @[].mutableCopy;
    
    for ( KSCard *card in [self touchedCards] ) {
        
        [markArray addObject:card.mark];
    }
    
    return markArray;
}

#pragma mark -
#pragma mark ---------- save  ----------

- (void)saveScore {
    
    // save
    KSResults    *newResults;
    newResults = [[KSCoreDataController sharedManager] insertNewEntity];
    
    //date
    newResults.date = [NSDate date];
    //score
    NSNumber    *number = @(self.totalScore);
    newResults.score       = number;
    newResults.playTime    = [NSString stringWithFormat:@"%@", self.time_menuButton.numberLabel.text];
    self.remainCards       = [[KSCardManager sharedManager] remainCardsWithStock:self.markManager.markerCount];
    newResults.remainCards = [NSString stringWithFormat:@"%d", self.remainCards];
    
    //yaku counter
    NSDictionary    *countDic = self.yakuManager.all_Yaku_Count;
    newResults.times_F   = [NSString stringWithFormat:@"%d", [countDic[DATA_FLASH] integerValue]];
    newResults.times_S   = [NSString stringWithFormat:@"%d", [countDic[DATA_STRAIGHT] integerValue]];
    newResults.times_P   = [NSString stringWithFormat:@"%d", [countDic[DATA_PAIR] integerValue]];
    newResults.times_PF  = [NSString stringWithFormat:@"%d", [countDic[DATA_PAIRFLASH] integerValue]];
    newResults.times_SF  = [NSString stringWithFormat:@"%d", [countDic[DATA_STRAIGHTFLASH] integerValue]];
    newResults.times_LSF = [NSString stringWithFormat:@"%d", [countDic[DATA_LOYAL_STRAIGHFLASH] integerValue]];
    
    //game mode 今回はnormal modeのみ
    newResults.mode = [NSString stringWithFormat:@"%@", self.gameMode];
    
    [[KSCoreDataController sharedManager] save];
}

#pragma mark -
#pragma mark ---------- card animation ----------

- (void)removeCardAnime:(NSInteger)index {
    
    NSInteger    number = index;
    [UIView animateWithDuration:ANIME_REMOVE_CARD_DURATION
                          delay:ANIME_REMOVE_CARD_DELAY
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         KSCard *card = (KSCard *)[self.touchedCardArray objectAtIndex:number];
                         card.alpha = 0;
                         
                     } completion:^(BOOL finished) {
                         
                         KSCard *card = (KSCard *)[self.touchedCardArray objectAtIndex:number];
                         card.alpha = 1;
                         card.hidden = YES;
                         
                         [_removedAddress addObject:[NSValue valueWithCGPoint:card.frame.origin]];
                         
                         // 待機所に移動させて再利用
                         CGRect rec = [[KSCardManager sharedManager] moveCardToReservePosition:card.frame direction:_interfaceOrientation];
                         card.frame = rec;
                         
                         _isMasuFilled = YES;
                         
                         if ( number < [self.touchedCardArray count] - 1 ) {
                             [self removeCardAnime:number + 1];
                             
                         } else {                                                                                                                                                                                                                                                                                                                                                   // removeすべき全てのCardの処理が全て終わったら
                             self.isTouchEndEnding = YES;
                             [self.touchedCardArray removeAllObjects];
                             
                         }
                         
                     }];
    
}

#pragma mark -
#pragma mark ---------- 役判断 ----------
- (void)judgeYaku {
    
    if ( [self touchedMarks] == 0 ) {
        return;
    }
    
    [self.yakuManager prepYakuArray:[self touchedMarks]];
    [self.yakuManager yaku];
    self.totalScore += [self.yakuManager calculatedScore];
    
    if ( [self.yakuManager calculatedScore] > 0 ) {
        [self displayYakuScore];
    }
    
}

#pragma mark -
#pragma mark ---------- card detect ----------
- (void)detectCard {
    
    switch ( _interfaceOrientation ) {
        case HOMEButton_Down:
            
            [KSButtonDown sharedState].markManager = self.markManager;
            
            break;
            
        case HOMEButton_Top:
            
            [KSButtonTop sharedState].markManager = self.markManager;
            
            break;
            
        case HOMEButton_Left:
            
            [KSButtonLeft sharedState].markManager = self.markManager;
            
            break;
            
        case HOMEButton_Right:
            
            [KSButtonRight sharedState].markManager = self.markManager;
            
            break;
            
        default:
            break;
    }
    
    [self.stateContex detectCardTreatment:_markerArray];
    
    //終了判定をする
    NSArray    *array     = [[KSCardManager sharedManager] searchMasuArray:_interfaceOrientation];
    BOOL       isGameOver = [[KSCardManager sharedManager] isEnd:array];
    if ( isGameOver ) {
        NSLog(@"GAME OVER or Error");
        [self.audio stop];
        [self gameEnding];
    }
    
    //初期化しておく
    _isMasuFilled = NO;
    [_removedAddress removeAllObjects];
    [_masuManager isCardOnInit];
    
}

- (void)removeCard {
    
    if ( [self.touchedNumberArray count] == 0 ) {
        NSLog(@"error at %@", NSStringFromSelector(_cmd));
        NSLog(@"touchedNumberArray has error");
    }
    [self.touchedCardArray addObjectsFromArray:(NSArray *)[self touchedCards]];
    
    [self removeCardAnime:0];
    
}

- (void)touchEndingTreatment:(NSTimer *)time {
    
    //remove card watcher
    if ( self.isTouchEndEnding && self.isMasuFilled ) {
        
        [self detectCard];
        self.isTouchEndEnding = NO;
    }
    
}

#pragma mark -
#pragma mark ---------- game ending ----------

- (void)gameEnding {
    
#warning refactoring! these code , move out other new class!
    // ending title
    self.endingView = ({
        UIView *eView = [UIView new];
        eView.frame = CGRectMake(0,
                                 0,
                                 SCREEN_SIZE.width * 0.9,
                                 SCREEN_SIZE.height*0.2);
        
        eView.center = CGPointMake(SCREEN_SIZE.width * 0.5,
                                   SCREEN_SIZE.height * 0.5);
        eView.backgroundColor = COLOR_green;
        eView.tag = ENDING_VIEW_TAG;
        //shadow
        // <layer corner round>
        CALayer    *mLayer = eView.layer;
        [mLayer setMasksToBounds:NO];
        [mLayer setCornerRadius:BUTTON_CORNER_ROUND];
        //<layer shadow>
        mLayer.shadowOpacity = 0.4;
        mLayer.shadowOffset  = SHADOW_OFFSET;
        mLayer.shadowColor   = [COLOR_MENU_Charactors CGColor];

        eView.alpha = 0;
        [self.view addSubview:eView];
        eView;
    });
    
    
#define POSI_Y_ADJUST_AT_ENDING 10

   
    UILabel* massageLabel =[UILabel new];
    massageLabel.frame = CGRectMake(10,
                               10,
                               250,
                               50);
    massageLabel.center = CGPointMake(self.endingView.frame.size.width*0.5,
                                 self.endingView.frame.size.height*0.5 - POSI_Y_ADJUST_AT_ENDING);
    massageLabel.text = @"Congratulations!";
    massageLabel.textAlignment = NSTextAlignmentCenter;
    massageLabel.font =[UIFont fontWithName:APPLI_FONT size:24];
    massageLabel.backgroundColor = [UIColor clearColor];
    [self.endingView addSubview:massageLabel];
   
    
    

    UILabel* notificationLabel =[UILabel new];
        notificationLabel.frame = CGRectMake(10,
                                 10,
                                 250,
                                 50);
        notificationLabel.center = CGPointMake(self.endingView.frame.size.width*0.5,
                                   self.endingView.frame.size.height*0.5 + POSI_Y_ADJUST_AT_ENDING);
        notificationLabel.text = [NSString stringWithFormat: @"Clear Bounus:%d x 2 = %d",self.totalScore, self.totalScore *2];
        notificationLabel.textAlignment = NSTextAlignmentCenter;
        notificationLabel.font =[UIFont fontWithName:APPLI_FONT size:14];
        notificationLabel.backgroundColor = [UIColor clearColor];
        [self.endingView addSubview:notificationLabel];
    
    
    //bounus point add
    self.totalScore = self.totalScore *2;
    
    [self.mAnimationHelper endingAnimation:self.endingView];
    

}

#pragma mark -
#pragma mark ---------- rotation ----------
- (void)didRotate:(id)sender {
    UIDeviceOrientation    o = [[UIDevice currentDevice] orientation];
    
    if ( o == UIDeviceOrientationPortrait ) {    // 縦向きで、ホームボタンが下になる向き
        
        _interfaceOrientation = HOMEButton_Down;
        [self.stateContex changeState:[KSButtonDown sharedState]];
        
        NSLog(@"device orientation is Portrait.");
        
    } else if ( o == UIDeviceOrientationPortraitUpsideDown ) {   // 縦向きで、ホームボタンが上になる向き
        
        _interfaceOrientation = HOMEButton_Top;
        [self.stateContex changeState:[KSButtonTop sharedState]];
        
        NSLog(@"device orientation is UpsideDown.");
        
    } else if ( o == UIDeviceOrientationLandscapeLeft ) {        // 横向きで、ホームボタンが右になる向き
        
        _interfaceOrientation = HOMEButton_Left;
        [self.stateContex changeState:[KSButtonLeft sharedState]];
        
        NSLog(@"device orientation is Left.");
        
    } else if ( o == UIDeviceOrientationLandscapeRight ) { // 横向きで、ホームボタンが左になる向き
        
        _interfaceOrientation = HOMEButton_Right;
        [self.stateContex changeState:[KSButtonRight sharedState]];
        
        NSLog(@"device orientation is Right.");
        
    } else if ( o == UIDeviceOrientationFaceUp ) { // 画面が上向き
        NSLog(@"device orientation is Face Up.");
        // no need actions.
        
    } else if ( o == UIDeviceOrientationFaceDown ) { // 画面が下向き
        NSLog(@"device orientation is Face Down.");
        // no need actions.
        
    } else {  // 向きが不明な場合
        NSLog(@"device orientation is Unkown.");
        //        [self interFaceOrientConvert];
        // no need actions.
        
    }
    
    [self.stateContex markerRotateByDevice];
    [self.stateContex fillCardsByDivceRotate];
    
    NSArray    *arr = [[NSArray alloc] initWithObjects:kGAME_MODE_ARRAY];
    NSLog(@"%@", [arr objectAtIndex:normalMode]);
}

#pragma mark -
#pragma mark ---------- delegate method ----------

- (void)cancelGiveUpAndCancelMenu:(KSMenuAnimationHelper *)helper {
    [self.audio play];
}

- (void)animationDidEnd:(KSMenuAnimationHelper *)helper {
    [self displayScore];
}

@end
