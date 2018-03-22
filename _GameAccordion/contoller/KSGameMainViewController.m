//
//  KSGameMainViewController.m
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/29.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

/**
 * menu system is provided by
 *  RNGridMenu
 * https://github.com/rnystrom/RNGridMenu
 */

#import "KSGameMainViewController.h"

//mode
#import "KSModeContex.h"
#import "KSModeSeven.h"
#import "KSModeForteen.h"
#import "KSModeTwentyOne.h"
#import "KSJudge.h"

@interface KSGameMainViewController ()

@property (nonatomic, retain) KSModeContex      *modeContex;
@property (nonatomic, retain) NSMutableArray    *stockedCardArray;
@property (nonatomic, retain) NSMutableArray    *cardsStateOnField;
@property (nonatomic, retain) NSMutableArray    *masuStateOnField;
@property (nonatomic,retain) NSMutableArray* masuViewArray;

@property (nonatomic, retain) KSCard            *activeCard;
@property (nonatomic) CGRect                    activePosition;
@property (nonatomic, retain) KSCard            *preOneCard;
@property (nonatomic, retain) KSCard            *preThreeCard;
@property (nonatomic) BOOL                      isIntersect;
@property (nonatomic) BOOL                      isIntersect3;
@property (nonatomic, retain) KSJudge           *judge;

@property (nonatomic) NSInteger                 removeTag;
@property (nonatomic, retain) UIButton          *menuBtn;
@property (nonatomic, retain) UILabel           *scoreLabel;

@end

CGFloat const kLabelPosiY = 15.0f;
CGFloat const kLabelWidth = 100.0f;
CGFloat const kLabelHeight = 15.0f;

@implementation KSGameMainViewController

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        // Custom initialization
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //judgement
    self.judge = [KSJudge new];
    
    //score label
    self.scoreLabel = [UILabel new];
    CGFloat posiX = SCREEN_SIZE.height - kLabelHeight * 2.5;
    self.scoreLabel.frame = CGRectMake(posiX, kLabelPosiY, kLabelWidth, kLabelHeight);
    self.scoreLabel.backgroundColor = [UIColor clearColor];
    self.scoreLabel.font = [UIFont fontWithName:APPLI_FONT size:12];
    [self.view addSubview:self.scoreLabel];
    
    //notice
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keepActiveCardInfo) name:CARD_TOUCH_START object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkActiveCard) name:CARD_TOUCH_END object:nil];
    
    
    //drug behavior add
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(showMenu)];
    [self.menuBtn addGestureRecognizer:pan];

    self.menuBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menuBtn.frame = CGRectMake(0, kLabelPosiY, kLabelWidth, kLabelHeight);
    [self.menuBtn setTitle:@"Menu" forState:UIControlStateNormal];
    self.menuBtn.backgroundColor = [UIColor grayColor];
    [self.menuBtn addTarget:self
                     action:@selector(showMenu)
           forControlEvents:UIControlEventTouchUpInside];
    [self.menuBtn.titleLabel setFont:[UIFont fontWithName:APPLI_FONT size:12]];
    [self.view addSubview:self.menuBtn];
}


- (void)viewWillAppear:(BOOL)animated { //restart時に必要な処理
    
    [super viewWillAppear:animated];
//    [self masuRefresh];
    [self selectedModeTreatment];
    [self masuLayout];
    
    [self refreshGame];
    [self updateScore];

}

