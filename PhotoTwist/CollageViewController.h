//
//  CollageViewController.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/18/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CollageViewController : UIViewController
{
    bool isImageViewInMotionAlready;
    NSInteger *imageViewBeingDragged;
    CGPoint singleTapLocation;
}
@property (nonatomic, assign) bool isImageViewInMotionAlready;
@property (nonatomic, assign) NSInteger imageViewBeingDragged;
@property (nonatomic, assign) CGPoint singleTapLocation;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property (weak, nonatomic) IBOutlet UIImageView *imageView6;
@property (weak, nonatomic) IBOutlet UIImageView *imageView7;
@property (weak, nonatomic) IBOutlet UIImageView *imageView8;
@property (weak, nonatomic) IBOutlet UIImageView *imageView9;
@property (weak, nonatomic) IBOutlet UIImageView *imageView10;
@property (weak, nonatomic) IBOutlet UIImageView *imageView11;
@property (weak, nonatomic) IBOutlet UIImageView *imageView12;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCollageCapture;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCollageCancel;
@property (weak, nonatomic) IBOutlet UISlider *sliderVertical;


- (IBAction)captureScreenImage:(id)sender;

- (IBAction)dismissCollageView:(id)sender;


-(void)customizeCollageViewController;

- (IBAction)sliderValueChanged:(id)sender;


-(void)invokeImagePicker;
@end
