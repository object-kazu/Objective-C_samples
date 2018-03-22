//
//  GameCondition.m
//  virusCrusader
//
//  Created by 清水 一征 on 11/06/23.
//  Copyright (c) 2011 momiji-mac.com. All rights reserved.
//

#import "GameCondition.h"
#import "Cell_kin.h"


@implementation GameCondition
@dynamic playtime;
@dynamic researcher;
@dynamic date;
@dynamic cost;
@dynamic identifer;
@dynamic Games;
@dynamic GameCounter;

- (void)addGamesObject:(Cell_kin *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Games" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Games"] addObject:value];
    [self didChangeValueForKey:@"Games" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeGamesObject:(Cell_kin *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Games" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Games"] removeObject:value];
    [self didChangeValueForKey:@"Games" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addGames:(NSSet *)value {    
    [self willChangeValueForKey:@"Games" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Games"] unionSet:value];
    [self didChangeValueForKey:@"Games" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeGames:(NSSet *)value {
    [self willChangeValueForKey:@"Games" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Games"] minusSet:value];
    [self didChangeValueForKey:@"Games" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