- (void)selectedModeTreatment {
    self.modeContex = [KSModeContex new];
    if ( self.gameMode > GAME_MODE_MAX - 1 ) {
        NSLog(@"error at %@", NSStringFromSelector(_cmd));
    }
    
    [self gameModeSelect:self.gameMode];
    [[KSMasuManager sharedManager] selectGameMode:self.gameMode];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gameModeSelect:(NSInteger)mode {
    
    switch ((int)mode ) {
        case GAME_MODE_7:
            [self.modeContex changeMode:[KSModeSeven sharedMode]];
            break;
            
        case GAME_MODE_14:
            [self.modeContex changeMode:[KSModeForteen sharedMode]];
            break;
            
        case GAME_MODE_21:
            [self.modeContex changeMode:[KSModeTwentyOne sharedMode]];
            break;
            
        default:
            NSLog(@"error at %@", NSStringFromSelector(_cmd));
            [self.modeContex changeMode:[KSModeSeven sharedMode]];
            break;
    }
    
}

- (void)masuLayout {
    self.masuViewArray = (NSMutableArray*)[[KSMasuManager sharedManager] makeMasusByMode];
//    NSArray    *arr = [[KSMasuManager sharedManager] makeMasusByMode];
    for ( KSMasu *masu in self.masuViewArray ) {
        [self.view addSubview:masu];
    }
}
-(void) masuRefresh{
    for (KSMasu* masu in self.masuViewArray) {
        [masu removeFromSuperview];
    }
    self.masuViewArray = @[].mutableCopy;

}

- (void)dealCards {
    //card
    self.stockedCardArray = [[self.modeContex getCards] mutableCopy];
    
    //masu
    NSArray    *_masuArray = [KSMasuManager sharedManager].masuArray;
    self.masuStateOnField = [ _masuArray mutableCopy];
    NSArray    *centerArray = [KSMasuManager sharedManager].masuCenterArray;
    
    //deal
    for ( int i = 0; i < self.modeContex.cardMAX; i++ ) {
        KSCard     *card = [self.stockedCardArray objectAtIndex:i];
        
        NSValue    *val    = [centerArray objectAtIndex:i];
        CGPoint    _center = [val CGPointValue];
        card.center = _center;
        
        KSMasu     *masu = [self.masuStateOnField objectAtIndex:i];
        [self.masuStateOnField replaceObjectAtIndex:i withObject:masu];
        
        [self.view addSubview:card];
        
        [self.stockedCardArray removeObjectAtIndex:i];
        [self.cardsStateOnField addObject:card];
        
    }
    
}


- (void)refreshGame {
    
    // initialize
    for ( KSCard *card in self.cardsStateOnField ) {
        [card removeFromSuperview];
    }
    
    self.cardsStateOnField = @[].mutableCopy;
    self.masuStateOnField  = @[].mutableCopy;
    self.stockedCardArray  = @[].mutableCopy;
    

    [self dealCards];
    [self updateScore];
}

- (void)returnToStart {
    if ( ![self isBeingDismissed] ) {
        [self masuRefresh];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
}


#pragma mark - from Notifocation and card judgment
- (void)keepActiveCardInfo { // activeカードの情報を取得する
    
    //初期化
    if ( self.preOneCard != nil ) {
        self.preOneCard = nil;
    }
    if ( self.preThreeCard != nil ) {
        self.preThreeCard = nil;
    }
    
    for ( int i = 0; i < [self.cardsStateOnField count]; i++ ) {
        KSCard    *card = [self.cardsStateOnField objectAtIndex:i];
        if ( card.isActived ) {
            [self.view bringSubviewToFront:card];
            self.activeCard     = card;
            self.activePosition = card.frame;
        }
    }
    
    KSMasu    *activeMasu = [[KSMasuManager sharedManager] getMasuFromCGPoint:self.activeCard.center];
    
    //一つ前
    KSMasu    *beforeOne = [[KSMasuManager sharedManager]
                            masuOfActiveCardBeforeMasu:masuBeforeOne
                            activieMasu:activeMasu];
//    NSLog(@"masu index befor one is %ld", (long)beforeOne.masuIndex);
    
    for ( KSCard *card in self.cardsStateOnField ) {
        if ( CGRectIntersectsRect(card.frame, beforeOne.frame)) {
            self.preOneCard = card;
            //            NSLog(@"!!!! bing! pre-card number is %@", self.preOneCard.number);
        }
    }
    
    //3つ前
    KSMasu    *beforeThree = [[KSMasuManager sharedManager]
                              masuOfActiveCardBeforeMasu:masuBeforeThree
                              activieMasu:activeMasu];
    for ( KSCard *card in self.cardsStateOnField ) {
        if ( CGRectIntersectsRect(card.frame, beforeThree.frame)) {
            self.preThreeCard = card;
            //            NSLog(@"!!!! bing! 3-card number is %@", self.preThreeCard.number);
        }
    }
    
}

//touch endで呼ばれる
- (void)checkActiveCard {
    
    [self setJudgementParameter];
    BOOL    canMove = [self.judge canMoveOnCard];
    
    if ( canMove ) {   //成功
        
        //active cardをtargetに移動
        self.activeCard.frame = self.judge.target.frame;
        
        self.removeTag = [self.judge getRemoveTag:self.cardsStateOnField
                                        activetag:self.judge.active.tag];
        if ( self.removeTag == 0 ) {
            NSLog(@"removeTag is 0, should be not 0, error at %@", NSStringFromSelector(_cmd));
            
        }
        
        //card move
        [self cardMoveingForFilling];
        
        if ( self.isIntersect ) {
            [self treatmentForPreOneCard];
        } else if ( self.isIntersect3 ) {
            [self treatmentForPreThreeCard];
        } else {
            NSLog(@"error at %@", NSStringFromSelector(_cmd));
            NSLog(@"check flugs");
        }
        
        //card deal
        [self aCardDealAfterRemoveSucess];
        
        //下のカードviewを削除
        [self.judge.target removeFromSuperview];
        
    } else {  //失敗
        
        [self backToOriginalPosition];
    }
    
    [self resetVariables];
    [self updateScore];
    
}

- (void)backToOriginalPosition {
    
    self.activeCard.frame = CGRectOffset(self.activePosition, 0, CARD_SELECTION_OFFSET);
//    NSLog(@"in-active card tag is %ld", (long)self.activeCard.tag);
    
}

- (void)setJudgementParameter {
    
    //重なり判定
    self.isIntersect  = CGRectIntersectsRect(self.preOneCard.frame, self.activeCard.frame);
    self.isIntersect3 = CGRectIntersectsRect(self.preThreeCard.frame, self.activeCard.frame);
    self.judge.active = self.activeCard;
    
    if ( self.isIntersect ) {
        self.judge.target = self.preOneCard;
        
    } else if ( self.isIntersect3 ) {
        self.judge.target = self.preThreeCard;
        
    } else {
        self.judge.target = nil;
    }
    
}

- (void)treatmentForPreOneCard {
    
    // card remove from array
    [self.cardsStateOnField removeObjectAtIndex:self.removeTag - 1];
    
}

- (void)treatmentForPreThreeCard {
    
    // card remove from array
    [self.cardsStateOnField replaceObjectAtIndex:self.removeTag - 3 withObject:self.judge.active];
    [self.cardsStateOnField removeObjectAtIndex:self.removeTag];
    
}

- (void)cardMoveingForFilling {
    //card move
    NSArray    *centerArray = [KSMasuManager sharedManager].masuCenterArray;
    if ( self.removeTag != [self.cardsStateOnField count] - 1 ) { //一番最後の場合、カードを詰めつ必要がない
        for ( int i = (int)self.removeTag + 1; i < [self.cardsStateOnField count]; i++ ) {
            KSCard     *card   = [self.cardsStateOnField objectAtIndex:i];
            NSValue    *val    = [centerArray objectAtIndex:i - 1];
            CGPoint    _center = [val CGPointValue];
            card.center = _center;
        }
    }
    
}

- (void)aCardDealAfterRemoveSucess {
    NSArray    *centerArray = [KSMasuManager sharedManager].masuCenterArray;
    if ( [self.stockedCardArray count] > 0 ) {
        KSCard     *card   = [self.stockedCardArray firstObject];
        NSValue    *val    = [centerArray lastObject];
        CGPoint    _center = [val CGPointValue];
        card.center = _center;
        [self.view addSubview:card];
        [self.stockedCardArray removeObjectAtIndex:0];
        [self.cardsStateOnField addObject:card];
    }
    
}

- (void)resetVariables {
    if ( self.judge.target != nil ) {
        self.judge.target = nil;
    }
    
    if ( self.judge.active != nil ) {
        self.judge.active = nil;
    }
    
    self.isIntersect  = NO;
    self.isIntersect3 = NO;
    
    for ( KSCard *card in self.cardsStateOnField ) {
        if ( card.isActived ) {
            self.activeCard.isActived = NO;
        }
    }
    
    [self endingJudgement];
    
}

#pragma mark - ending
- (void)endingJudgement {    //終了判定
    
    BOOL    isCardLastPosi = [self.judge isCardExstAtMaxPosi:self.modeContex.cardMAX
                                                   cardstate:self.cardsStateOnField];
    if ( isCardLastPosi ) { //移動判定を行う
        [self judgeMiving];
        
    } else { //山にカードがあるか判定
        BOOL    isStocked = [self.judge isStockedCardArrayNotZero:self.stockedCardArray];
        
        //山にカードがあれば継続で何も処理しない。
        //山にカードがなければ以下の処理を行う
        if ( !isStocked ) {
            
            NSUInteger    cardNumberOnField = [self.cardsStateOnField count];
            if ( cardNumberOnField == 1 ) { // GAME > Clear
                [self clearGame];
            } else { //移動判定を行う
                [self judgeMiving];
            }
        }
        
    }
    
}

- (void)judgeMiving {
    // yes > 継続
    // no > game over
    BOOL    isGemeOver = [self canAnyCardMove];
    if ( !isGemeOver ) {
        
        [self showResult_IsClear:NO];
    }
}

- (void)clearGame {

    [self showResult_IsClear:YES];
}

- (BOOL)canAnyCardMove { // 移動判定を行う
    // yes > 継続
    // no > game over
    
    BOOL    canMove = NO;
    
    //color check
#warning 計算量を減らすために、ブレイクを仕掛けるように変更すること！
    for ( int i = 0; i < [self.cardsStateOnField count] - 1; i++ ) { //一番最後のカードは判断しない
        KSCard    *card     = [self.cardsStateOnField objectAtIndex:i];
        KSCard    *nextCard = [self.cardsStateOnField objectAtIndex:i + 1];
        
        if ( [card.backgroundColor isEqual:nextCard.backgroundColor] ) {
            return YES;
            
        }
        
        if ( i + 3 < [self.cardsStateOnField count] ) {
            KSCard    *threeBefor = [self.cardsStateOnField objectAtIndex:i + 3];
            if ( [card.backgroundColor isEqual:threeBefor.backgroundColor    ] ) {
                return YES;
                
            }
        }
        
    }
    
    //number check
    for ( int i = 0; i < [self.cardsStateOnField count] - 1; i++ ) { //一番最後のカードは判断しない
        KSCard    *card     = [self.cardsStateOnField objectAtIndex:i];
        KSCard    *nextCard = [self.cardsStateOnField objectAtIndex:i + 1];
        
        if ( [card.number isEqualToString:nextCard.number] ) {
            return YES;
            
        }
        if ( i + 3 < [self.cardsStateOnField count] ) {
            KSCard    *threeBefor = [self.cardsStateOnField objectAtIndex:i + 3];
            if ( [card.number isEqualToString:threeBefor.number] ) {
                return YES;
            }
        }
    }
    
    return canMove;
}

#pragma mark -  ---------- menu  ----------
#warning TODO:暫定的な設定、順次改善していくこと
- (void)showMenu {
    NSInteger    numberOfOptions = 3;
    NSArray      *options        = @[
                                     @"Top",
                                     @"Restart",
                                     @"Cancel"
                                     //                         @"Bluetooth",
                                     //                         @"Deliver",
                                     //                         @"Download",
                                     //                         @"Enter",
                                     //                         @"Source Code",
                                     //                         @"Github"
                                     ];
    RNGridMenu    *av = [[RNGridMenu alloc] initWithTitles:[options subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    av.itemFont = [UIFont boldSystemFontOfSize:18];
    av.itemSize = CGSizeMake(150, 55);
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width / 2.f, self.view.bounds.size.height / 2.f)];
    
}

-(void) updateScore{
    self.scoreLabel.text = [NSString stringWithFormat:@"%lu / 52", (unsigned long)[self.stockedCardArray count]];
}

#pragma mark -  ---------- delegate from RNGridMenu  ----------
- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    
    if ( itemIndex == 0 ) { // show menu
        [self returnToStart];
        
    } else if ( itemIndex == 1 ) { // ReStart
        [self refreshGame];
        
        
    } else if ( itemIndex == 2 ) { // Cancel
        
    } else {
        NSLog(@"itemIndes has error at %@", NSStringFromSelector(_cmd));
    }
    
}



#pragma mark -  ---------- show result  ---------- 
- (void)showResult_IsClear:(BOOL)clear {

    UIView* rView = [[UIView alloc] initWithFrame:CGRectMake(-1 * SCREEN_SIZE.height, 0, SCREEN_SIZE.height, SCREEN_SIZE.width)];
    
    
    if (clear) {
        rView.backgroundColor = [UIColor greenColor];
    }else{
        rView.backgroundColor = [UIColor redColor];

    }
    
    rView.alpha = 0.9f;
    [self.view addSubview:rView];
    
    UILabel* message  = [UILabel new];
    message.frame = CGRectMake(0, 0, SCREEN_SIZE.height* 0.5, SCREEN_SIZE.width *0.5);
    message.center = CGPointMake(SCREEN_SIZE.height* 0.5, SCREEN_SIZE.width* 0.5);
    if (clear) {
        message.text = @"GAME CLEAR";
        
    } else {
        message.text = @"GAME OVER";

    }
    message.font = [UIFont fontWithName:APPLI_FONT size:36];
    [rView addSubview:message];
    
    
    
    [UIView animateWithDuration:0.3f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         rView.frame = CGRectOffset(rView.frame, SCREEN_SIZE.height, 0);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3f
                                               delay:2.5f
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              rView.frame = CGRectOffset(rView.frame, SCREEN_SIZE.height, 0);

                                          } completion:^(BOOL finished) {
                                               [self showMenu];
                                              [rView removeFromSuperview];
                                          }];
                     }];
    
}


@end
