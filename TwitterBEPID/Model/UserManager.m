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

- (void)loginUser:(User *)_user {
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"userName" equalTo:_user.username];
    [query whereKey:@"password" equalTo:_user.password];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved the object.");
            
            _user.fullName = [object objectForKey:@"fullName"];
            _user.email = [object objectForKey:@"email"];
            _user.about = [object objectForKey:@"description"];
            _user.location = [object objectForKey:@"location"];
            _user.url = [object objectForKey:@"url"];
            
            NSLog(@"User content: %@", _user);
        }
    }];
    
}

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
