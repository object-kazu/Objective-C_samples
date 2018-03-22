//
//  KSDataFormatterTest.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/08/19.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSDataFormatterTest.h"

@implementation KSDataFormatterTest

- (void)setUp
{
    [super setUp];

    self.dataFormatter = [KSDataFormatter new];
    
}

- (void)tearDown
{
    // Tear-down code here.
    self.dataFormatter = nil;
    
    [super tearDown];
}

-(void)test_scoreFormatted{
    NSInteger integ = 1234567890;
    NSString* target = [self.dataFormatter scoreFormatted:integ];
    STAssertEqualObjects(@"1,234,567,890", target, nil);
    
    integ = 989;
    target = [self.dataFormatter scoreFormatted:integ];
    STAssertEqualObjects(@"989", target, nil);
}



@end
