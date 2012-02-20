//
//  CameraViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/19/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "CameraViewController.h"

@implementation CameraViewController

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


//This method gets control when the picture is taken and raw media is available.
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *capturedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(capturedImage, self ,@selector(image:didFinishSavingWithError:contextInfo:), nil);
}
//Display the status.
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    if (error)
        alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to save image to Photo Album." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    else
        alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Image saved to Photo Album" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    UIColor *backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"iPhoneBackground.jpg"]];
    self.view.backgroundColor = backgroundColor;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:picker animated:YES];
        
    }
    else
    {
        //Display message Camera Not Available.
    }
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
