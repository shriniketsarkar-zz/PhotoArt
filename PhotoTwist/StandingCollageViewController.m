//
//  StandingCollageViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/20/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "StandingCollageViewController.h"
@implementation StandingCollageViewController
@synthesize imageViewLastCollage;
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"PhotoArt_NavigationBarImage.png"] forBarMetrics:UIBarMetricsDefault];
    [self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"PhotoArt_TabBarImage.png"]];
    [imageViewLastCollage.layer setBorderWidth:2];
    [imageViewLastCollage.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PhotoArtBase.png"]]];
}
-(void)viewDidLoad
{
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"PhotoArt_NavigationBarImage.png"] forBarMetrics:UIBarMetricsDefault];
    
    //[[UIApplication sharedApplication] setStatusBarHidden:NO];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewDidUnload
{
    [self setImageViewLastCollage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}





@end
