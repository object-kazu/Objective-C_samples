//
//  def.h
//  SpeedRPG
//
//  Created by 清水 一征 on 11/09/21.
//  Copyright 2011 momiji-mac.com. All rights reserved.
//
//These constant show game state
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
