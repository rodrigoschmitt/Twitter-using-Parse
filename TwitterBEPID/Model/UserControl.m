//
//  UserManager.m
//  TwitterParse
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

#pragma Mark - API Parse

- (void)signupUser:(User *)userSignup profileImage:(UIImage *)profileImage response:(void (^)(BOOL success, NSError *error))response {
    
    PFUser *user = [PFUser user];
    user.username = userSignup.username;
    user.password = userSignup.password;
    user.email = userSignup.email;
    user[@"fullName"] = userSignup.fullName;
    user[@"description"] = userSignup.about;
    user[@"location"] = userSignup.location;
    user[@"url"] = userSignup.url;
    
    if (profileImage)
    {
        NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.6);
        PFFile *imageFile = [PFFile fileWithName:[NSString stringWithFormat:@"%@.jpg", userSignup.username]
                                            data:imageData];
        user[@"profileImage"] = imageFile;
    }
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        response(succeeded, error);
        
    }];
    
}

- (void)loginUser:(User *)userLogin response:(void (^)(bool success))response {
   
    [PFUser logInWithUsernameInBackground:userLogin.username
                                 password:userLogin.password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            
                                            userLogin.idUser = user.objectId;
                                            userLogin.fullName = [user objectForKey:@"fullName"];
                                            userLogin.email = user.email;
                                            userLogin.about = [user objectForKey:@"description"];
                                            userLogin.location = [user objectForKey:@"location"];
                                            userLogin.url = [user objectForKey:@"url"];
                                            
                                            if ([user objectForKey:@"profileImage"])
                                            {
                                                PFFile *pfFile = [user objectForKey:@"profileImage"];
                                                userLogin.profileImage = pfFile.url;
                                            }
                                            
                                            response(YES);
                                            
                                        } else {
                                            NSLog(@"Error message: %@", error.description);
                                            
                                            response(NO);
                                        }
                                    }];
    
}

- (void)requestUsers:(void (^)(NSArray *users, NSError *error))response userExcluded:(User *)_user {
    PFQuery *usersQuery = [PFUser query];
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
