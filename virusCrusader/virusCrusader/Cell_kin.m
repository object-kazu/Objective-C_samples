//
//  Cell_kin.m
//  virusCrusader
//
//  Created by 清水 一征 on 11/06/23.
//  Copyright (c) 2011 momiji-mac.com. All rights reserved.
//

#import "Cell_kin.h"
#import "Cell_medicine.h"
#import "GameCondition.h"


@implementation Cell_kin
@dynamic resist_C;
@dynamic gv;
@dynamic resist_P;
@dynamic identifer;
@dynamic resist_K;
@dynamic kin_kind;
@dynamic resist_L;
@dynamic rv;
@dynamic kin_number;
@dynamic resist_S;
@dynamic kin_meds;
@dynamic a_game;

- (void)addKin_medsObject:(Cell_medicine *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"kin_meds" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"kin_meds"] addObject:value];
    [self didChangeValueForKey:@"kin_meds" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeKin_medsObject:(Cell_medicine *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"kin_meds" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"kin_meds"] removeObject:value];
    [self didChangeValueForKey:@"kin_meds" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addKin_meds:(NSSet *)value {    
    [self willChangeValueForKey:@"kin_meds" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"kin_meds"] unionSet:value];
    [self didChangeValueForKey:@"kin_meds" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeKin_meds:(NSSet *)value {
    [self willChangeValueForKey:@"kin_meds" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"kin_meds"] minusSet:value];
    [self didChangeValueForKey:@"kin_meds" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}



@end
