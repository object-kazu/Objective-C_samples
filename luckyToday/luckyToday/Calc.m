//
//  Calc.m
//  luckyToday
//
//  Created by 清水 一征 on 12/09/20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Calc.h"

//const NSString *Operators = @"+-x/";

@implementation Calc

-(id)init{
    if( (self=[super init])) {
    }
	return self;

}
-(Boolean)result:(NSMutableArray*)array operators:(NSMutableArray*)operators{
    Boolean result_ = FALSE;
    
    NSInteger o[3];
    if ([operators count] == 4) {
        for (int j = 0; j<4; j++) {
            o[j] = [[operators objectAtIndex:j] integerValue];
        }
    }
    
    //array check
    NSInteger v[4];
    if ([array count] == 5) {
        for (int i = 0; i<5; i++) {
            v[i] = [[array objectAtIndex:i] integerValue];
        }
        
    }else{
        NSAssert([array count] == 5, @"array is not correct");
    }
    
    CCLOG(@"%d,%d,%d,%d,%d",v[0],v[1],v[2],v[3],v[4]);
    
    //calc start
    
    NSInteger temp_result = [self calcurate:v[0] second:v[1] ope:o[0]];
    temp_result = [self calcurate:temp_result second:v[2] ope:o[1]];
    temp_result = [self calcurate:temp_result second:v[3] ope:o[2]];
    temp_result = [self calcurate:temp_result second:v[4] ope:o[3]];
    
    
    //judge
    if (temp_result == TARGET) {
        result_ = TRUE;
    }else{
        result_ = FALSE;
    }
    
    return result_;
}

-(NSInteger)calcurate:(NSInteger)first second:(NSInteger)second ope:(NSInteger)ope{
    NSInteger temp;
    switch (ope) {
        case 0:
            temp = first + second;
            break;
        case 1:
            temp = first - second;
            break;
        case 2:
            temp = first * second;
            break;
        case 3:
            if (second == 0) {
                temp = 0;
            }else{
                temp = first / second;
            }
            break;
            
        default:
            CCLOG(@"illigal operator is selected, check operators:%d",ope);
            temp = 10000;
            break;
            
    }
    CCLOG(@"result is %d",temp);
    return temp;
}

@end
