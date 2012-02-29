//
//  AboutUsViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/11/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "AboutUsViewController.h"

@implementation AboutUsViewController
@synthesize imageViewAboutUS;
-(void)viewDidAppear:(BOOL)animated
{
    [NSThread detachNewThreadSelector:@selector(runAnimation) toTarget:self withObject:nil];
}
-(void)runAnimation
{
    imageViewAboutUS.animationImages = [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"PhotoArtBase1.jpg"],
                                        [UIImage imageNamed:@"PhotoArtBase2.jpg"],
                                        [UIImage imageNamed:@"PhotoArtBase3.jpg"],
                                        [UIImage imageNamed:@"PhotoArtBase4.jpg"],
                                        [UIImage imageNamed:@"PhotoArtBase5.jpg"],
                                        [UIImage imageNamed:@"PhotoArtBase6.jpg"],
                                        [UIImage imageNamed:@"PhotoArtBase7.jpg"],
                                        [UIImage imageNamed:@"PhotoArtBase8.jpg"],
                                        [UIImage imageNamed:@"PhotoArtBase9.jpg"],
                                        [UIImage imageNamed:@"PhotoArtBase10.jpg"],
                                        [UIImage imageNamed:@"PhotoArtBase11.jpg"],
                                        [UIImage imageNamed:@"PhotoArtBase12.jpg"],nil];
    
    
    imageViewAboutUS.animationDuration = 3.5;
    imageViewAboutUS.animationRepeatCount = 0;
    [imageViewAboutUS startAnimating];

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    UIColor *backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"PhotoArtBase.png"]];
    self.view.backgroundColor = backgroundColor;
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setImageViewAboutUS:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//The Mail compose view controller delegate method
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

//The Message compose view controller delegate method
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction)sendEmail:(id)sender {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"PhotoTwist Mail to Shriniket."];
    NSArray *toRecipients = [NSArray arrayWithObjects:@"firstlast@example.com", nil];
    [picker setToRecipients:toRecipients];
    NSString *emailBody = @"This is a dummy mail";
    [picker setMessageBody:emailBody isHTML:NO];
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)sendSMS:(id)sender {
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc]init];
    picker.messageComposeDelegate = self;
    [picker setBody:@"This is a dummy mail"];
    [self presentModalViewController:picker animated:YES];
    
}

@end
