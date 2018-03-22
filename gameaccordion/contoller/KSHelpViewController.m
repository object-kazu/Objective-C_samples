//
//  KSHelpViewController.m
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/29.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSHelpViewController.h"
#import "KSGlobalConst.h"
#import "KSPageView.h"

#define PAGE_ONE_CONTENT   @"Get all the cards in one pile, by building"
#define PAGE_TWO_CONTENT   @"Any card may be placed on top of the next card at its left, or the third card at its left, if the cards are of the same color or of the same number. "

@interface KSHelpViewController ()

@property (nonatomic, retain) UIView     *page1;
@property (nonatomic, retain) UIView     *page2;
@property (nonatomic, retain) UIView     *page3;
@property (nonatomic, retain) NSArray    *pageArray;
@property (nonatomic) NSInteger          pageIndex;
@property (nonatomic) NSInteger          pageBackIndex;

@end

@implementation KSHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.page1     = [KSPageView new];
    self.page2     = [KSPageView new];
    self.page3     = [KSPageView new];
    self.pageArray = @[self.page1, self.page2, self.page3];
    NSArray    *backColorArray = @[COLOR_red, COLOR_blue, COLOR_green];
    NSArray    *titleArray     = @[@"Goal", @"Building", @"Example"];
    NSArray    *contentArray   = @[PAGE_ONE_CONTENT, PAGE_TWO_CONTENT];
    UIImage    *img            = [UIImage imageNamed:@"sample"];

    for ( int i = 0; i < [self.pageArray count]; i++ ) {
        KSPageView    *page = [self.pageArray objectAtIndex:i];
        page.delegate         = self;
        page.needReturnButton = YES;
        page.backColor        = [backColorArray objectAtIndex:i];
        page.titile           = [titleArray objectAtIndex:i];
        page.titileFontSize   = 24;

        // page 3はimgを挿入するので別のメソッドを使用する
        if ( i == (int)[self.pageArray count] - 1 ) {
            [page addimage:img];
        } else {
            page.helpContents = [contentArray objectAtIndex:i];
        }

        [page makePage];
        [self.view addSubview:page];
        [self.view sendSubviewToBack:page];

    }

    self.pageIndex     = [self.pageArray count];
    self.pageBackIndex = [self.pageArray count];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)back {
    if ( ![self isBeingDismissed] ) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }

}

- (void)callback:(KSPageView *)page {
    [self back];
}

@end
