//
//  KSCollectionViewController.m
//  smileMaker
//
//  Created by 清水 一征 on 13/02/27.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSCollectionViewController.h"

@interface KSCollectionViewController ()

@end

@implementation KSCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back {
    
    if ( ![self isBeingDismissed] ) {
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end
