//
//  ImagePickerController.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/21/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImagePickerController;
@protocol ImagePickerControllerDelegate

- (void)imagePickerController:(ImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;
- (void)imagePickerControllerDidCancel:(ImagePickerController *)picker;

@end

@interface ImagePickerController : UINavigationController
{
    __weak id delegate;
}
@property (nonatomic, weak) id delegate;
-(void)selectedAssets:(NSArray*)_assets;
-(void)cancelImagePicker;

@end

