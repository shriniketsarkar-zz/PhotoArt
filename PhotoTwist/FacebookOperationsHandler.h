//
//  FacebookOperationsHandler.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/14/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookOperationsHandler : NSObject

-(void)postToFacebook: (UIImage *)imageToPost;
+(id)sharedFBOperationsHandler;
@end
