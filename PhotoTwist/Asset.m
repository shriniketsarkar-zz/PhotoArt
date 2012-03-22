//
//  Asset.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/21/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "Asset.h"

@implementation Asset
@synthesize asset;// = _asset;
@synthesize parent = _parent;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithAsset:(ALAsset*)_asset {
	
	if (self = [super initWithFrame:CGRectMake(0, 0, 0, 0)]) {
		
		self.asset = _asset;
		
		CGRect viewFrames = CGRectMake(0, 0, 75, 75);
		
		UIImageView *assetImageView = [[UIImageView alloc] initWithFrame:viewFrames];
		[assetImageView setContentMode:UIViewContentModeScaleToFill];
		[assetImageView setImage:[UIImage imageWithCGImage:[self.asset thumbnail]]];
		[self addSubview:assetImageView];
		
		overlayView = [[UIImageView alloc] initWithFrame:viewFrames];
		[overlayView setImage:[UIImage imageNamed:@"Overlay.png"]];
		[overlayView setHidden:YES];
		[self addSubview:overlayView];
    }
    
	return self;	
}

-(void)toggleSelection {
    
	overlayView.hidden = !overlayView.hidden;
    
    //    if([(ELCAssetTablePicker*)self.parent totalSelectedAssets] >= 10) {
    //        
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Maximum Reached" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    //		[alert show];
    //		[alert release];	
    //
    //        [(ELCAssetTablePicker*)self.parent doneAction:nil];
    //    }
}

-(BOOL)selected {
	
	return !overlayView.hidden;
}

-(void)setSelected:(BOOL)_selected {
    
	[overlayView setHidden:!_selected];
}
-(void)dealloc
{
    [self setParent:nil];
    [self setAsset:nil];
}

@end
