//
//  RegisterUser.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "User.h"
#import <Parse/Parse.h>

@implementation User

- (void)registerUser {
    
    PFObject *registerUserObj = [PFObject objectWithClassName:@"User"];
    registerUserObj[@"userName"] = self.username;
    registerUserObj[@"fullName"] = self.fullName;
    registerUserObj[@"email"] = self.email;
    registerUserObj[@"description"] = self.about;
    registerUserObj[@"location"] = self.location;
    registerUserObj[@"url"] = self.url;
    registerUserObj[@"password"] = self.password;
    
    [registerUserObj saveInBackground];
    
}

@end
