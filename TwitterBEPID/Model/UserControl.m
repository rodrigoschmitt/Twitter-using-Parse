//
//  UserManager.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "UserControl.h"
#import "Common.h"
#import <Parse/Parse.h>

@implementation UserControl

+ (UserControl *) singleton
{
    static UserControl *instance;
    
    if (instance == nil)
        instance = [[UserControl alloc] init];
    
    return instance;
}

#pragma Mark - API Parse for WebService

- (void)loginUser:(User *)_user response:(void (^)(bool success))response {
    
    PFQuery *userQuery = [PFQuery queryWithClassName:@"Users"];
    [userQuery whereKey:@"username" equalTo:_user.username];
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
    PFObject *registerUserObj = [PFObject objectWithClassName:@"Users"];
    registerUserObj[@"username"] = _user.username;
    registerUserObj[@"fullName"] = _user.fullName;
    registerUserObj[@"email"] = _user.email;
    registerUserObj[@"description"] = _user.about;
    registerUserObj[@"location"] = _user.location;
    registerUserObj[@"url"] = _user.url;
    registerUserObj[@"password"] = _user.password;
    
    if (profileImage)
    {
        NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.6);
        PFFile *imageFile = [PFFile fileWithName:[NSString stringWithFormat:@"%@.jpg", _user.username]
                                            data:imageData];
        registerUserObj[@"profileImage"] = imageFile;
    }
    
    
    [registerUserObj saveInBackground];
    
}

- (void)requestUsers:(void (^)(NSArray *users, NSError *error))response userExcluded:(User *)_user {
    
    PFQuery *usersQuery = [PFQuery queryWithClassName:@"Users"];
    [usersQuery orderByDescending:@"createdAt"];
    if (_user)
        [usersQuery whereKey:@"username" notEqualTo:_user.username];
    
    [usersQuery findObjectsInBackgroundWithBlock:^(NSArray *resultsUsers, NSError *error) {
        
        if (!resultsUsers) {
            response(nil, error);
        }
        else {
            NSMutableArray *users = [[NSMutableArray alloc] init];
            
            for (PFObject *resultUser in resultsUsers)
            {
                User *user = [[User alloc] init];
                user.idUser = resultUser.objectId;
                user.username = [resultUser objectForKey:@"username"];
                user.password = [resultUser objectForKey:@"password"];
                user.fullName = [resultUser objectForKey:@"fullName"];
                user.email = [resultUser objectForKey:@"email"];
                user.about = [resultUser objectForKey:@"description"];
                user.location = [resultUser objectForKey:@"location"];
                user.url = [resultUser objectForKey:@"url"];
                
                if ([resultUser objectForKey:@"profileImage"])
                {
                    PFFile *pfFile = [resultUser objectForKey:@"profileImage"];
                    user.profileImage = pfFile.url;
                }
                
                [users addObject:user];
            }
            
            response(users, nil);
        }
    }];
    
}

@end
