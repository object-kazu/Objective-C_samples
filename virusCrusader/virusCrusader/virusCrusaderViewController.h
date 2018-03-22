//
//  virusCrusaderViewController.h
//  virusCrusader
//
//  Created by 清水 一征 on 11/05/22.
//  Copyright 2011 momiji-mac.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface virusCrusaderViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
   
    //view
    NSInteger viewState_;
    IBOutlet UIView *startView, *helpView, *endingView, *resultsView, *medicinView, *gameMainView, *recordView;
    
    IBOutlet UILabel* buttonLeft_label, *buttonCenter_label, *buttonRight_label;
    IBOutlet UIButton *Left_button;
    IBOutlet UIButton *Center_button;
    IBOutlet UIButton *Right_button;
   
    IBOutlet UIImageView *endingImage;
    
    //custom cell
    CGFloat cellHight_;
    //Main Table with custom cells
    IBOutlet UITableView *KSTable;
    //highlight toggle
    BOOL highlight;
    
    //Game condition
    float cost;
    
    //timer
    NSTimer* livetimer;
    IBOutlet UILabel *label_timer;
    float timer_interval_counter;
    int reroad_counter;
    
    
    
    
   
}

@property (nonatomic,retain) IBOutlet UIView *startView;
@property (nonatomic,retain) IBOutlet UIView *helpView;
@property (nonatomic,retain) IBOutlet UIView *endingView;
@property (nonatomic,retain) IBOutlet UIView *resultsView;
@property (nonatomic,retain) IBOutlet UIView *medicinView;
@property (nonatomic,retain) IBOutlet UIView *gameMainView;
@property (nonatomic,retain) IBOutlet UIView *recordView;




-(IBAction)pressLeft;
-(IBAction)pressCenter;
-(IBAction)pressRight;

-(void) viewStates:(Boolean)start_onoff 
          gameMain:(Boolean)gamemain_onoff
            help:(Boolean)help_onoff
          medicine:(Boolean)medicin_onoff
           results:(Boolean)results_onoff
            record:(Boolean)record_onoff
            ending:(Boolean)ending_onoff;


-(void)viewChangeContorl:(NSInteger)viewstate;
- (void)pressResponder:(NSInteger)buttion_position;

//NStimer stop
-(void) timerStop;

-(void)GameEnd:(BOOL)ending;
-(void) tableContent:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath; // KSCell ??

@end
