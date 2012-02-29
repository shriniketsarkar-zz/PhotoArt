//
//  FBFunViewController.m
//  FBFun
//
//  Created by Ray Wenderlich on 7/13/10.
//  Copyright Ray Wenderlich 2010. All rights reserved.
//

#import "FBFunViewController.h"

@implementation FBFunViewController
@synthesize loginStatusLabel = _loginStatusLabel;
@synthesize loginButton = _loginButton;
@synthesize loginDialog = _loginDialog;
@synthesize loginDialogView = _loginDialogView;

#pragma mark Main

- (void)dealloc
{
    self.loginStatusLabel = nil;
    self.loginButton = nil;
    self.loginDialog = nil;
    self.loginDialogView = nil;
}

- (void)refresh 
{
    if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut)
    {
        _loginStatusLabel.text = @"Not connected to Facebook";
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        _loginButton.hidden = NO;
    } else if (_loginState == LoginStateLoggingIn) 
    {
        _loginStatusLabel.text = @"Connecting to Facebook...";
        _loginButton.hidden = YES;
    } else if (_loginState == LoginStateLoggedIn) 
    {
        _loginStatusLabel.text = @"Connected to Facebook";
        [_loginButton setTitle:@"Logout" forState:UIControlStateNormal];
        _loginButton.hidden = NO;
    }   
}

- (void)viewWillAppear:(BOOL)animated 
{
    [self refresh];
}

#pragma mark Login Button

- (IBAction)loginButtonTapped:(id)sender 
{
    NSString *appId = @"275060699231729";
    NSString *permissions = @"publish_stream";
    
    if (_loginDialog == nil) 
    {
        self.loginDialog = [[FBFunLoginDialog alloc] initWithAppId:appId requestedPermissions:permissions delegate:self];
        self.loginDialogView = _loginDialog.view;
    }
    if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) 
    {
        _loginState = LoginStateLoggingIn;
        [_loginDialog login];
    } else if (_loginState == LoginStateLoggedIn) {
        _loginState = LoginStateLoggedOut;        
        [_loginDialog logout];
    }
    [self refresh];
}

- (IBAction)switchFBOnOff:(UISwitch *)sender 
{
        NSString *appId = @"275060699231729";
        NSString *permissions = @"publish_stream";
        
        if (_loginDialog == nil) 
        {
            self.loginDialog = [[FBFunLoginDialog alloc] initWithAppId:appId requestedPermissions:permissions delegate:self];
            self.loginDialogView = _loginDialog.view;
        }
        if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) 
        {
            _loginState = LoginStateLoggingIn;
            [_loginDialog login];
        } else if (_loginState == LoginStateLoggedIn) 
        {
            _loginState = LoginStateLoggedOut;        
            [_loginDialog logout];
        }
        [self refresh];
}

#pragma mark FBFunLoginDialogDelegate

- (void)accessTokenFound:(NSString *)apiKey 
{
    NSLog(@"Access token found: %@", apiKey);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:apiKey forKey:@"FB_ACCESS_TOKEN_KEY"];
    NSLog(@"Key is after saving: %@",[defaults valueForKey:@"FB_ACCESS_TOKEN_KEY"]);
    _loginState = LoginStateLoggedIn;
    [self dismissModalViewControllerAnimated:YES];
    [self refresh];
}

- (void)displayRequired 
{
    [self presentModalViewController:_loginDialog animated:YES];
}

- (void)closeTapped 
{
    [self dismissModalViewControllerAnimated:YES];
    _loginState = LoginStateLoggedOut;        
    [_loginDialog logout];
    [self refresh];
}

- (void)viewDidUnload 
{    
    [super viewDidUnload];
}
@end
