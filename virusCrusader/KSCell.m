//
//  KSCell.m
//  virusCrusader
//
//  Created by 清水 一征 on 11/06/23.
//  Copyright 2011 momiji-mac.com. All rights reserved.
//

#import "KSCell.h"


@implementation KSCell
@synthesize KinCondition;
@synthesize CellCondition;
@synthesize number;
@synthesize gvValue;
@synthesize rvValue;
@synthesize level1;
@synthesize level2;
@synthesize level3;
@synthesize level4;
@synthesize level5;
@synthesize resSValue;
@synthesize resPValue;
@synthesize resKValue;
@synthesize resCValue;
@synthesize resLValue;
@synthesize cellSelectView;
@synthesize cellColor;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    cellSelectView.backgroundColor = [UIColor clearColor];
    
}

- (void)dealloc
{
    
    [number release]; number = nil;
    [gvValue release]; gvValue = nil;
    [rvValue release]; rvValue = nil;
    [KinCondition release]; KinCondition = nil;
    [CellCondition release]; CellCondition = nil;
    [level1 release]; level1 = nil;
    [level2 release]; level2 = nil;
    [level3 release]; level3 = nil;
    [level4 release]; level4 = nil;
    [level5 release]; level5 = nil;
    [resSValue release]; resSValue = nil;
    [resPValue release]; resPValue = nil;
    [resKValue release]; resKValue = nil;
    [resCValue release]; resCValue = nil;
    [resLValue release]; resLValue = nil;
    [cellSelectView release]; cellSelectView = nil;
    [cellColor release]; cellColor = nil;
    [super dealloc];
}

@end
