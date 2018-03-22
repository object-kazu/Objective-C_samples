//
//  luckyToday
//
//  Created by 清水 一征 on 12/09/03.
//  Copyright momiji-mac.com 2012年. All rights reserved.
//


#import "StartScene.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@implementation StartScene


+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
    StartScene *layer = [StartScene node];
	
    [scene addChild: layer];
	
    return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
		CGPoint home = ccp(size.width /2, size.height/2);

        //background
        CCSprite *backGround = [CCSprite spriteWithFile:@"back.png"];
        backGround.position = home;
        [self addChild:backGround];
        
        
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Fortune Ticket" fontName:MF fontSize:48];
		label.position =  ccp(size.width /2, size.height/2 + 30);
        [self addChild: label];
				
        //SE
        _SEffect = @"ticket.caf";
        [[SimpleAudioEngine sharedEngine] preloadEffect:_SEffect];

        //data control
        [self startController];
        
	}
	return self;
}

-(void) startController{
    CGSize size = [[CCDirector sharedDirector] winSize];
    _dateContorol = [[DataController alloc]init];
    
    //today?
    NSDate *today = [NSDate date];
    NSString *playDate = [_dateContorol formattingDate:today];
    
    //last play date
    NSDate *lastPlayDate = [_dateContorol load_data];
    NSString *lastDate = [_dateContorol formattingDate:lastPlayDate];
    bool isSameDays = [_dateContorol isStartGame:playDate lastDate:lastDate];
    
    if (! _dateContorol.isDateExist) isSameDays = NO;
    
    // if remove following code, this app will launch once at day.
    isSameDays = NO;
    
    
    [_dateContorol save_data];
    
    
    if ( ! isSameDays) {
  
        //start button appear
		_startLabel = [CCLabelTTF labelWithString:@"START" fontName:MF fontSize:28];
        _startLabel.anchorPoint = CGPointMake(0.5, 0.5);
        
        
        CCMenuItemLabel *start = [CCMenuItemLabel itemWithLabel:_startLabel target:self selector:@selector(gameStart)];

        CCMenu *menu = [CCMenu menuWithItems:start, nil];
        
        [menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 - 100)];
        // Add the menu to the layer
		[self addChild:menu];
        
    }else{
        //massage display
        CCLabelTTF *massage = [CCLabelTTF labelWithString:@"！Play is once-daily" fontName:MF fontSize:24];
        massage.position = ccp(size.width/2, size.height/2 - 50);
        [self addChild:massage];
        
    }
}

-(void) gameStart{
    
    [[SimpleAudioEngine sharedEngine] playEffect:_SEffect];
        
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.4 scene:[ChallengeScene scene]]];
    
}

- (void) dealloc
{
    [_dateContorol release]; _dateContorol = nil;
	[super dealloc];
}


@end
