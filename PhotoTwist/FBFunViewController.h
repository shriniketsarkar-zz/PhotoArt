//
//  FBFunViewController.h
//  FBFun
//
//  Created by Ray Wenderlich on 7/13/10.
//  Copyright Ray Wenderlich 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBFunLoginDialog.h"

typedef enum 
{
    LoginStateStartup,
    LoginStateLoggingIn,
    LoginStateLoggedIn,
    LoginStateLoggedOut
} LoginState;

@interface FBFunViewController : UIViewController <FBFunLoginDialogDelegate> 
{
    UILabel *_loginStatusLabel;
    UIButton *_loginButton;
    LoginState _loginState;
    FBFunLoginDialog *_loginDialog;
    UIView *_loginDialogView;
}

@property (retain) IBOutlet UILabel *loginStatusLabel;
@property (retain) IBOutlet UIButton *loginButton;
@property (retain) FBFunLoginDialog *loginDialog;
@property (retain) IBOutlet UIView *loginDialogView;

- (IBAction)loginButtonTapped:(id)sender;

- (IBAction)switchFBOnOff:(id)sender;

@end

