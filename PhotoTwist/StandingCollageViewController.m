//
//  StandingCollageViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/20/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "StandingCollageViewController.h"
#import "PhotoTwistAppDelegate.h"
@implementation StandingCollageViewController

@synthesize imageViewLastCollage;
@synthesize btnResumeCollage;
@synthesize btnNewCollage;
@synthesize collageToolBar;

-(void)viewDidAppear:(BOOL)animated
{
    //Check if Collage is in Progress.
    PhotoTwistAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [collageToolBar setUserInteractionEnabled:YES];

    if(appDelegate.retainStateOfCollage)
    {
        btnResumeCollage.enabled = YES;
        btnNewCollage.enabled = NO;
    }
    else
    {
        btnResumeCollage.enabled = NO;
        btnNewCollage.enabled = YES;
    }
}
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setImageViewLastCollage:nil];

    [self setBtnNewCollage:nil];
    [self setBtnResumeCollage:nil];
    [self setCollageToolBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)loadNewCollage:(id)sender 
{
    PhotoTwistAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        appDelegate.retainStateOfCollage = NO;
    UIViewController *collageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"collageVC"];
    [self.navigationController pushViewController:collageViewController animated:YES];

}
- (IBAction)resumeExistingCollage:(id)sender 
{
    PhotoTwistAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        appDelegate.retainStateOfCollage = YES;
    UIViewController *collageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"collageVC"];
        [self.navigationController pushViewController:collageViewController animated:YES];
}
@end
