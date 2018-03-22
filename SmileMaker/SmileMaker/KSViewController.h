//
//  KSViewController.h
//  smileMaker
//
//  Created by 清水 一征 on 13/05/07.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Face.h"
#import "KSFaceDataManager.h"

@interface KSViewController :  UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel            *today;
@property (nonatomic, weak) IBOutlet UIImageView        *faceimage;
@property (nonatomic, weak) IBOutlet UIBarButtonItem    *editedMemo;
@property (nonatomic, weak) IBOutlet UIBarButtonItem    *done;

@property (nonatomic,retain) UITextView* txtView;

- (void)takePict;


@end
