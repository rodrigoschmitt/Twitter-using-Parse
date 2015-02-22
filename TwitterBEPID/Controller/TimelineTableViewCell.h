//
//  TweetTableViewCell.h
//  TwitterParse
//
//  Created by Rodrigo Andrade on 2/21/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface TimelineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet AsyncImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblFullname;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblTweet;

- (void)configCell;

@end
