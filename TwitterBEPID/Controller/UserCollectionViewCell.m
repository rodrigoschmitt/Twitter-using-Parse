//
//  UserCollectionViewCell.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/16/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "UserCollectionViewCell.h"
#import "Util.h"

@implementation UserCollectionViewCell

- (void)configCell {
    [Util circularProfile:self.imgProfile];
}

@end
