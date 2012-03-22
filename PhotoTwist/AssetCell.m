//
//  AssetCell.m
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/21/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import "AssetCell.h"
#import "Asset.h"

@implementation AssetCell
@synthesize rowAssets;


-(id)initWithAssets:(NSArray*)_assets reuseIdentifier:(NSString*)_identifier {
    
	if(self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier]) {
        
		self.rowAssets = _assets;
	}
	
	return self;
}

-(void)setAssets:(NSArray*)_assets {
	
	for(UIView *view in [self subviews]) 
    {		
		[view removeFromSuperview];
	}
	
	self.rowAssets = _assets;
}

-(void)layoutSubviews {
    
	CGRect frame = CGRectMake(4, 2, 75, 75);
	
	for(Asset *asset in self.rowAssets)
    {
		[asset setFrame:frame];
		[asset addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:asset action:@selector(toggleSelection)] ];
		[self addSubview:asset];
		frame.origin.x = frame.origin.x + frame.size.width + 4;
	}
}
-(void)dealloc
{
    [self setRowAssets:nil];
}
@end
