//
//  CollageViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/18/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "CollageViewController.h"
#import "ELCAlbumPickerController.h"
#import "PhotoTwistAppDelegate.h"
@implementation CollageViewController
@synthesize btnCollageCapture;
@synthesize btnCollageCancel;
@synthesize imageView1,imageView2,imageView3,imageView4,imageView5,imageView6;
@synthesize imageView7,imageView8,imageView9,imageView10,imageView11,imageView12;
@synthesize isImageViewInMotionAlready= _isImageViewInMotionAlready;
@synthesize imageViewBeingDragged=_imageViewBeingDragged;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    
    if (touch.tapCount == 2)
    {
        if (self.navigationController.navigationBarHidden)
        {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            [self.navigationController setToolbarHidden:NO animated:YES];
        }
        else
        {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            [self.navigationController setToolbarHidden:YES animated:YES];
        }
        
    }else
    {
        CGPoint location = [touch locationInView:touch.view];
        if (self.isImageViewInMotionAlready == NO)
        {
            for (NSInteger imageViewTag =101; imageViewTag <= 112; imageViewTag++) 
            {
                UIImageView *imageView = (UIImageView *)[self.view viewWithTag:imageViewTag];
                if (CGRectContainsPoint(imageView.frame, location)) 
                {
                    imageView.center = location;
                    self.isImageViewInMotionAlready = YES;
                    self.imageViewBeingDragged = imageViewTag;
                    [self.view bringSubviewToFront:imageView];
                }
            }                                         
        }
        else
        {
            UIImageView *imageView = (UIImageView *)[self.view viewWithTag:self.imageViewBeingDragged];
            imageView.center = location;
            [self.view bringSubviewToFront:imageView];
        }
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesBegan:touches withEvent:event];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isImageViewInMotionAlready = NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        

    }
    return self;
}
-(void)viewDidLoad
{
    UIColor *backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"iPhoneBackground.jpg"]];
    self.view.backgroundColor = backgroundColor;
    
    PhotoTwistAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.retainStateOfCollage)
        [self invokeImagePicker];
}

- (IBAction)captureScreenImage:(id)sender 
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil);
}

- (IBAction)dismissCollageView:(id)sender {
}

- (IBAction)goBackRetainingView:(id)sender {
    PhotoTwistAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.retainStateOfCollage = YES;
}

-(void)invokeImagePicker
{
    ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] initWithNibName:@"ELCAlbumPickerController" bundle:[NSBundle mainBundle]];    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
    [albumController setParent:elcPicker];
    elcPicker.delegate = self;
    [self presentModalViewController:elcPicker animated:NO];    
}
#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
	
	[self dismissModalViewControllerAnimated:YES];
    NSInteger counter = 101;
    for(NSDictionary *dict in info) 
    {
        if (counter >= 101 && counter <=112) 
        {
            UIImageView *imageView = (UIImageView *)[self.view viewWithTag:counter];
            imageView.image = [dict objectForKey:UIImagePickerControllerOriginalImage];
            counter+=1;
        }
	}

    
    //Loose the Status Bar and Navigation Bar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    //[self.navigationController setHidesBottomBarWhenPushed:YES];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    
	[self dismissModalViewControllerAnimated:YES];
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
    [self setImageView1:nil];
    [self setImageView2:nil];
    [self setImageView3:nil];
    [self setImageView4:nil];
    [self setImageView5:nil];
    [self setImageView6:nil];
    [self setImageView7:nil];
    [self setImageView8:nil];
    [self setImageView9:nil];
    [self setImageView10:nil];
    [self setImageView11:nil];
    [self setImageView12:nil];
    


    [self setBtnCollageCapture:nil];
    [self setBtnCollageCancel:nil];
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
