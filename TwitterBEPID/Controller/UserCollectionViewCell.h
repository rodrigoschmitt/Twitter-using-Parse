//
//  UserCollectionViewCell.h
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/16/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface UserCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet AsyncImageView *imgProfile;
@property (strong, nonatomic) IBOutlet UILabel  *lblUsername;

- (void)configCell;

@end
