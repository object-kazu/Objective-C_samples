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
#import "KSCoreDataController.h"
#import "Data.h"

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
@property (nonatomic, retain) NSMutableArray    *masuViewArray;

@property (nonatomic, retain) KSCard            *activeCard;
@property (nonatomic) CGRect                    activePosition;
@property (nonatomic, retain) KSCard            *preOneCard;
@property (nonatomic, retain) KSCard            *preThreeCard;
@property (nonatomic) BOOL                      isIntersect;
@property (nonatomic) BOOL                      isIntersect3;
@property (nonatomic, retain) KSJudge           *judge;

@property (nonatomic) NSInteger                 removeTag;
@property (nonatomic, retain) UIButton          *menuBtn;
//menu button property
@property (nonatomic) CGPoint                   originPoint;
@property (nonatomic) CGFloat                   originAlpha;
@property (nonatomic, retain) UILabel           *scoreLabel;

//save data
@property (nonatomic) NSInteger                 remainCards;

// indicator
// for easy level
@property (nonatomic, retain) UIView     *indicatorView;
@property (nonatomic, retain) UILabel    *indicateFirst;

// for very easy level
@property (nonatomic, retain) UIView     *hintView;
@property (nonatomic, retain) UILabel    *hintLabel;

@end

#define INDICATOR_WIDTH  (SCREEN_SIZE.height * 0.25)
#define INDICATOR_HEIGHT (SCREEN_SIZE.height * 0.1)

CGFloat const    kLabelPosiY   = 15.0f;
CGFloat const    kLabelWidth   = 100.0f;
CGFloat const    kLabelHeight  = 15.0f;
CGFloat const    kMenuBarWidth = 5.0f;

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

    //status bar hidden
    if ( floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1 ) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }

    //judgement
    self.judge = [KSJudge new];

    //score label
    self.scoreLabel = [UILabel new];
    CGFloat    posiX = SCREEN_SIZE.height - kLabelHeight * 2.5;
    self.scoreLabel.frame           = CGRectMake(posiX, kLabelPosiY, kLabelWidth, kLabelHeight);
    self.scoreLabel.backgroundColor = [UIColor clearColor];
    self.scoreLabel.font            = [UIFont fontWithName:APPLI_FONT size:12];
    [self.view addSubview:self.scoreLabel];

    //notice
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keepActiveCardInfo) name:CARD_TOUCH_START object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkActiveCard) name:CARD_TOUCH_END object:nil];

    //menu button
    self.menuBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menuBtn.frame = CGRectMake(0, 0, kMenuBarWidth, SCREEN_SIZE.height);
    [self.menuBtn.titleLabel setFont:[UIFont fontWithName:APPLI_FONT size:12]];
    self.menuBtn.backgroundColor = [UIColor redColor];
    self.menuBtn.alpha           = 0.7;
    UIPanGestureRecognizer    *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(drugMenu:)];
    [self.menuBtn addGestureRecognizer:pan];
    [self.view addSubview:self.menuBtn];
    self.originPoint = self.menuBtn.center;
    self.originAlpha = 1.0f;

    self.indicatorView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, INDICATOR_HEIGHT)];
    self.indicatorView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:self.indicatorView];

    //!!! indicator viewを基本としているので注意
    self.hintView                 = [[UIView alloc] initWithFrame:self.indicatorView.frame];
    self.hintView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.hintView];
    self.hintView.hidden = YES;

}

//status bar hidden
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

