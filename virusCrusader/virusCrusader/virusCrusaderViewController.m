//
//  virusCrusaderViewController.m
//  virusCrusader
//
//  Created by 清水 一征 on 11/05/22.
//  Copyright 2011 momiji-mac.com. All rights reserved.
//

#import "virusCrusaderViewController.h"
#import "def.h"

//Custom cell of table
#import "KSCell.h"
#define CUSTOM_CELL_NIB @"KSCell"

@implementation virusCrusaderViewController

//view = 10
@synthesize startView,medicinView, gameMainView,helpView, resultsView, recordView, endingView;




//view state contorl
enum viewState{start, gameMain, help, medicine, results, record, ending};


- (id) init{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    
    //timer
    livetimer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(step:) userInfo:nil repeats:YES];
    
    //これではいつでもinitial costで始まる！
    cost = 1000; // initial cost
    
    
    
    return self;
}

-(void) viewStates:(Boolean)start_onoff 
          gameMain:(Boolean)gamemain_onoff
              help:(Boolean)help_onoff
          medicine:(Boolean)medicin_onoff
           results:(Boolean)results_onoff
            record:(Boolean)record_onoff
            ending:(Boolean)ending_onoff;
{
    
    //view show
    startView.hidden = start_onoff;
    gameMainView.hidden = gamemain_onoff;
    helpView.hidden = help_onoff;
    medicinView.hidden = medicin_onoff;
    resultsView.hidden = results_onoff;
    recordView.hidden = record_onoff;
    endingView.hidden = ending_onoff;
    
    
    
}

    

//button label setting and view changeing
- (void)viewChangeContorl:(NSInteger)viewstate{
    
    switch (viewstate) {
        case start :
            [self viewStates:YES gameMain:NO help:NO medicine:NO results:NO record:NO ending:NO];
            buttonLeft_label.text = @"Lets start";
            buttonCenter_label.text = @"Setting";
            buttonRight_label.text = @"Record";
            break;
            
        case gameMain:
            buttonLeft_label.text = @"Lets start";
            buttonCenter_label.text = @"Setting";
            buttonRight_label.text = @"Record";
            break;
        
        case help:
            buttonLeft_label.text = @"Lets start";
            buttonCenter_label.text = @"Setting";
            buttonRight_label.text = @"Record";
            break;
        
    
        case medicine:
            buttonLeft_label.text = @"Lets start";
            buttonCenter_label.text = @"Setting";
            buttonRight_label.text = @"Record";
            break;
        
        case results:
            buttonLeft_label.text = @"Lets start";
            buttonCenter_label.text = @"Setting";
            buttonRight_label.text = @"Record";
            break;
            
        case record:
            buttonLeft_label.text = @"Lets start";
            buttonCenter_label.text = @"Setting";
            buttonRight_label.text = @"Record";
            break;
        
        case ending:
            buttonLeft_label.text = @"Lets start";
            buttonCenter_label.text = @"Setting";
            buttonRight_label.text = @"Record";
            break;
    }
    
}

//if user press button under the app, this method is called.
//And this method will call viewChangeControl
//So, Briefingly, Press button > pressResponder > viewChangeContol > viewState:
- (void)pressResponder:(NSInteger)buttion_position{
    switch (viewState_) {
        case start:
            if (buttion_position == BUTTON_Left) {
                [self viewChangeContorl:start];
                NSLog(@"left");
            }else if (buttion_position == BUTTON_Center){
                NSLog(@"center");
            }else if (buttion_position == BUTTON_Right){
                NSLog(@"right");
            }
            
            break;
        
        case gameMain:
            break;
        case help:
            break;
        case medicine:
            break;
        case results:
            break;
        case record:
            break;
        case ending:
            break;
    }
}

- (IBAction) pressLeft{
    [self pressResponder:BUTTON_Left];
}

- (IBAction) pressCenter{
    [self pressResponder:BUTTON_Center];
    }

- (IBAction) pressRight{
    [self pressResponder:BUTTON_Right];
}


#pragma mark - Methods of release and nils

- (void)viewDidUnload
{
    [Left_button release];    Left_button = nil;
    [Center_button release];    Center_button = nil;
    [Right_button release];    Right_button = nil;
    
    [buttonCenter_label release]; buttonCenter_label = nil;
    [buttonLeft_label release]; buttonLeft_label = nil;
    [buttonRight_label release]; buttonRight_label =nil;
    
    [KSTable release];
    KSTable = nil;
    [endingImage release];
    endingImage = nil;
    [label_timer release];
    label_timer = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
#pragma new test code, new will has problem!
    // My New code, if problem has occured, this is check as fast as possible!
    
    self.startView = nil;
    self.endingView = nil;
    self.recordView = nil;
    self.helpView = nil;
    self.medicinView = nil;
    self.gameMainView = nil;
    self.resultsView = nil;
    
    [livetimer invalidate]; livetimer = nil;
    
}


