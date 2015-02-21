//
//  TweetManager.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/17/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "TweetControl.h"
#import "Common.h"
#import <Parse/Parse.h>
#import "Tweet.h"

@implementation TweetControl

- (void)saveTweetWithMessage:(NSString *)message fromUser:(User *)user response:(void (^)(bool success))response {
    
    PFObject *tweetObject = [PFObject objectWithClassName:@"Tweets"];
    [tweetObject setObject:message forKey:@"message"];
    [tweetObject setObject:[PFUser objectWithoutDataWithObjectId:user.idUser] forKey:@"fromUser"];
    
    [tweetObject saveInBackgroundWithBlock:^(BOOL Succeed, NSError *error) {
        
        if (!Succeed) {
            NSLog(@"Error message: %@", error.description);
            
            response(NO);
        } else {
            response(YES);
        }
    }];
}

- (void)requestTweets:(void (^)(NSArray *tweets, NSError *error))response fromUser:(User *)fromUser {
    
    // --- Retorno dos Tweets de quem estou seguindo
    
    /*NSArray *names = @[@"rodrigoandrade",
                       @"douglasmachado",
                       @"laurafranco"];
    
    
    PFQuery *innerQuery = [PFQuery queryWithClassName:@"User"];
    [innerQuery whereKey:@"userName"  containedIn:names];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tweet"];
    [query whereKey:@"user" matchesQuery:innerQuery];*/
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tweets"];
    
    if (fromUser)
        [query whereKey:@"fromUser" equalTo:[PFUser objectWithoutDataWithObjectId:fromUser.idUser]];
    
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"fromUser"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *resultsTweets, NSError *error) {
        
        if (!resultsTweets) {
            response(nil, error);
        }
        else {
            NSMutableArray *tweets = [[NSMutableArray alloc] init];
            
            for (PFObject *resultTweet in resultsTweets)
            {
                Tweet *tweet = [[Tweet alloc] init];
                tweet.idTweet = resultTweet.objectId;
                tweet.message = [resultTweet objectForKey:@"message"];
                
                PFUser *pfUser = resultTweet[@"fromUser"];
                
                User *user = [[User alloc] init];
                user.idUser = pfUser.objectId;
                user.username = pfUser.username;
                user.email = pfUser.email;
                user.fullName = [pfUser objectForKey:@"fullName"];
                user.about = [pfUser objectForKey:@"description"];
                user.location = [pfUser objectForKey:@"location"];
                user.url = [pfUser objectForKey:@"url"];
                
                if ([pfUser objectForKey:@"profileImage"])
                {
                    PFFile *pfFile = [pfUser objectForKey:@"profileImage"];
                    user.profileImage = pfFile.url;
                }
                
                tweet.user = user;
                
                [tweets addObject:tweet];
                
            }
            
            response(tweets, nil);
        }
    }];
    
}

@end
