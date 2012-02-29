//
//  EffectsViewController.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/18/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EffectsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageViewEffectsVC;
- (IBAction)btnNegateImage:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnGrayImage;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnNegative;

- (IBAction)btnGrayImage:(id)sender;
@end
