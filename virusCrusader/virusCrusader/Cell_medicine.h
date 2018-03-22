//
//  Cell_medicine.h
//  virusCrusader
//
//  Created by 清水 一征 on 11/06/23.
//  Copyright (c) 2011 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cell_kin;

@interface Cell_medicine : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * kind;
@property (nonatomic, retain) NSNumber * conc;
@property (nonatomic, retain) NSString * identifer;
@property (nonatomic, retain) Cell_kin * med_kin;

@end
