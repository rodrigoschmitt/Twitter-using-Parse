//
//  RegisterUser.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "RegisterUser.h"
#import <Parse/Parse.h>

@implementation RegisterUser

- (void)saveInBackground {
    PFObject *registerUser = [PFObject objectWithClassName:@"User"];
    registerUser[@"userName"] = self.username;
    registerUser[@"fullName"] = self.fullName;
    registerUser[@"email"] = self.email;
    registerUser[@"description"] = self.about;
    registerUser[@"location"] = self.location;
    registerUser[@"url"] = self.url;
    registerUser[@"password"] = self.password;
    
    [registerUser saveInBackground];
}

@end
