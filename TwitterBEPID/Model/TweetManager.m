//
//  TweetManager.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/17/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "TweetManager.h"
#import "Common.h"
#import <Parse/Parse.h>

@implementation TweetManager

- (void)saveTweetWithMessage:(NSString *)message fromUser:(User *)user response:(void (^)(bool success))response {

    PFObject *userObject = [PFObject objectWithoutDataWithClassName:@"User" objectId:user.idUser];
    
    PFObject *tweetObject = [PFObject objectWithClassName:@"Tweet"];
    [tweetObject setObject:message forKey:@"message"];
    
    PFRelation *relation = [tweetObject relationForKey:@"user"];
    [relation addObject:userObject];
    
    [tweetObject saveInBackgroundWithBlock:^(BOOL Succeed, NSError *error) {
        
        if (!Succeed) {
            NSLog(@"Error message: %@", error.description);
            
            response(NO);
        } else {
            
            NSLog(@"Salvo!");
            
            response(YES);
        }
    }];
    
}

@end
