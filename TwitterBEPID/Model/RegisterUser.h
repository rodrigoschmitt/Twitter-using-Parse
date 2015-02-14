//
//  RegisterUser.h
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterUser : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *about;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *password;

- (void)saveInBackground;

@end
