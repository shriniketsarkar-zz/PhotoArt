//
//  StandingCollageViewController.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/20/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandingCollageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageViewLastCollage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnResumeCollage;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnNewCollage;
@property (weak, nonatomic) IBOutlet UIToolbar *collageToolBar;
//- (IBAction)resumeExistingCollage:(id)sender;
//
//- (IBAction)loadNewCollage:(id)sender;
@end
