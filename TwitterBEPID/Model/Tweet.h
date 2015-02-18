//
//  Tweet.h
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/17/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *idTweet;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) User *user;

@end
