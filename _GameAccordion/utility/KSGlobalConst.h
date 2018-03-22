//
//  KSGlobalConst.h
//  extendViewTest
//
//  Created by kazuyuki shimizu on 2014/01/18.
//  Copyright (c) 2014年 momiji-mac.com. All rights reserved.
//


//タグに関して
/*
 100番台はカードのタグとする！
 使用しないこと！
 */

#import <Foundation/Foundation.h>

/**
 *  global constant numbers
 */

#pragma mark - --------- GAME ----------

//play max cards
extern const NSInteger MAX_7;
extern const NSInteger MAX_14;
extern const NSInteger MAX_21;


//game field
extern const NSInteger GAME_FIELD_TAG;

#pragma mark- --------- display layer ----------

// eyeCatch
extern const CGFloat EYE_CATCH_width;
extern const CGFloat EYE_CATCH_height;

#pragma mark - --------- card ----------
typedef struct {
    NSInteger                       tagID;
    NSInteger                       numberID;
    __unsafe_unretained NSString    *colorID;
    
} CardID;


// card number
extern const NSInteger CARD_NUMBER_MAX;
extern const NSInteger CARD_COLOR_MAX;

//card marker animation
extern const CGFloat ANIME_MARKER_ROTATE_SPEED;
extern const CGFloat ANIME_MARKER_TORATE_DELAY;

// card's property
extern const NSInteger CARD_WIDTH;
extern const NSInteger CARD_HEIGHT;
extern const NSInteger CARD_TAG_SECOND_DIGIT;

// card animation
extern const CGFloat ANIME_FILL_CARD_DURATION;
extern const CGFloat ANIME_FILL_CARD_DELAY;
extern const CGFloat ANIME_REMOVE_CARD_DURATION;
extern const CGFloat ANIME_REMOVE_CARD_DELAY;
extern const CGFloat ANIME_HIDDEN_CARD_DURATION;
extern const CGFloat ANIME_HIDDEN_CARD_DELAY;

#pragma mark - --------- button ----------
// button
extern const CGFloat BUTTON_HEIGHT;
extern const CGFloat BUTTON_WIDTH;
extern const NSInteger BUTTONS_TOP_POSI;
extern const NSInteger BUTTONS_SPACE;
extern const CGFloat BUTTON_CORNER_ROUND;
extern const CGFloat ADJUST_BUTTON_HIGHT;

// menu button
extern const NSInteger MENU_BASE_POSI_X;
extern const NSInteger MENU_BASE_POSI_Y;
extern const NSInteger MENU_WIDTH;
extern const NSInteger MENU_HEIGHT;
extern const NSInteger MENU_LINE_BASE;
extern const NSInteger ADJUST_POSI_X;
extern const NSInteger ITEM_BASE_LINE;


//menu button の表示項目
extern const NSInteger ITEM_BASE_X;
extern const NSInteger ITEM_SUBJECT_WIDTH;
extern const NSInteger ITEM_SUBJECT_HEIGHT;
extern const NSInteger ITEM_NUMBER_WIDTH;
extern const NSInteger ITEM_NUMBER_HEIGHT;
extern const NSInteger ADJUST_NUMBER_POSI;

#pragma mark - --------- menu animation ----------

//menu animation
extern const CGFloat ANIME_SHOW_DURATION;
extern const CGFloat ANIME_SHOW_DELAY;
extern const NSInteger ANIME_OVERGOING_DISTANCE;
extern const CGFloat ANIME_BACKTO_POSITION_DURATION;
extern const NSInteger ANIME_MENU_ITEM_NUMBERS;

#pragma mark - --------- masu ----------
extern const NSInteger masuBeforeOne;
extern const NSInteger masuBeforeThree;
extern const CGFloat MASU_dy_FOR_Twentyone;




/**
 *  global constant strings
 *
 */
#define Stringize(x) @#x
#undef  DEFINE_GLOBAL_STRING
#ifdef MY_OBJECT_DEFINE_GLOBALS
#define DEFINE_GLOBAL_STRING(name)  NSString *const name = @#name
#else
#define DEFINE_GLOBAL_STRING(name)  extern NSString *const name
#endif

 
#pragma mark - ---- sceen ----------------
DEFINE_GLOBAL_STRING(Start_sceen);
DEFINE_GLOBAL_STRING(Main_sceen);
DEFINE_GLOBAL_STRING(Help_sceen);
DEFINE_GLOBAL_STRING(Record_sceen);

