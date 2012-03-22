//
//  Asset.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/21/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface Asset : UIView
{
	ALAsset *asset;
	UIImageView *overlayView;
	BOOL selected;
	id parent;
}
@property (nonatomic, retain) ALAsset *asset;
@property (nonatomic, assign) id parent;

-(id)initWithAsset:(ALAsset*)_asset;
-(BOOL)selected;
@end
