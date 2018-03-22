//
//  Defs.h
//  luckyToday
//
//  Created by 清水 一征 on 12/09/18.
//
//

#ifndef luckyToday_Defs_h
#define luckyToday_Defs_h

#define TARGET 10



#define POSITION_BASE_X 160
#define POSITION_BASE_BOTTOM 40
#define POSITION_BASE_TOP   440


#define INITIAL0 0
#define INITIAL1 1
#define _HALF_ 0.5
#define _REVERSE_ -1

#define EffectInterval 1.7

#define MF @"Marker Felt"



//Tags for the CCnode and sprite
typedef enum {
    ChallengeSceneTag=0,
    op1Tag,
    op2Tag,
    op3Tag,
    op4Tag,
    
    GameTagMax
} GameTag;

typedef enum {
    button_1,
    button_2,
    button_3,
    button_4
}buttonTag;


// For addChild of z
typedef enum{
    Z_Challenge = 0,
    Z_button,
    Z_label,
      
    Z_MAX
}Z_level;

//Particle effect
typedef enum{
    HitAtEnemy = 0,
    HitAtPlayer,
    HitAtBubble,
    ReuseBubble,
    EffectMax
} PARTICLE_EFFECT;

//Game state indication
typedef enum GAME_STATE{
	_GAME_START,            //!< Start view
	_GAME_PLAY,				//!< ゲームプレイ
	_GAME_PRE,				//!<ゲームカウントダウン
	_GAME_END,				//!<ゲームオーバー
	_GAME_RULES,			//!< ルール参照
	_GAME_RECORD,			//!<record 参照
	_GAME_RESULTS,			//!< 結果
    _GAME_SETTING,          //!< setting
    _GAME_CARDSELECT,           //!< card select
    
}GAME_STATE;


#endif