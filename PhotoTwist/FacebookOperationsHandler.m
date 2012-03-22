//
//  FacebookOperationsHandler.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/14/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "FacebookOperationsHandler.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "PhotoTwistAppDelegate.h"
#import "JSON.h"

static FacebookOperationsHandler *sharedFBOperationsHandler = nil;
@implementation FacebookOperationsHandler
+(id)sharedFBOperationsHandler
{
    @synchronized(self)
    {
        if (sharedFBOperationsHandler == nil)
            sharedFBOperationsHandler = [[self alloc] init];
    }
    return sharedFBOperationsHandler;
}
-(void)postToFacebook: (UIImage *)imageToPost
{
    NSString *message = [NSString stringWithFormat:@"Photo from PhotoArt"];
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
    //[activityIndicatorFacebookPostProgress stopAnimating];
    UIAlertView *av = [[UIAlertView alloc] 
                       initWithTitle:@"Sucessfully posted to photos & wall!" 
                       message:@"Check out your Facebook to see!"
                       delegate:nil 
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil];
	[av show];
    //btnPostToFB.enabled = YES;
    //activityIndicatorFacebookPostProgress.hidden = YES;
}
@end
