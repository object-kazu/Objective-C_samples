//
//  KSMenuAnimationHelper.m
//  GameAccordion
//
//  Created by 清水 一征 on 2014/01/30.
//  Copyright (c) 2014年 momiji-mac. All rights reserved.
//

#import "KSMenuAnimationHelper.h"
#import "KSGlobalConst.h"

@implementation KSMenuAnimationHelper

- (id)initWithViewsArray:(NSArray *)array {
    if ( self = [super init] ) {
        if ( [array count] != ANIME_MENU_ITEM_NUMBERS ) {
            NSLog(@"Error at initWithViewsArray");
            NSLog(@"init doese not work, should use initWithViewsArray!");
        } else {
            self.startButton      = array[0];
            self.showRecordButton = array[1];
            //            self.cardIndex         = 0;
            
        }
    }
    
    return self;
    
}

- (id)init {
    NSMutableArray    *arr = @[].mutableCopy;
    
    return [self initWithViewsArray:arr];
}

#pragma mark - menu animation
- (void)showMenu {
    [UIView animateWithDuration:ANIME_SHOW_DURATION
                          delay:ANIME_SHOW_DELAY
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self showEachMenu:self.startButton];
                         
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.6f
                                               delay:0.5
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              [self showEachMenu:self.showRecordButton];
                                          } completion:^(BOOL finished) {
                                              nil;
                                          }];
                         
                     }];
    
}

- (void)hideMenu:(id)sender {
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [self hideEachMenu:self.showRecordButton];
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.4f
                                          animations:^{
                                              [self hideEachMenu:self.startButton];
                                          } completion:^(BOOL finished) {
                                              
                                              //delegate
                                              switch ( [sender tag] ) {
                                                  case START_BUTTON_TAG:
                                                      if ( [self.delegate respondsToSelector:@selector(pushedStartButton:)] ) {
                                                          [self.delegate pushedStartButton:self];
                                                      }
                                                      break;
                                                  case RECORD_BUTTON_TAG:
                                                      if ( [self.delegate respondsToSelector:@selector(pushedShowResultsButton:)] ) {
                                                          [self.delegate pushedShowResultsButton:self];
                                                      }
                                                      
                                                      break;
                                                  default:
                                                      NSLog(@"error at hideMenu, may be sender tag around");
                                                      break;
                                              }
                                              
                                          }];
                     }];
    
}

- (void)showEachMenu:(UIView *)view {
    
    CGPoint    endPoint = view.center;
    
    [UIView animateWithDuration:ANIME_SHOW_DURATION
                          delay:ANIME_SHOW_DELAY
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         view.center = CGPointMake(view.center.x, LAND_SCREEN_SIZE.height + 10);
                         
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:ANIME_BACKTO_POSITION_DURATION
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              view.center = endPoint;
                                              
                                          } completion:^(BOOL finished) {
                                              
                                              nil;
                                              
                                          }];
                     }];
    
}

- (void)hideEachMenu:(UIView *)view {
    CGRect    rec = view.frame;
    rec = CGRectOffset(rec, LAND_SCREEN_SIZE.width, 0);
    
}

#pragma mark - mode button animation
-( void) changeModeFromHidden:(UIView *)hButton ToShow:(UIView *)sButton{
    CGRect oriPosi = sButton.frame;
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
         usingSpringWithDamping:0.0f
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         hButton.alpha = 0.0;
                         
                     } completion:^(BOOL finished) {
                         hButton.hidden = YES;
                         hButton.frame = oriPosi;

                         [UIView animateWithDuration:0.3f
                                               delay:0.1f
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              sButton.hidden = NO;
                                              sButton.frame = CGRectOffset(oriPosi, 0, 10);
                                              sButton.alpha = 0.1f;

                                          } completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.3f
                                                                    delay:0.1f
                                                                  options:UIViewAnimationOptionCurveEaseOut
                                                               animations:^{
                                                                   sButton.frame = oriPosi;
                                                                   sButton.alpha = 1.0f;
                                                                   
                                                               } completion:^(BOOL finished) {
                                                                   hButton.alpha = 1.0f;
                                                                  
                                                                   
                                                               }];
                                              
                                              
                                          }];
                     }];
    
    
}



@end