- (void)viewWillAppear:(BOOL)animated { //restart時に必要な処理

    [super viewWillAppear:animated];

    [self selectedModeTreatment];
    [self masuLayout];

    [self refreshGame];
    [self updateScore];

//    NSLog(@"game level is %ld", (long)self.gameLevel);
    switch ( self.gameLevel ) {
        case LEVEL_NORMAL:
            [self hideIndicator];
            break;

        case LEVEL_EASY:
            [self showEasyIndicator];
            break;

        case LEVEL_VERY_EASY:
            [self showVeryEasyIndicator];
            break;

        default:
            NSLog(@"error at %@", NSStringFromSelector(_cmd));
            NSAssert(0, @"game level 定義されていない");
            break;
    }

    [self.view bringSubviewToFront:self.menuBtn];

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
    self.masuViewArray = (NSMutableArray *)[[KSMasuManager sharedManager] makeMasusByMode];
    for ( KSMasu *masu in self.masuViewArray ) {
        [self.view addSubview:masu];
    }
}

- (void)masuRefresh {
    for ( KSMasu *masu in self.masuViewArray ) {
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

    for ( KSCard *card in self.cardsStateOnField ) {
        if ( CGRectIntersectsRect(card.frame, beforeOne.frame)) {
            self.preOneCard = card;
        }
    }

    //3つ前
    KSMasu    *beforeThree = [[KSMasuManager sharedManager]
                           masuOfActiveCardBeforeMasu:masuBeforeThree
                                          activieMasu:activeMasu];
    for ( KSCard *card in self.cardsStateOnField ) {
        if ( CGRectIntersectsRect(card.frame, beforeThree.frame)) {
            self.preThreeCard = card;
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

        //indicator viewの更新
        [self updateIndicatorView];

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
                [self saveScore];
                [self showResult_IsClear:YES];

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
        [self saveScore];
        [self showResult_IsClear:NO];
    }
}

- (BOOL)canAnyCardMove { // 移動判定を行う
    // yes > 継続
    // no > game over

    BOOL    canMove = NO;

    for ( int i = 0; i < [self.cardsStateOnField count] - 1; i++ ) { //一番最後のカードは判断しない
        KSCard    *card     = [self.cardsStateOnField objectAtIndex:i];
        KSCard    *nextCard = [self.cardsStateOnField objectAtIndex:i + 1];

        if ( [card.backgroundColor isEqual:nextCard.backgroundColor] ) {
            return YES;

        }

        if ( [card.number isEqualToString:nextCard.number] ) {
            return YES;

        }

        if ( i + 3 < [self.cardsStateOnField count] ) {
            KSCard    *threeBefor = [self.cardsStateOnField objectAtIndex:i + 3];
            if ( [card.backgroundColor isEqual:threeBefor.backgroundColor    ] ) {
                return YES;

            }
            if ( [card.number isEqualToString:threeBefor.number] ) {
                return YES;
            }

        }

    }

    return canMove;
}

#pragma mark -  ---------- menu  ----------
- (void)drugMenu:(UIPanGestureRecognizer *)sender { // pan gestureから呼ばれる

    if ( sender.state == UIGestureRecognizerStateChanged ) {
        CGPoint    p          = [sender translationInView:self.view];
        CGPoint    movedPoint = CGPointMake(self.menuBtn.center.x + p.x, self.menuBtn.center.y);
        self.menuBtn.center = movedPoint;
        self.menuBtn.alpha -= 0.1f;
        [sender setTranslation:CGPointZero inView:self.view];

    }
    // ドラッグ移動 or ドラッグ終了
    if ( sender.state == UIGestureRecognizerStateEnded ) {

        [UIView animateWithDuration:0.20 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            // セル位置を元に戻す
            if ( sender.state == UIGestureRecognizerStateEnded ) {
                self.menuBtn.center = self.originPoint;
                self.menuBtn.alpha = self.originAlpha;
            }

        } completion:^(BOOL finished) {
            [self showMenu];

        }];

    }

}

- (void)showMenu {
    NSInteger    numberOfOptions = 3;
    NSArray      *options        = @[
        @"Top",
        @"Restart",
        @"Cancel"
                                   ];
    RNGridMenu    *av = [[RNGridMenu alloc] initWithTitles:[options subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    av.itemFont = [UIFont boldSystemFontOfSize:18];
    av.itemSize = CGSizeMake(150, 55);
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width / 2.f, self.view.bounds.size.height / 2.f)];

}

- (void)updateScore {
    self.scoreLabel.text = [NSString stringWithFormat:@"%lu / 52", (unsigned long)[self.stockedCardArray count]];
    self.remainCards     = CARD_COLOR_MAX * CARD_NUMBER_MAX;
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

    UIView    *rView = [[UIView alloc] initWithFrame:CGRectMake(-1 * SCREEN_SIZE.width, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];

    if ( clear ) {
        rView.backgroundColor = [UIColor greenColor];
    } else {
        rView.backgroundColor = [UIColor redColor];

    }

    rView.alpha = 0.9f;
    [self.view addSubview:rView];

    UILabel    *message = [UILabel new];
    message.frame  = CGRectMake(0, 0, SCREEN_SIZE.width * 0.5, SCREEN_SIZE.height * 0.5);
    message.center = CGPointMake(SCREEN_SIZE.width * 0.5, SCREEN_SIZE.height * 0.5);

    if ( clear ) {
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
        rView.frame = CGRectOffset(rView.frame, SCREEN_SIZE.width, 0);

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f
                              delay:2.5f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
            rView.frame = CGRectOffset(rView.frame, SCREEN_SIZE.width, 0);

        } completion:^(BOOL finished) {
            [self showMenu];
            [rView removeFromSuperview];
        }];
    }];

}

