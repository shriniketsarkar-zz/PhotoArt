//
//  MoreViewController.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/3/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
@interface MoreViewController : UITableViewController<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>
- (void)postOnFacebookWall;
@end
