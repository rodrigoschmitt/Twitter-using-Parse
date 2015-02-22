//
//  TweetTableViewCell.m
//  TwitterParse
//
//  Created by Rodrigo Andrade on 2/21/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "TimelineTableViewCell.h"
#import "Util.h"
#import "User.h"

@implementation TimelineTableViewCell

- (void)configCell {
    [Util circularProfile:self.imgProfile];
}

@end
