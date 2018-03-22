//
//  Cell_kin.h
//  virusCrusader
//
//  Created by 清水 一征 on 11/06/23.
//  Copyright (c) 2011 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cell_medicine, GameCondition;

@interface Cell_kin : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * resist_C;
@property (nonatomic, retain) NSNumber * gv;
@property (nonatomic, retain) NSNumber * resist_P;
@property (nonatomic, retain) NSString * identifer;
@property (nonatomic, retain) NSNumber * resist_K;
@property (nonatomic, retain) NSString * kin_kind;
@property (nonatomic, retain) NSNumber * resist_L;
@property (nonatomic, retain) NSNumber * rv;
@property (nonatomic, retain) NSNumber * kin_number;
@property (nonatomic, retain) NSNumber * resist_S;
@property (nonatomic, retain) NSSet* kin_meds;
@property (nonatomic, retain) GameCondition * a_game;

@end
