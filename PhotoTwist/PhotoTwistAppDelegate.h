//
//  PhotoTwistAppDelegate.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/10/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
@class SettingsViewController;
@interface PhotoTwistAppDelegate : UIResponder <UIApplicationDelegate,FBSessionDelegate,FBRequestDelegate>
{
    Facebook *facebook;
    bool retainStateOfCollage;
    bool displayFBLoginUnavailableAlert;
    bool hasUserSelectedMultipleImages;
    NSArray *selectedImagesForCollage;
    NSArray *A;
    NSArray *B;
}
@property (nonatomic, retain) NSArray *selectedImagesForCollage;
@property (nonatomic,retain) Facebook *facebook;

@property (strong, nonatomic)  UIWindow *window;
@property (nonatomic, assign) bool retainStateOfCollage;
@property (nonatomic, assign) bool displayFBLoginUnavailableAlert;
@property (nonatomic, assign) bool hasUserSelectedMultipleImages;

@property (nonatomic, retain) NSArray *A;
@property (nonatomic, assign) NSArray *B;


-(void)getFacebookUserName;
@end
