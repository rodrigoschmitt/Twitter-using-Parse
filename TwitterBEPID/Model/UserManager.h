//
//  UserManager.h
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface UserManager : NSObject

- (void)registerUser:(User *)_user;

@end