#pragma mark - --------- save  ----------
- (void)saveScore {

    // save
    Data    *newResults;
    newResults = [[KSCoreDataController sharedManager] insertNewEntity];

    //date
    newResults.date = [NSDate date];

    //score
    self.remainCards       = [self.stockedCardArray count] + [self.cardsStateOnField count];
    newResults.remainCards = [NSString stringWithFormat:@"%ld", (long)self.remainCards];

    //game mode
    newResults.mode = [NSString stringWithFormat:@"%ld", (long)self.gameMode];

    //game level
    NSString    *lString = @"";
    switch ( self.gameLevel ) {
        case LEVEL_NORMAL:
            lString = @"normal";
            break;

        case LEVEL_EASY:
            lString = @"easy";
            break;

        case LEVEL_VERY_EASY:
            lString = @"easier";
            break;

        default:
            NSLog(@"error at %@", NSStringFromSelector(_cmd));
            NSAssert(0, @"game level 定義されていない");
            break;
    }

    newResults.level = [NSString stringWithFormat:@"%@", lString];

    [[KSCoreDataController sharedManager] save];

}

#pragma mark - ----- indicator -----
// stockCardArrayを分析する

- (void)updateIndicatorView {

    if ( self.gameLevel == LEVEL_EASY ) {
        [self updateIndicator];

    } else if ( self.gameLevel == LEVEL_VERY_EASY ) {
        [self updateHintStrings];

    }

}

- (UILabel *)prepHintLabel {

    UILabel    *hint = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, INDICATOR_HEIGHT)];

    hint.font            = [UIFont fontWithName:APPLI_FONT size:12];
    hint.backgroundColor = [UIColor whiteColor];
    hint.attributedText  = [self hints];
    hint.textAlignment   = NSTextAlignmentRight;
    hint.numberOfLines   = 0;

    return hint;

}

- (void)updateHintStrings {
    self.hintLabel.attributedText = [self hints];
}

- (NSAttributedString *)preString {
    NSDictionary                 *firstLetter = @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:12] };

    NSDictionary                 *secondLetter = @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:10],
                                                    NSForegroundColorAttributeName: [UIColor grayColor] };
    NSDictionary                 *thirdLetter = @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:8],
                                                   NSForegroundColorAttributeName: [UIColor lightGrayColor] };
    NSMutableAttributedString    *string = [[NSMutableAttributedString alloc] initWithString:@">>>" attributes:firstLetter];
    [string addAttributes:secondLetter range:NSMakeRange(1, 1)];
    [string addAttributes:thirdLetter range:NSMakeRange(2, 1)];

    return string;

}

