//
//  ImagePickerController.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/21/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "ImagePickerController.h"
#import "Asset.h"
#import "AssetCell.h"
#import "AssetTablePicker.h"
#import "AlbumPickerController.h"

@implementation ImagePickerController
@synthesize delegate;

-(void)cancelImagePicker 
{
	if([delegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) 
    {
		[delegate performSelector:@selector(imagePickerControllerDidCancel:) withObject:self];
	}
}
-(void)selectedAssets:(NSArray*)_assets 
{
    
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
	
	for(ALAsset *asset in _assets) 
    {
		NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
		[workingDictionary setObject:[asset valueForProperty:ALAssetPropertyType] forKey:@"UIImagePickerControllerMediaType"];
        [workingDictionary setObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]] forKey:@"UIImagePickerControllerOriginalImage"];
		[workingDictionary setObject:[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]] forKey:@"UIImagePickerControllerReferenceURL"];
		
		[returnArray addObject:workingDictionary];
	}
	
    [self popToRootViewControllerAnimated:NO];
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
    
	if([delegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]) {
		[delegate performSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:) withObject:self withObject:[NSArray arrayWithArray:returnArray]];
	}
}
@end
