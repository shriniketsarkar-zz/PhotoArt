//
//  PhotoTwistTabBarController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/29/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "PhotoTwistTabBarController.h"

@implementation PhotoTwistTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"PhotoArt_TabBarImage.png"]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
//    [self.tabBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PhotoArtBase.png"]]];
    //[self.tabBar setBackgroundImage:[UIImage imageNamed:@"PhotoArtBase.png"]];
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
