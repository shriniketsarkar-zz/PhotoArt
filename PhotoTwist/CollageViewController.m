//
//  CollageViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/18/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "CollageViewController.h"
#import "PhotoTwistAppDelegate.h"
#import "SVProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"

@interface CollageViewController()
-(void)customizeCollageViewController;
-(void)invokeImagePicker;
@end


@implementation CollageViewController
@synthesize btnCollageCapture;


@synthesize btnPostToFaceBook;
@synthesize activityIndicatorFacebookPostProgress;
@synthesize imageView1,imageView2,imageView3,imageView4,imageView5,imageView6;
@synthesize imageView7,imageView8,imageView9,imageView10,imageView11,imageView12;
@synthesize isImageViewInMotionAlready= _isImageViewInMotionAlready;
@synthesize imageViewBeingDragged=_imageViewBeingDragged;
@synthesize singleTapLocation = _singleTapLocation;

-(void)invokeImagePicker
{
    UIStoryboard *storyBrd = [UIStoryboard storyboardWithName:@"AlbumPicker" bundle:nil];
    AlbumPickerController *albumController = [storyBrd instantiateViewControllerWithIdentifier:@"albumPickerController"];
    ImagePickerController *imagePicker = [[ImagePickerController alloc] initWithRootViewController:albumController];
    [albumController setParent:imagePicker];
    imagePicker.delegate = self;
    [self presentModalViewController:imagePicker animated:YES];    
}
#pragma mark ImagePickerControllerDelegate Methods
-(void)imagePickerController:(ImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissModalViewControllerAnimated:YES];
    PhotoTwistAppDelegate *appDelegate = (PhotoTwistAppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.selectedImagesForCollage = info;
    //NSLog(@"ARRAY VALUES ARE :%@",appDelegate.selectedImagesForCollage);

    if (appDelegate.selectedImagesForCollage)
    {
        //Prepare the view with the images.
        NSInteger counter = 101;    //Refers to the imageView indentifiers.
        
        if ([appDelegate.selectedImagesForCollage count] < 12) 
        {
            for (NSInteger i=counter+[appDelegate.selectedImagesForCollage count]; i<=112; i++) 
            {
                UIImageView *imageView = (UIImageView*)[self.view viewWithTag:i];
                imageView.hidden = YES;
            }
        }
        for(NSDictionary *dict in appDelegate.selectedImagesForCollage) 
        {
            if (counter >= 101 && counter <=112) 
            {
                UIImageView *imageView = (UIImageView *)[self.view viewWithTag:counter];
                imageView.image = [dict objectForKey:UIImagePickerControllerOriginalImage];
                imageView.hidden = NO;
                counter+=1;
            }
        }
    }
    if ([appDelegate.selectedImagesForCollage count] >0)
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.navigationController setToolbarHidden:YES animated:YES];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)imagePickerControllerDidCancel:(ImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [[event allTouches] anyObject];
//    
//    
//    if (touch.tapCount == 2)
//    {
//        if (self.navigationController.navigationBarHidden)
//        {
//            [self.navigationController setNavigationBarHidden:NO animated:YES];
//            [self.navigationController setToolbarHidden:NO animated:YES];
////            [[UIApplication sharedApplication] setStatusBarHidden:NO];
//           
//        }
//        else
//        {
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
//            [self.navigationController setToolbarHidden:YES animated:YES];
////            [[UIApplication sharedApplication] setStatusBarHidden:YES];
//        }
//    }  
////    }else if (touch.tapCount == 1)
////    {
////        self.singleTapLocation = [touch locationInView:touch.view];
////        if (sliderVertical.hidden == YES)
////            sliderVertical.hidden = NO;
////        else
////            sliderVertical.hidden =YES;
////    }
//    else 
//    {
//        CGPoint location = [touch locationInView:touch.view];
//        if (self.isImageViewInMotionAlready == NO)
//        {
//            for (NSInteger imageViewTag =101; imageViewTag <= 112; imageViewTag++) 
//            {
//                UIImageView *imageView = (UIImageView *)[self.view viewWithTag:imageViewTag];
//                if (CGRectContainsPoint(imageView.frame, location)) 
//                {
//                    imageView.center = location;
//                    self.isImageViewInMotionAlready = YES;
//                    self.imageViewBeingDragged = imageViewTag;
//                    [self.view bringSubviewToFront:imageView];
//                }
//            }                                         
//        }
//        else
//        {
//            UIImageView *imageView = (UIImageView *)[self.view viewWithTag:self.imageViewBeingDragged];
//            imageView.center = location;
//            [self.view bringSubviewToFront:imageView];
//        }
//    }
//}
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self touchesBegan:touches withEvent:event];
//}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    self.isImageViewInMotionAlready = NO;
//}

