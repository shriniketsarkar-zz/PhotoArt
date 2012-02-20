//
//  PhotoTwistAppDelegate.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/10/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTwistAppDelegate : UIResponder <UIApplicationDelegate>
{
    bool retainStateOfCollage;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) bool retainStateOfCollage;
@end
