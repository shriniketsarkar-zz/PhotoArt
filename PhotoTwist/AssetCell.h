//
//  AssetCell.h
//  PhotoTwist
//
//  Created by Shriniket Sarkar on 3/21/12.
//  Copyright (c) 2012 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetCell : UITableViewCell
{
    NSArray *rowAssets;
}
@property (nonatomic,retain) NSArray *rowAssets;
-(id)initWithAssets:(NSArray*)_assets reuseIdentifier:(NSString*)_identifier;
-(void)setAssets:(NSArray*)_assets;

@end
