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

#pragma mark - Save local

- (void)saveLocalUserLogged:(User *)user {
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:user];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:encodedObject forKey:UD_USER_LOGGED];
    [userDefaults synchronize];
    
}

- (User *)loadLocalUserLogged {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:UD_USER_LOGGED];
    
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    return user;
    
}

#pragma Mark - API Parse for WebService

- (void)loginUser:(User *)_user response:(void (^)(bool success))response {
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"userName" equalTo:_user.username];
    [query whereKey:@"password" equalTo:_user.password];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        if (!object) {
            NSLog(@"Error message: %@", error.description);
            
            response(NO);
        } else {
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

@end
