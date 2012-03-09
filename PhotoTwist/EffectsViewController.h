//
//  EffectsViewController.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/18/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EffectsViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray * frameImagesArray;
}
@property (nonatomic,retain) NSArray * frameImagesArray;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewEffectsVC;
- (IBAction)btnNegateImage:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnGrayImage;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnNegative;
- (IBAction)postToFB:(id)sender;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBarTop;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBarBottom;
- (IBAction)btnFramesClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorFacebookPostProgress;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnPostToFB;

@property (strong, nonatomic) IBOutlet UITableView *tableViewEffects;
- (IBAction)btnGrayImage:(id)sender;
@end