#pragma mark - --------- save & load ----------
//save data
DEFINE_GLOBAL_STRING(DateDATA);
DEFINE_GLOBAL_STRING(RemainCardDATA);
DEFINE_GLOBAL_STRING(Mode);

#pragma mark - --------- card ----------

DEFINE_GLOBAL_STRING(RED_CARD);
DEFINE_GLOBAL_STRING(BLUE_CARD);
DEFINE_GLOBAL_STRING(GREEN_CARD);
DEFINE_GLOBAL_STRING(YELLOW_CARD);

#pragma mark - notification center
DEFINE_GLOBAL_STRING(CARD_TOUCH_START);
DEFINE_GLOBAL_STRING(CARD_TOUCH_END);
DEFINE_GLOBAL_STRING(BUTTON_SLIDE);

/**
 *  global constant etc
 *
 */

#ifndef KSGLOBAL_def
#define KSGLOBAL_def

//画面
#define SCREEN_BOUNDS       ([UIScreen mainScreen].bounds)
#define SCREEN_SIZE         (SCREEN_BOUNDS.size)
#define LAND_SCREEN_SIZE    (CGSizeMake(SCREEN_SIZE.height, SCREEN_SIZE.width))

// error log
#define LOG_METHOD_NAME         NSLog(@"method name is %@", NSStringFromSelector(_cmd));
#define LOG_ERROR_METHOD        NSLog(@"error at %@", NSStringFromSelector(_cmd));

#define RGBA(r, g, b, a) [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : (a)]
#define RGB(r, g, b)     [UIColor colorWithRed : r / 255.0 green : g / 255.0 blue : b / 255.0 alpha : 1]

// base color
#define COLOR_red               [UIColor colorWithRed:244 / 255.0 green:82 / 255.0 blue:137 / 255.0 alpha:1]
#define COLOR_yellow            [UIColor colorWithRed:255 / 255.0 green:211 / 255.0 blue:85 / 255.0 alpha:1]
#define COLOR_blue               [UIColor colorWithRed:100 / 255.0 green:106 / 255.0 blue:233 / 255.0 alpha:1]
#define COLOR_green            [UIColor colorWithRed:163 / 255.0 green:248 / 255.0 blue:83 / 255.0 alpha:1]

//accent
#define ACCENT_red               [UIColor colorWithRed:168 / 255.0 green:57 / 255.0 blue:94 / 255.0 alpha:1]
#define ACCENT_yellow            [UIColor colorWithRed:179 / 255.0 green:147 / 255.0 blue:59 / 255.0 alpha:1]
#define ACCENT_blue               [UIColor colorWithRed:67 / 255.0 green:71 / 255.0 blue:156 / 255.0 alpha:1]
#define ACCENT_green            [UIColor colorWithRed:112 / 255.0 green:171 / 255.0 blue:56 / 255.0 alpha:1]



#define COLOR_MENU_Charactors  [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1]
#define COLOR_MENU_BAR         (RGBA(224, 224, 224, 1.0))
#define COLOR_SELECTED         ([UIColor whiteColor])//([UIColor purpleColor])

// shadow offset
#define SHADOW_OFFSET          (CGSizeMake(5, 3))


// card selection offset
#define CARD_SELECTION_OFFSET 10

//custom font
//#define APPLI_FONT @"TimesNewRomanPSMT"
#define APPLI_FONT @"Cochin"



typedef NS_ENUM (NSInteger, BUTTON_TAG) {
    START_BUTTON_TAG = 0,
    RECORD_BUTTON_TAG,
    HELP_BUTTON_TAG,
    CANCEL_BUTTON_TAG,
    MODE_SEVEN_BUTTON_TAG,
    MODE_FORUTEEN_BUTTON_TAG,
    MODE_TWENTYONE_BUTTON_TAG,
    MAX_BUTTON_TAG
};

typedef NS_ENUM(NSInteger, GAME_MODE) {
    GAME_MODE_7 = 0,
    GAME_MODE_14,
    GAME_MODE_21,
    GAME_MODE_MAX
    
};

#endif


@interface KSGlobalConst : NSObject

@end
