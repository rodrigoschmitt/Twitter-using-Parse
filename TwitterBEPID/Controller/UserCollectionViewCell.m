//
//  UserCollectionViewCell.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/16/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "UserCollectionViewCell.h"

@implementation UserCollectionViewCell

- (void)configCell {
    self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.width / 2;
    self.imgProfile.clipsToBounds = YES;
    self.imgProfile.layer.borderWidth = 3.0f;
    self.imgProfile.layer.borderColor = [UIColor grayColor].CGColor;
}

@end