-(void)viewDidLoad
{
//    //Setting the slider verticle.
//    sliderVertical.transform = CGAffineTransformRotate(sliderVertical.transform, 90.0/180*M_PI);
//    [sliderVertical setFrame:CGRectMake(10, 50, 10, 350)];
//    sliderVertical.value = 0;
//    sliderVertical.minimumValue = 0.1;
//    sliderVertical.maximumValue = 1.1;
//    sliderVertical.continuous = YES;
//    sliderVertical.Hidden = YES;

}
-(void)viewWillAppear:(BOOL)animated
{
    [self customizeCollageViewController];
    [self invokeImagePicker];
}
- (IBAction)btnPostToFB:(id)sender 
{
    btnPostToFaceBook.enabled = NO;
    activityIndicatorFacebookPostProgress.hidden = NO;
    [activityIndicatorFacebookPostProgress startAnimating];
    NSString *message = [NSString stringWithFormat:@"Photo from PhotoArt"];
    
    UIImage *imageToPost = [self captureImageFromScreen];
    
    NSData *imageData = UIImageJPEGRepresentation(imageToPost, 1.0);
    NSURL *url = [NSURL URLWithString:@"https://graph.facebook.com/me/photos"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setData:imageData withFileName:@"PhotoArt.jpg" andContentType:@"image/jpeg" forKey:@"photo"];
    [request setPostValue:message forKey:@"message"];
    PhotoTwistAppDelegate *appDelegate = (PhotoTwistAppDelegate *)[[UIApplication sharedApplication]delegate];
    [request setPostValue:appDelegate.facebook.accessToken forKey:@"access_token"];
    [request setDidFinishSelector:@selector(sendToPhotosFinished:)];
    
    [request setDelegate:self];
    [request startAsynchronous];  
}
-(UIImage *)captureImageFromScreen
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageToPost = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageToPost;
}
- (void)sendToPhotosFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    
    NSMutableDictionary *responseJSON = [responseString JSONValue];
    NSString *photoId = [responseJSON objectForKey:@"id"];
    NSLog(@"Photo id is: %@", photoId);
    
    
    PhotoTwistAppDelegate *appDelegate = (PhotoTwistAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"AccessToken Is:%@",appDelegate.facebook.accessToken);
    NSString *urlString = [NSString stringWithFormat:
                           @"https://graph.facebook.com/%@?access_token=%@", photoId, 
                           [appDelegate.facebook.accessToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *newRequest = [ASIHTTPRequest requestWithURL:url];
    [newRequest setDidFinishSelector:@selector(getFacebookPhotoFinished:)];
    
    [newRequest setDelegate:self];
    NSLog(@"Requested.");
    [newRequest startAsynchronous];
    
}
- (void)getFacebookPhotoFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSLog(@"Got Facebook Photo: %@", responseString);
    
    NSMutableDictionary *responseJSON = [responseString JSONValue];   
    
    NSString *link = [responseJSON objectForKey:@"link"];
    if (link == nil) return;   
    NSLog(@"Link to photo: %@", link);
    
    PhotoTwistAppDelegate *appDelegate = (PhotoTwistAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSURL *url = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
    ASIFormDataRequest *newRequest = [ASIFormDataRequest requestWithURL:url];
    [newRequest setPostValue:@"Checkout the photo i created using PhotoArt app!" forKey:@"message"];
    [newRequest setPostValue:@"A beautiful Snap using PhotoArt" forKey:@"name"];
    [newRequest setPostValue:@"Amazing app to get Creative with Photos." forKey:@"caption"];
    [newRequest setPostValue:@"Try it out for free." forKey:@"description"];
    [newRequest setPostValue:@"http://www.google.com" forKey:@"link"];
    [newRequest setPostValue:link forKey:@"picture"];
    [newRequest setPostValue:appDelegate.facebook.accessToken forKey:@"access_token"];
    [newRequest setDidFinishSelector:@selector(postToWallFinished:)];
    
    [newRequest setDelegate:self];
    [newRequest startAsynchronous];
    
}
- (void)postToWallFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    
    NSMutableDictionary *responseJSON = [responseString JSONValue];
    NSString *postId = [responseJSON objectForKey:@"id"];
    NSLog(@"Post id is: %@", postId);
    [activityIndicatorFacebookPostProgress stopAnimating];
    UIAlertView *av = [[UIAlertView alloc] 
                       initWithTitle:@"Sucessfully posted to photos & wall!" 
                       message:@"Check out your Facebook to see!"
                       delegate:nil 
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil];
	[av show];
    btnPostToFaceBook.enabled = YES;
    activityIndicatorFacebookPostProgress.hidden = YES;
}
- (IBAction)captureScreenImage:(id)sender 
{
    UIImage *capturedImage = [self captureImageFromScreen];
    UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil);
    PhotoTwistAppDelegate *appDelegate = (PhotoTwistAppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.retainStateOfCollage = NO;
}