- (void)dealloc
{
    
    [startView release];
    [endingView release];
    [recordView release];
    [helpView release];
    [medicinView release];
    [gameMainView release];
    [resultsView release];
    
    [buttonLeft_label release];
    [buttonRight_label release];
    [buttonCenter_label release];
    
    [Left_button release];
    [Center_button release];
    [Right_button release];
    [KSTable release];

    [livetimer invalidate]; livetimer = nil;

    
    [endingImage release];
    [label_timer release];
    [super dealloc];
}


#pragma mark - View lifecycle


#pragma mark - NSTimer
-(void) timerStop{
    [livetimer invalidate];
    livetimer = nil;
}

//timer からの呼び出し（１）
-(void) step:(NSTimer*)timer{
   //tableの更新
           reroad_counter +=1;
        if ((reroad_counter >10) ){
            //[KSTable reloadData];
            for (UITableViewCell* cell in [KSTable visibleCells]) {
                [self tableContent:cell atIndexPath:[KSTable indexPathForCell:cell]];
            }
            reroad_counter = 0;
        }
        
    
    
   //timer 表示更新
    timer_interval_counter += 1;
    
    // hhh/mm/ss/ms
    float temp_time;
    int hhh;
    int mm;
    int ss;
    
    temp_time =timer_interval_counter*TIMER_INTERVAL;
    
    if (temp_time >= TIMER_HOUR) {
        hhh = temp_time / TIMER_HOUR;
        mm = hhh / TIMER_MIN;
        ss = hhh % TIMER_MIN;
        
    }else if (temp_time<TIMER_HOUR && temp_time >= TIMER_MIN ){
        hhh = 0;
        mm = temp_time / TIMER_MIN;
        ss = (int)(temp_time - (mm*TIMER_MIN));
    }else{
        hhh = 0;
        mm = 0;
        ss = (int)temp_time;
    }
    
    label_timer.text = [NSString stringWithFormat:@"%2d:%2d:%2d",hhh,mm,ss];
    
    //Game ending treatment
    /*
     ending condition
     1.kin = 0 -> clear
     
     1.cost = 0
     2.kin res = 99 * 5
     
     */
    
    if (cost == 0) { // one of conditions 
        [self GameEnd:YES];
    }else{
        [self GameEnd:NO];
    }
    
    
    
}

#pragma mark --Game Ending --
-(void)GameEnd:(BOOL)ending{
    
    UIImage *endingImage_src;

    if (ending == YES) {    //Good Ending = YES
        
        endingImage_src = [UIImage imageNamed:@"ClearEnding.png"];
        [endingImage setImage:endingImage_src];
        
    }else if (ending == NO){    //Bad Ending = NO
        endingImage_src = [UIImage imageNamed:@"BadEnding.png"];
        [endingImage setImage:endingImage_src];
    }else{
        NSLog(@"Error at ending image");
    }
    
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    viewState_ = start;
    [self viewChangeContorl:viewState_];

    //For Custom cell

    UINib *nib = [UINib nibWithNibName:CUSTOM_CELL_NIB bundle:nil];
    NSArray *array = [nib instantiateWithOwner:nil options:nil];
    KSCell *cell = [array objectAtIndex:0];
    cellHight_ = cell.frame.size.height;
    cellHight_ = 47;
    

    //timer
    livetimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(step:) userInfo:nil repeats:YES];
    timer_interval_counter = 1;
    
    //これではいつでもinitial costで始まる！
    cost = 1000; // initial cost
    
    
    //TEST Code
    
    highlight = YES;
    

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table setting

// Custom cell and table
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KSCell *cell = (KSCell*)[tableView dequeueReusableCellWithIdentifier:CUSTOM_CELL_NIB];
    if (cell == nil){
        UINib *nib = [UINib nibWithNibName:CUSTOM_CELL_NIB bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    //cell configuration
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self tableContent:cell atIndexPath:indexPath];
    
    
    
    
    return cell;
}


//Cell content更新処理
-(void) tableContent:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
   
    KSCell *kscell;
    kscell = (KSCell*)cell;
    
    int r = rand()%10;
    
    kscell.number.text = [NSString stringWithFormat:@"%d",r];
    
    if (indexPath.row == 0) {
        kscell.number.text = [NSString stringWithFormat:@"koko"];
    }
    
    //TEST
    //NSIndexPath* ksIndex = [NSIndexPath indexPathForRow:1 inSection:0];
   // kscell = [KSTable cellForRowAtIndexPath:ksIndex];
   // kscell.number.text = @"good";
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHight_;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete)
 {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert)
 {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */
- (void)tableView:(UITableView *)tableView  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    KSCell *kscell;
    kscell = (KSCell*)cell;

    kscell.backgroundColor = [UIColor clearColor];
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KSCell *KSSelection;
    UITableViewCell *selection = [tableView cellForRowAtIndexPath:indexPath];
    KSSelection = (KSCell*)selection;
    
    if (highlight==YES) {
        //_}[tableView deselectRowAtIndexPath:indexPath animated:YES];

        KSSelection.cellSelectView.backgroundColor = [UIColor yellowColor];
        highlight = NO;
        
    }else{
        KSSelection.cellSelectView.backgroundColor = [UIColor clearColor];
        highlight = YES;
        
    }

    
    

    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //TEST CODE
    NSInteger select;
    select = indexPath.row;
    
    
    /*
      *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}




@end