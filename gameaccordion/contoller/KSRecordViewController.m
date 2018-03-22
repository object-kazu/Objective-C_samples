//
//  KSRecordViewController.m
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/29.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSRecordViewController.h"
#import "KSGlobalConst.h"
#import "KSPageView.h"

@interface KSRecordViewController ()

@property (nonatomic, retain) UIView     *page7;
@property (nonatomic, retain) UIView     *page14;
@property (nonatomic, retain) UIView     *page21;
@property (nonatomic, retain) NSArray    *pageArray;
@property (nonatomic) NSInteger          pageIndex;
@property (nonatomic) NSInteger          pageBackIndex;


@end

@implementation KSRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.page7 = [KSPageView new];
    self.page14 = [KSPageView new];
    self.page21 = [KSPageView new];
    self.pageArray = @[self.page7,self.page14,self.page21];
    
    NSArray    *backColorArray = @[COLOR_red, COLOR_blue, COLOR_green];
    NSArray    *titleArray     = @[@"7", @"14", @"21"];
    NSInteger pageNumber = [self.pageArray count];
    NSAssert(pageNumber == [backColorArray count], @"page number should be equal to color number");
    NSAssert(pageNumber == [titleArray count], @"page number should be equal to title number");
    
    for (int i = 0 ; i < [self.pageArray count]; i++) {
        KSPageView* page = [self.pageArray objectAtIndex:i];
        page.delegate         = self;
        page.needReturnButton = YES;
        page.backColor        = [backColorArray objectAtIndex:i];
        page.titile           = [titleArray objectAtIndex:i];
        [page makePage];
        [page addScoreOfMode:i];
        [self.view addSubview:page];
        [self.view sendSubviewToBack:page];
        
    }

    [self prepPages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back {
    if ( ![self isBeingDismissed] ) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }

}

#pragma mark -  ----------  page  ----------
- (void)prepPages {
    
    self.pageIndex     = [self.pageArray count];
    self.pageBackIndex = [self.pageArray count];

}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    if ( self.pageIndex > [self.pageArray count] - 1 ) {
        self.pageIndex = 0;
    }

    self.pageBackIndex = self.pageIndex + 1;

    if ( self.pageBackIndex > [self.pageArray count] - 1 ) {
        self.pageBackIndex = 0;
    }

    //    NSLog(@"%d > %d",self.pageIndex, self.pageBackIndex);

    UIView    *frontView = (UIView *)[self.pageArray objectAtIndex:self.pageIndex];
    UIView    *backView  = (UIView *)[self.pageArray objectAtIndex:self.pageBackIndex];

    [UIView transitionFromView:frontView
                        toView:backView
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlUp
                    completion:^(BOOL finished) {
        self.pageIndex++;
    }];
}

- (void)callback:(KSPageView *)page {
    [self back];
}

@end
