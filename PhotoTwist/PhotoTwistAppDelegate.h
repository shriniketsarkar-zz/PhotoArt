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
@interface PhotoTwistAppDelegate : UIResponder <UIApplicationDelegate,FBSessionDelegate>
{
    Facebook *facebook;
    SettingsViewController *settingsVC;
    bool retainStateOfCollage;
    bool displayFBLoginUnavailableAlert;
}
@property (nonatomic,retain) Facebook *facebook;
@property (nonatomic,retain) SettingsViewController *settingsVC;
@property (strong, nonatomic)  UIWindow *window;
@property (nonatomic, assign) bool retainStateOfCollage;
@property (nonatomic, assign) bool displayFBLoginUnavailableAlert;
@property (weak, nonatomic) IBOutlet UITabBarController *tabBarPhotoTwist;
@end
