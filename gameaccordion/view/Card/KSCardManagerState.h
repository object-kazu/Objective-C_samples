//
//  KSCardState.h
//  GameAccordion
//
//  Created by kazuyuki shimizu on 2014/02/14.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSGlobalConst.h"

@interface KSCardManagerState : NSObject

+(KSCardManagerState*) sharedMode;

-(CGSize)calcSize:(CGFloat)width;

//test
-(void) showMode;
-(NSInteger)displayMode;

@end
