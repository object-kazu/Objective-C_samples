//
//  KSCardContext.h
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/14.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSCardManagerState.h"
#import "KSCardManagerForSeven.h"
#import "KSCardManagerForFourteen.h"
#import "KSCardManagerForTwentyone.h"

@interface KSCardManagerContext : NSObject

@property (nonatomic,retain) KSCardManagerState* currentManagerState;
-(void) changeMode:(KSCardManagerState*)mode;
-(CGSize) calcSize:(CGFloat)width;

//sample code
-(void) say;
-(NSInteger)displayMode;

@end
