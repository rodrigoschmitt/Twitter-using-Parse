//
//  UserManager.h
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@class User;

@interface UserManager : NSObject

+ (UserManager *) singleton;

- (void)loginUser:(User *)_user response:(void (^)(bool success))response;
- (void)registerUser:(User *)_user profileImage:(UIImage *)profileImage;
- (void)requestUsers:(void (^)(NSArray *users, NSError *error))response userExcluded:(User *)_user;

@end