-(void)customizeCollageViewController
{
    //Loose the Status Bar and Navigation Bar
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"PhotoArt_NavigationBarImage.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.imageView1.hidden = YES;
    self.imageView2.hidden = YES;
    self.imageView3.hidden = YES;
    self.imageView4.hidden = YES;
    self.imageView5.hidden = YES;
    self.imageView6.hidden = YES;
    self.imageView7.hidden = YES;
    self.imageView8.hidden = YES;
    self.imageView9.hidden = YES;
    self.imageView10.hidden = YES;
    self.imageView11.hidden = YES;
    self.imageView12.hidden = YES;    
    self.activityIndicatorFacebookPostProgress.hidden = YES;
    
}

//- (IBAction)sliderValueChanged:(UISlider *)sender 
//{
//    for (NSInteger i =101; i<=112; i++) 
//    {
//        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:i];
//        if (!imageView.hidden && CGRectContainsPoint(imageView.frame, self.singleTapLocation))
//        {
//            if (imageView.bounds.size.width <=204 && imageView.bounds.size.width >= 104)
//            {
//                [imageView setFrame:CGRectMake((imageView.center.x - imageView.frame.size.width/2), (imageView.center.y-imageView.frame.size.height/2), (imageView.frame.size.width+([sliderVertical value]*100)), imageView.frame.size.height+([sliderVertical value]*100))];
//            }
//        }
//    }
//
//}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



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


    [self setBtnPostToFaceBook:nil];
    [self setActivityIndicatorFacebookPostProgress:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer 
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x+translation.x, 
                                         recognizer.view.center.y +translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    //    if (sender.state == UIGestureRecognizerStateEnded) {
    //        
    //        CGPoint velocity = [sender velocityInView:self.view];
    //        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
    //        CGFloat slideMult = magnitude / 200;
    //        //NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
    //        
    //        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
    //        CGPoint finalPoint = CGPointMake(sender.view.center.x + (velocity.x * slideFactor), 
    //                                         sender.view.center.y + (velocity.y * slideFactor));
    //        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
    //        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
    //        
    //        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    //            sender.view.center = finalPoint;
    //        } completion:nil];
    //        
    //    }
}
- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer {    
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;    
}

- (IBAction)handleRotate:(UIRotationGestureRecognizer *)recognizer {    
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;    
}
@end
