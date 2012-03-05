//
//  StandingCollageViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/20/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "StandingCollageViewController.h"
#import "PhotoTwistAppDelegate.h"
#import "SVProgressHUD.h"
@implementation StandingCollageViewController

@synthesize imageViewLastCollage;

@synthesize btnNewCollage;
@synthesize collageToolBar;

-(void)viewDidAppear:(BOOL)animated
{

    PhotoTwistAppDelegate *appDelegate = (PhotoTwistAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"I Appeared. = %@",appDelegate.retainStateOfCollage);
    if (appDelegate.retainStateOfCollage)
        self.navigationController.toolbar.hidden = YES;
    
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
-(void)invokeImagePicker
{
    ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] initWithNibName:@"ELCAlbumPickerController" bundle:[NSBundle mainBundle]];    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
    [albumController setParent:elcPicker];
    elcPicker.delegate = self;
    [self presentModalViewController:elcPicker animated:YES];    
}


- (IBAction)loadNewCollage:(id)sender 
{
    [self invokeImagePicker];
}
#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info 
{
    //Dismiss the picker.
	[self dismissModalViewControllerAnimated:YES];
    
    PhotoTwistAppDelegate *appDelegate = (PhotoTwistAppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.selectedImagesForCollage = info;
    //NSLog(@"The Array has: %@",appDelegate.selectedImagesForCollage);
    
    UIViewController *collageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"collageVC"];
    
    
    //Prepare the view with the images.
    NSInteger counter = 101;    //Reffers to the imageView indentifiers.
    
    if ([appDelegate.selectedImagesForCollage count] < 12) 
    {
        for (NSInteger i=counter+[appDelegate.selectedImagesForCollage count]; i<=112; i++) 
        {
            UIImageView *imageView = (UIImageView*)[collageViewController.view viewWithTag:i];
            imageView.hidden = YES;
        }
    }
    for(NSDictionary *dict in appDelegate.selectedImagesForCollage) 
    {
        if (counter >= 101 && counter <=112) 
        {
            UIImageView *imageView = (UIImageView *)[collageViewController.view viewWithTag:counter];
            imageView.image = [dict objectForKey:UIImagePickerControllerOriginalImage];
            counter+=1;
        }
    }
    //NSLog(@"Presenting modal VC");
    [self.navigationController pushViewController:collageViewController animated:YES];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    
	[self dismissModalViewControllerAnimated:YES];
}
@end
