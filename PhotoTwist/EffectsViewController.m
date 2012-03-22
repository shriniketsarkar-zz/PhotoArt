//
//  EffectsViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 2/18/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "EffectsViewController.h"
#import "PhotoTwistAppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"

@interface EffectsViewController()
-(void) customizeEffectsViewController;
-(void) invokeImagePicker;
@end



@implementation EffectsViewController
@synthesize activityIndicatorFacebookPostProgress;
@synthesize btnPostToFB;
@synthesize tableViewEffects;
@synthesize btnGrayImage;
@synthesize btnNegative;
//@synthesize toolBarTop;
@synthesize toolBarBottom;

@synthesize imageViewEffectsVC;
@synthesize frameImagesArray;

-(void)viewWillAppear:(BOOL)animated
{
    [self customizeEffectsViewController];
    [self invokeImagePicker];
}
-(void)customizeEffectsViewController
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"PhotoArt_NavigationBarImage.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBarHidden = NO;
}
-(void)invokeImagePicker
{

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:imagePicker animated:YES];
}
- (void)viewDidLoad
{
    //[[UIApplication sharedApplication]setStatusBarHidden:YES];
    frameImagesArray = [[NSArray alloc]initWithObjects:
                        [UIImage imageNamed:@"PhotoArt_BorderDesign1.jpg"],
                        [UIImage imageNamed:@"PhotoArt_BorderDesign2.gif"], nil];
    
    UIView *viewPop = [self.view viewWithTag:101];
    viewPop.hidden = YES;
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setImageViewEffectsVC:nil];
    [self setBtnGrayImage:nil];
    [self setBtnNegative:nil];
//    [self setToolBarTop:nil];
    [self setToolBarBottom:nil];

    [self setTableViewEffects:nil];
    [self setActivityIndicatorFacebookPostProgress:nil];
    [self setBtnPostToFB:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (IBAction)btnNegateImage:(id)sender 
{
    imageViewEffectsVC.image = [self generateImageUsingNegativeFilter:imageViewEffectsVC.image];
}
-(UIImage *)generateImageUsingNegativeFilter : (UIImage *)inputImage
{
    // get width and height as integers, since we'll be using them as
    // array subscripts, etc, and this'll save a whole lot of casting
    CGSize size = inputImage.size;
    int width = size.width;
    int height = size.height;
    
    // Create a suitable RGB+alpha bitmap context in BGRA colour space
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *memoryPool = (unsigned char *)calloc(width*height*4, 1);
    CGContextRef context = CGBitmapContextCreate(memoryPool, width, height, 8, width * 4, colourSpace, kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colourSpace);
    
    // draw the current image to the newly created context
    //        CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [inputImage CGImage]);    
    
    // run through every pixel, a scan line at a time...
    for(int y = 0; y < height; y++)
    {
        // get a pointer to the start of this scan line
        unsigned char *linePointer = &memoryPool[y * width * 4];
        
        // step through the pixels one by one...
        for(int x = 0; x < width; x++)
        {
            // get RGB values. We're dealing with premultiplied alpha
            // here, so we need to divide by the alpha channel (if it
            // isn't zero, of course) to get uninflected RGB. We
            // multiply by 255 to keep precision while still using
            // integers
            int r, g, b; 
            if(linePointer[3])
            {
                r = linePointer[0] * 255 / linePointer[3];
                g = linePointer[1] * 255 / linePointer[3];
                b = linePointer[2] * 255 / linePointer[3];
            }
            else
                r = g = b = 0;
            
            // perform the colour inversion
            r = 255 - r;
            g = 255 - g;
            b = 255 - b;
            
            // multiply by alpha again, divide by 255 to undo the
            // scaling before, store the new values and advance
            // the pointer we're reading pixel data from
            linePointer[0] = r * linePointer[3] / 255;
            linePointer[1] = g * linePointer[3] / 255;
            linePointer[2] = b * linePointer[3] / 255;
            linePointer += 4;
        }
    }
    
    // get a CG image from the context, wrap that into a
    // UIImage
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    // clean up
    CGImageRelease(cgImage);
    CGContextRelease(context);
    free(memoryPool);
    return returnImage;
}
- (IBAction)btnFramesClicked:(id)sender 
{
    UIView *viewPop = [self.view viewWithTag:101];
    if (viewPop.hidden)
    {
        viewPop.frame = CGRectMake(5.0,46.0 , 310.0, 80.0);    

        tableViewEffects.transform = CGAffineTransformMakeRotation(-1.5707963);
        [tableViewEffects reloadData];
        viewPop.hidden = NO;
    }
    else
    {
        viewPop.hidden = YES;
    }
}
- (IBAction)btnGrayImage:(id)sender 
{
    
    UIImage *sourceImage = imageViewEffectsVC.image;
    
    int width = sourceImage.size.width;
	int height = sourceImage.size.height;
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();

	CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    
	CGColorSpaceRelease(colorSpace);
    
	if (context)
    {
        CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
        UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
        imageViewEffectsVC.image = grayImage;
	}
}


#pragma UIImagePicker methods.
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModalViewControllerAnimated:YES];
    imageViewEffectsVC.image = [info objectForKey:UIImagePickerControllerOriginalImage ];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    
    if (touch.tapCount == 2)
    {
        if (self.navigationController.navigationBar.hidden)
        {
//            [self.toolBarTop setHidden:NO];
            self.navigationController.navigationBar.hidden = NO;
            [self.toolBarBottom setHidden:NO];
        }
        else
        {
            self.navigationController.navigationBar.hidden = YES;
            [self.toolBarBottom setHidden:YES];
//            [self.toolBarTop setHidden:YES];
        }
    }  
}

//TableView stuff.
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.transform = CGAffineTransformMakeRotation(1.5707963);;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [frameImagesArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"framesTableViewCell"];

    if (cell == nil) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"framesTableViewCell"];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:201];

    imageView.image = [frameImagesArray objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)postToFB:(id)sender 
{
    btnPostToFB.enabled = NO;
    activityIndicatorFacebookPostProgress.hidden = NO;
    [activityIndicatorFacebookPostProgress startAnimating];
    NSString *message = [NSString stringWithFormat:@"Photo from PhotoArt"];
    UIImage *imageToPost = imageViewEffectsVC.image;
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
    btnPostToFB.enabled = YES;
    activityIndicatorFacebookPostProgress.hidden = YES;
}
@end