- (NSAttributedString *)postString {

    NSDictionary                 *firstLetter = @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:12] };

    NSDictionary                 *secondLetter = @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:10],
                                                    NSForegroundColorAttributeName: [UIColor grayColor] };
    NSDictionary                 *thirdLetter = @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:8],
                                                   NSForegroundColorAttributeName: [UIColor lightGrayColor] };
    NSMutableAttributedString    *string = [[NSMutableAttributedString alloc] initWithString:@"<<<" attributes:firstLetter];
    [string addAttributes:secondLetter range:NSMakeRange(1, 1)];
    [string addAttributes:thirdLetter range:NSMakeRange(0, 1)];

    return string;
}

- (NSAttributedString *)hints {

    NSDictionary                 *redDic  = @{ NSForegroundColorAttributeName: [UIColor redColor] };
    NSDictionary                 *grayDic = @{ NSForegroundColorAttributeName: [UIColor grayColor] };
    NSAttributedString           *sStr    = [self preString]; // >>>
    NSAttributedString           *eStr    = [self postString]; // <<<

    NSAttributedString           *dmi = [[NSAttributedString alloc] initWithString:@"," attributes:grayDic]; // ,

    NSMutableAttributedString    *tStr = [NSMutableAttributedString new];
    for ( int i = 0; i < [self.stockedCardArray count]; i++ ) {
        KSCard    *card = [self.stockedCardArray objectAtIndex:i];
        if ( i == 0 ) {
            NSAttributedString    *string = [[NSAttributedString alloc]initWithString:card.number
                                                                           attributes:redDic];
            [tStr appendAttributedString:string];

        } else {

            NSAttributedString    *string = [[NSAttributedString alloc] initWithString:card.number attributes:nil];
            [tStr appendAttributedString:string];
        }

        [tStr appendAttributedString:dmi];

    }

    NSMutableAttributedString    *string = [NSMutableAttributedString new];
    [string appendAttributedString:sStr];
    [string appendAttributedString:tStr];
    [string appendAttributedString:eStr];

    return string;
}

- (UILabel *)indicate1 {
    CGRect     rect = self.indicatorView.bounds;
    UILabel    *lab = [[UILabel alloc]initWithFrame:rect];
    lab.font          = [UIFont fontWithName:APPLI_FONT size:16];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.alpha         = 0.9;

    CGRect    under      = CGRectMake(0, rect.size.height, rect.size.width, rect.size.height * 0.07);
    UIView    *underline = [[UIView alloc]initWithFrame:under];
    underline.backgroundColor = [UIColor whiteColor];
    [lab addSubview:underline];

    return lab;

}

- (KSCard *)nextCard {
    return (KSCard *)[self.stockedCardArray firstObject];
}

- (void)updateIndicator {
    KSCard    *card = [self nextCard];
    if ( card == nil ) {
        self.indicateFirst.backgroundColor = [UIColor whiteColor];
        self.indicateFirst.text            = @"";
    } else {
        self.indicateFirst.backgroundColor = card.backgroundColor;
        self.indicateFirst.text            = card.number;

    }

}

- (void)hideIndicator {
    self.indicatorView.hidden = YES;
    self.hintView.hidden      = YES;
}

- (void)showEasyIndicator {
    self.indicatorView.hidden = NO;
    self.hintView.hidden      = YES;

    self.indicateFirst = [self indicate1];
    [self.indicatorView addSubview:self.indicateFirst];

    [self updateIndicator];

}

- (void)showVeryEasyIndicator {

    self.indicatorView.hidden = YES;
    self.hintView.hidden      = NO;

    self.hintLabel = [self prepHintLabel];

    [self.hintView addSubview:self.hintLabel];

}

@end
