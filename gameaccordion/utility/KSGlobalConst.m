//
//  KSGlobalConst.m
//  extendViewTest
//
//  Created by kazuyuki shimizu on 2014/01/18.
//  Copyright (c) 2014年 momiji-mac.com. All rights reserved.
//

#define MY_OBJECT_DEFINE_GLOBALS

#import "KSGlobalConst.h"

@implementation KSGlobalConst

#pragma mark - --------- GAME ----------
//play max cards
const NSInteger    MAX_7 = 7;
const NSInteger    MAX_14 = 14;
const NSInteger    MAX_21 = 21;

//const NSInteger    GAME_FIELD_TAG = 1001;

#pragma mark - -------- display layer ----------

// eyeCatch
const CGFloat      EYE_CATCH_width  = 50.0f;
const CGFloat      EYE_CATCH_height = 50.0f;

#pragma mark - --------- masu ----------
const NSInteger    masuBeforeOne         = 1;
const NSInteger    masuBeforeThree       = 3;
const CGFloat      MASU_dy_FOR_Twentyone = 0.3f;

#pragma mark - --------- card ----------

const NSInteger    CARD_NUMBER_MAX = 13;   //13; // card number 1 ~ 13
const NSInteger    CARD_COLOR_MAX  = 4;   //4; // card color is red, green, blue, yellow

//card marker animation
const CGFloat      ANIME_MARKER_ROTATE_SPEED = 0.1f;
const CGFloat      ANIME_MARKER_TORATE_DELAY = 0.0f;

// card's property
const NSInteger    CARD_WIDTH            = 50;
const NSInteger    CARD_HEIGHT           = 50;
const NSInteger    CARD_TAG_SECOND_DIGIT = 10;

// card animation
const CGFloat      ANIME_FILL_CARD_DURATION   = 0.1f;
const CGFloat      ANIME_FILL_CARD_DELAY      = 0.0f;
const CGFloat      ANIME_REMOVE_CARD_DURATION = 0.1f;
const CGFloat      ANIME_REMOVE_CARD_DELAY    = 0.0f;
const CGFloat      ANIME_HIDDEN_CARD_DURATION = 0.3f;
const CGFloat      ANIME_HIDDEN_CARD_DELAY    = 0.1f;

#pragma mark - --------- button ----------
// button
const CGFloat      BUTTON_HEIGHT       = 50.0f;
const CGFloat      BUTTON_WIDTH        = 150.0f;
const NSInteger    BUTTONS_TOP_POSI    = 240;
const NSInteger    BUTTONS_SPACE       = 20;
const CGFloat      BUTTON_CORNER_ROUND = 5.0f;
const CGFloat      ADJUST_BUTTON_HIGHT = 10.0f; // Score Viewのボタン（restart & score）のための補正項

const NSInteger    MENU_BASE_POSI_X = 10;
const NSInteger    MENU_BASE_POSI_Y = 2;
const NSInteger    MENU_WIDTH       = 146;
const NSInteger    MENU_HEIGHT      = 40;
const NSInteger    MENU_LINE_BASE   = 9;
const NSInteger    ADJUST_POSI_X    = 4;
const NSInteger    ITEM_BASE_LINE   = 15;

const NSInteger    ITEM_BASE_X         = 10;
const NSInteger    ITEM_SUBJECT_WIDTH  = 40;
const NSInteger    ITEM_SUBJECT_HEIGHT = 20;
const NSInteger    ITEM_NUMBER_WIDTH   = 80;
const NSInteger    ITEM_NUMBER_HEIGHT  = 20;
const NSInteger    ADJUST_NUMBER_POSI  = 15;

//menu animation
const CGFloat      ANIME_SHOW_DURATION            = 0.3f;
const CGFloat      ANIME_SHOW_DELAY               = 0.05f;
const NSInteger    ANIME_OVERGOING_DISTANCE       = 10;
const CGFloat      ANIME_BACKTO_POSITION_DURATION = 0.2f;
const NSInteger    ANIME_MENU_ITEM_NUMBERS        = 1;

@end
