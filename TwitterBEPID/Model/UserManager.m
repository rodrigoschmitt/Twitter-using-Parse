//
//  UserManager.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "UserManager.h"
#import <Parse/Parse.h>
#import "User.h"

@implementation UserManager

- (void)registerUser:(User *)_user {
    
    PFObject *registerUserObj = [PFObject objectWithClassName:@"User"];
    registerUserObj[@"userName"] = _user.username;
    registerUserObj[@"fullName"] = _user.fullName;
    registerUserObj[@"email"] = _user.email;
    registerUserObj[@"description"] = _user.about;
    registerUserObj[@"location"] = _user.location;
    registerUserObj[@"url"] = _user.url;
    registerUserObj[@"password"] = _user.password;
    
    [registerUserObj saveInBackground];
    
}

@end
