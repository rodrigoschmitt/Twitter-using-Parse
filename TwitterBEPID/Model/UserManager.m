//
//  UserManager.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "UserManager.h"
#import "Common.h"
#import <Parse/Parse.h>

@implementation UserManager

+ (UserManager *) singleton
{
    static UserManager *instance;
    
    if (instance == nil)
        instance = [[UserManager alloc] init];
    
    return instance;
}

#pragma Mark - API Parse for WebService

- (void)loginUser:(User *)_user response:(void (^)(bool success))response {
    
    PFQuery *userQuery = [PFQuery queryWithClassName:@"User"];
    [userQuery whereKey:@"userName" equalTo:_user.username];
    [userQuery whereKey:@"password" equalTo:_user.password];
    
    [userQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        if (!object) {
            NSLog(@"Error message: %@", error.description);
            
            response(NO);
        } else {
            _user.idUser = object.objectId;
            _user.fullName = [object objectForKey:@"fullName"];
            _user.email = [object objectForKey:@"email"];
            _user.about = [object objectForKey:@"description"];
            _user.location = [object objectForKey:@"location"];
            _user.url = [object objectForKey:@"url"];
            
            if ([object objectForKey:@"profileImage"])
            {
                PFFile *pfFile = [object objectForKey:@"profileImage"];
                _user.profileImage = pfFile.url;
            }
            
            response(YES);
        }
        
    }];
    
}

- (void)registerUser:(User *)_user profileImage:(UIImage *)profileImage {
    
    PFObject *registerUserObj = [PFObject objectWithClassName:@"User"];
    registerUserObj[@"userName"] = _user.username;
    registerUserObj[@"fullName"] = _user.fullName;
    registerUserObj[@"email"] = _user.email;
    registerUserObj[@"description"] = _user.about;
    registerUserObj[@"location"] = _user.location;
    registerUserObj[@"url"] = _user.url;
    registerUserObj[@"password"] = _user.password;
    
    if (profileImage)
    {
        NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.6);
        PFFile *imageFile = [PFFile fileWithName:[NSString stringWithFormat:@"%@.jpg", _user.username] data:imageData];
        registerUserObj[@"profileImage"] = imageFile;
    }
    
    
    [registerUserObj saveInBackground];
    
}

- (void)requestUsers:(void (^)(NSArray *users, NSError *error))response userExcluded:(User *)_user {
    
    PFQuery *usersQuery = [PFQuery queryWithClassName:@"User"];
    [usersQuery orderByDescending:@"createdAt"];
    if (_user)
        [usersQuery whereKey:@"userName" notEqualTo:_user.username];
    
    [usersQuery findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        if (!results) {
            response(nil, error);
        }
        else {
            NSMutableArray *users = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < [results count]; i++) {
                
                PFObject *object = [results objectAtIndex:i];
                
                User *user = [[User alloc] init];
                user.idUser = object.objectId;
                user.username = [object objectForKey:@"userName"];
                user.password = [object objectForKey:@"password"];
                user.fullName = [object objectForKey:@"fullName"];
                user.email = [object objectForKey:@"email"];
                user.about = [object objectForKey:@"description"];
                user.location = [object objectForKey:@"location"];
                user.url = [object objectForKey:@"url"];
                
                if ([object objectForKey:@"profileImage"])
                {
                    PFFile *pfFile = [object objectForKey:@"profileImage"];
                    user.profileImage = pfFile.url;
                }
                
                [users addObject:user];
            }
            
            
            response(users, nil);
        }
    }];
    
}

@end
