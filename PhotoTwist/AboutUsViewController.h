//
//  AboutUsViewController.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/11/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface AboutUsViewController : UIViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
- (IBAction)sendEmail:(id)sender;
- (IBAction)sendSMS:(id)sender;

@end
