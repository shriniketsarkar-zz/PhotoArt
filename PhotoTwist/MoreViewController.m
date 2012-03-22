//
//  MoreViewController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/3/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "MoreViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "PhotoTwistAppDelegate.h"
#import "SVProgressHUD.h"
#import "Twitter/Twitter.h"

@implementation MoreViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PhotoArt_NavigationBarImage.png"]]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
//    UIColor *color = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"PhotoArt_NavigationBarImage.png"]];
//    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
//        [self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PhotoArt_NavigationBarImage.png"]]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"PhotoArt_NavigationBarImage.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"PhotoArt_TabBarImage.png"]];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PhotoArt_NavigationBarImage.png"]]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Clicked. = %@",indexPath);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:@"settingsShareOnFacebook"]) 
    {
        NSLog(@"The Cell is : %@",cell.reuseIdentifier);
        [self postOnFacebookWall];
    }
    if ([cell.reuseIdentifier isEqualToString:@"settingsShareOnSMS"]) 
    {
        NSLog(@"The Cell is : %@",cell.reuseIdentifier);
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc]init];
        if ([MFMessageComposeViewController canSendText]) 
        {
            picker.messageComposeDelegate = self;
            [picker setBody:@"I am using PhotoArt to create amazing Collage with Photo Art. You can try it too."];
            picker.recipients = [NSArray arrayWithObject:@"1234567890"];
            [self presentModalViewController:picker animated:YES];
        }    

    }
    if ([cell.reuseIdentifier isEqualToString:@"settingsShareOnTweeter"]) 
    {
        NSLog(@"The Cell is : %@",cell.reuseIdentifier);
        //Twitter Post for PhotoArt
        TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init]; 
        [twitter setInitialText:@"Guys, I am using PhotoArt app for creating Collage with photos and awesome photo art.Try this app at..."]; 
        [twitter addURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com"]]]; 
        
        if([TWTweetComposeViewController canSendTweet]) 
            [self presentViewController:twitter animated:YES completion:nil]; 
        else
        { 
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Unable to tweet" message:@"Please log in to Twitter from you iPhones Settings." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil]; 
            [alertView show]; 
            return; 
        } 
        twitter.completionHandler = ^(TWTweetComposeViewControllerResult res)
        { 
            if (res == TWTweetComposeViewControllerResultDone) 
            { 
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Tweet Successful!" message:@"Your tweet was Successful!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
                [alertView show];
                //[self.navigationController popToRootViewControllerAnimated:YES];
            } else if (res == TWTweetComposeViewControllerResultCancelled) 
            {
                //            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Oh Dear" message:@"Tweet Failed to send, try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
                //            [alertView show];
                
            }
            [self dismissModalViewControllerAnimated:YES]; 
            //[self.navigationController popToRootViewControllerAnimated:YES];
        };
    }
    if ([cell.reuseIdentifier isEqualToString:@"settingsShareOnEmail"]) 
    {
        NSLog(@"The Cell is : %@",cell.reuseIdentifier);
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
        picker.mailComposeDelegate = self;
        [picker setSubject:@"Try out PhotoArt."];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"firstlast@example.com", nil];
        [picker setToRecipients:toRecipients];
        NSString *emailBody = @"I am using PhotoArt to create amazing Collage with Photo Art. You can try it too.";
        [picker setMessageBody:emailBody isHTML:NO];
        [self presentModalViewController:picker animated:YES];
    }
[tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (void)postOnFacebookWall
{
    PhotoTwistAppDelegate *appDelegate = (PhotoTwistAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSURL *url = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
    ASIFormDataRequest *newRequest = [ASIFormDataRequest requestWithURL:url];
    [newRequest setPostValue:@"Photo art is an application for iPhone to get creative with Photos!" forKey:@"message"];
    [newRequest setPostValue:@"PhotoArt" forKey:@"name"];
    [newRequest setPostValue:@"Amazing app to get Creative with Photos." forKey:@"caption"];
    [newRequest setPostValue:@"Try it out for free." forKey:@"description"];
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
//The Mail compose view controller delegate method
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
