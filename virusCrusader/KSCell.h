//
//  KSCell.h
//  virusCrusader
//
//  Created by 清水 一征 on 11/06/23.
//  Copyright 2011 momiji-mac.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KSCell : UITableViewCell {

    UILabel *number;
    UILabel *gvValue;
    UILabel *rvValue;
    UIImageView *level1;
    UIImageView *level2;
    UIImageView *level3;
    UIImageView *level4;
    UIImageView *level5;
    UILabel *resSValue;
    UILabel *resPValue;
    UILabel *resKValue;
    UILabel *resCValue;
    UILabel *resLValue;
    UIImageView *cellSelectView;
    UIImageView *cellColor;
    UIImageView *KinCondition;
    UIImageView *CellCondition;
}
@property (nonatomic, retain) IBOutlet UIImageView *KinCondition;
@property (nonatomic, retain) IBOutlet UIImageView *CellCondition;
@property (nonatomic, retain) IBOutlet UILabel *number;
@property (nonatomic, retain) IBOutlet UILabel *gvValue;
@property (nonatomic, retain) IBOutlet UILabel *rvValue;
@property (nonatomic, retain) IBOutlet UIImageView *level1;
@property (nonatomic, retain) IBOutlet UIImageView *level2;
@property (nonatomic, retain) IBOutlet UIImageView *level3;
@property (nonatomic, retain) IBOutlet UIImageView *level4;
@property (nonatomic, retain) IBOutlet UIImageView *level5;
@property (nonatomic, retain) IBOutlet UILabel *resSValue;
@property (nonatomic, retain) IBOutlet UILabel *resPValue;
@property (nonatomic, retain) IBOutlet UILabel *resKValue;
@property (nonatomic, retain) IBOutlet UILabel *resCValue;
@property (nonatomic, retain) IBOutlet UILabel *resLValue;
@property (nonatomic, retain) IBOutlet UIImageView *cellSelectView;
@property (nonatomic, retain) IBOutlet UIImageView *cellColor;

@end
