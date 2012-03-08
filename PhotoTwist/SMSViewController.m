//
//  SMSViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/4/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "SMSViewController.h"
#import "SVProgressHUD.h"
@implementation SMSViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc]init];
    if ([MFMessageComposeViewController canSendText]) 
    {
        picker.messageComposeDelegate = self;
        [picker setBody:@"I am using PhotoArt to create amazing Collage with Photo Art. You can try it too."];
        picker.recipients = [NSArray arrayWithObject:@"1234567890"];
        [self presentModalViewController:picker animated:YES];
    }    
    else
        [self.navigationController popViewControllerAnimated:YES];
    
}

//The Message compose view controller delegate method
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) 
    {
		case MessageComposeResultCancelled:
			break;
		case MessageComposeResultFailed:
            [SVProgressHUD dismissWithError:@"Couldnt Send SMS. Try again."];
			break;
		case MessageComposeResultSent:
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
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
