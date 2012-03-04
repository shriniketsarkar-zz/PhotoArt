//
//  SettingsViewController.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/4/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController 
- (IBAction)facebookConnectSwitchOnOff:(id)sender;
@property (strong, nonatomic) IBOutlet UISwitch *facebookConnectSwitch;
@end
