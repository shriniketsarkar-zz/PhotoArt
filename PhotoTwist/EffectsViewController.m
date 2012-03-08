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

@implementation EffectsViewController
@synthesize tableViewEffects;
@synthesize btnGrayImage;
@synthesize btnNegative;
@synthesize toolBarTop;
@synthesize toolBarBottom;

@synthesize imageViewEffectsVC;
@synthesize frameImagesArray;

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

- (void)viewDidLoad
{
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    frameImagesArray = [[NSArray alloc]initWithObjects:
                        [UIImage imageNamed:@"PhotoArt_BorderDesign1.jpg"],
                        [UIImage imageNamed:@"PhotoArt_BorderDesign2.gif"], nil];
    
    UIView *viewPop = [self.view viewWithTag:101];
    viewPop.hidden = YES;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:imagePicker animated:YES];
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setImageViewEffectsVC:nil];
    [self setBtnGrayImage:nil];
    [self setBtnNegative:nil];
    [self setToolBarTop:nil];
    [self setToolBarBottom:nil];

    [self setTableViewEffects:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)btnNegateImage:(id)sender {
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

- (IBAction)postImageToFacebook:(id)sender 
{
    NSLog(@"I entered.");

}
#pragma UIImagePicker methods.
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imageViewEffectsVC.image = [info objectForKey:UIImagePickerControllerOriginalImage ];
    [self dismissModalViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    
    if (touch.tapCount == 2)
    {
        if (self.toolBarTop.hidden)
        {
            [self.toolBarTop setHidden:NO];
            [self.toolBarBottom setHidden:NO];
        }
        else
        {
            [self.toolBarBottom setHidden:YES];
            [self.toolBarTop setHidden:YES];
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
    NSString *message = [NSString stringWithFormat:@"Photofrom Art"];
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
- (void)getFacebookPhotoFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSLog(@"Got Facebook Photo: %@", responseString);
    
    NSMutableDictionary *responseJSON = [responseString JSONValue];   
    
    NSString *link = [responseJSON objectForKey:@"link"];
    if (link == nil) return;   
    NSLog(@"Link to photo: %@", link);
    
}
@end
