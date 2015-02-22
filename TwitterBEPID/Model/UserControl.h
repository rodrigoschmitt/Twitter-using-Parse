//
//  UserManager.h
//  TwitterParse
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@class User;

@interface UserControl : NSObject

+ (UserControl *) singleton;

- (void)signupUser:(User *)userSignup profileImage:(UIImage *)profileImage response:(void (^)(BOOL success, NSError *error))response;
- (void)loginUser:(User *)_user response:(void (^)(bool success))response;
- (void)requestUsers:(void (^)(NSArray *users, NSError *error))response userExcluded:(User *)_user;

@end
