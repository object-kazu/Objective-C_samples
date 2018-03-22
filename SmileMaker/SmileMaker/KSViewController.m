//
//  KSViewController.m
//  smileMaker
//
//  Created by 清水 一征 on 13/05/07.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSViewController.h"
#import "def.h"

#define IMG_SIZE 320

@interface KSViewController ()

- (void)save;
- (void)callPhotoLib;

@end

@implementation KSViewController

#pragma mark -
#pragma mark ---------- Life cycle ----------
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //    CGRect    screen = [UIScreen mainScreen].bounds;
    
    _faceimage.backgroundColor        = [UIColor blueColor];
    _faceimage.userInteractionEnabled = YES;
    
    _txtView                 = [[UITextView alloc] initWithFrame:CGRectMake(0, IMG_SIZE + TOOLBAR_HEIGHT, IMG_SIZE, 100)];
    _txtView.delegate        = self;
    _txtView.text            = @"test view";
    _txtView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_txtView];
    
    [_editedMemo setTarget:self];
    [_editedMemo setAction:@selector(textViewShouldEndEditing:)];
    
    //swip
    UISwipeGestureRecognizer    *swipeGesture =    [[UISwipeGestureRecognizer alloc]
                                                    initWithTarget:self action:@selector(didSwipeImg:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [_faceimage addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
    swipeGesture =    [[UISwipeGestureRecognizer alloc]
                       initWithTarget:self action:@selector(didSwipeImg:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [_faceimage addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidUnload {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ( [self.view window] == nil ) {
        
        _today      = nil;
        _faceimage  = nil;
        _txtView    = nil;
        _editedMemo = nil;
        _done       = nil;
        
    }
}

#pragma mark -
#pragma mark ---------- load and save ----------

- (void)save {
    Face    *face = [[Face alloc]init];
    face.date       = [NSDate date];
    face.memo       = _txtView.text;
    face.smileImage = UIImagePNGRepresentation(_faceimage.image);
    
    [[KSFaceDataManager sharedManager] save];
    
}

#pragma mark -
#pragma mark ---------- swip ----------
#pragma mark -
#pragma mark ---------- swipe delegate----------

- (void)didSwipeImg:(UISwipeGestureRecognizer *)swipe {
    
    if ( swipe.direction == UISwipeGestureRecognizerDirectionRight ) {
        
        [self takePict];
    }
    
    if ( swipe.direction == UISwipeGestureRecognizerDirectionLeft ) {
        [self callPhotoLib];
    }
    
}

#pragma mark -
#pragma mark ---------- touch ----------

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//
//
//    UITouch              *touch = [[event allTouches] anyObject];
//
//
//      _imageOrder = [face touchPosition:touch.view.tag];
//
//    _endPoint = [[touches anyObject] locationInView:self.view];
//
//    KSFaceMarkManager    *face = [[KSFaceMarkManager alloc] init];
//
//    ACTION               act = ACT_MAX;
//    // action select
//    act = [face action:_startPoint end:_endPoint];
//
//    // NSLog(@"imageOrder:%d",_imageOrder);
//    if ( _imageOrder == Order_morning || _imageOrder == Order_lunch || _imageOrder == Order_dinner ) {
//
//        // act
//        switch ( act ) {
//            case ACT_LIB:
//                NSLog(@"act lib");
//                _actionIndicator.hidden = NO;
//                _actionIndicator.text   = @"Library";
//                [self popupView:_actionIndicator src:LIB];
//
//                //[self photoLib:LIB];
//                break;
//            case ACT_PHOT:
//                NSLog(@"act photo");
//                _actionIndicator.hidden = NO;
//                _actionIndicator.text   = @"Camera";
//                [self popupView:_actionIndicator src:CAMERA];
//
//                //[self photoLib:CAMERA];
//                break;
//            case ACT_TAP:
//                NSLog(@"act tap");
//                [self toggleItem:_imageOrder];
//                break;
//
//            default:
//                NSLog(@"Check the action at touchesEnded!");
//                break;
//        }
//    }
//    face = nil;
//
//}

#pragma mark -
#pragma mark ---------- Photo ----------
- (void)takePict {
    UIImagePickerController    *imagePickerController = [[UIImagePickerController alloc]init];
    
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePickerController setDelegate:self];
        if ( [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront] ) {
            [imagePickerController setCameraDevice:UIImagePickerControllerCameraDeviceFront];
        }
        
        [imagePickerController setAllowsEditing:YES];
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    } else {
        NSLog(@"camera invalid.");
    }
    
}

- (void)callPhotoLib {
    UIImagePickerController    *imagePickerController = [[UIImagePickerController alloc]init];
    
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ) {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePickerController setDelegate:self];
        [imagePickerController setAllowsEditing:YES];
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    } else {
        NSLog(@"photo lib invalid.");
    }
    
}

//フォトライブラリー選択後に呼ばれるデリゲート
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // オリジナル画像
    UIImage    *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    // 編集画像
    UIImage    *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    UIImage    *saveImage;
    
    if ( editedImage ) {
        saveImage = editedImage;
    } else {
        saveImage = originalImage;
    }
    
    // UIImageViewに画像を設定
    _faceimage.image = saveImage;
    
    if ( picker.sourceType == UIImagePickerControllerSourceTypeCamera ) {
        // カメラから呼ばれた場合は画像をフォトライブラリに保存してViewControllerを閉じる
        UIImageWriteToSavedPhotosAlbum(saveImage, nil, nil, nil);
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if ( picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary ) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        LOG_ERROR;
    }
    //[self save];
}

#pragma mark -
#pragma mark ---------- textView delegete method ----------
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    //text viewを上に移動
    CGRect    textViewRect = _txtView.frame;
    textViewRect.origin.y = TOOLBAR_HEIGHT;
    
    [UIView animateWithDuration:0.5f animations:^{
        _txtView.frame = textViewRect;
        
    }];
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    [_txtView resignFirstResponder];
    
    CGRect    textViewRect = _txtView.frame;
    textViewRect.origin.y = IMG_SIZE + TOOLBAR_HEIGHT;
    
    [UIView animateWithDuration:0.5f animations:^{
        _txtView.frame = textViewRect;
        
    }];
    
    return YES;
}

@end
