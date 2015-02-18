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
#import "Tweet.h"

@implementation TweetManager

- (void)saveTweetWithMessage:(NSString *)message fromUser:(User *)_user response:(void (^)(bool success))response {

    PFObject *tweetObject = [PFObject objectWithClassName:@"Tweet"];
    [tweetObject setObject:message forKey:@"message"];
    
    PFRelation *relation = [tweetObject relationForKey:@"user"];
    [relation addObject:[PFObject objectWithoutDataWithClassName:@"User" objectId:_user.idUser]];
    
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

- (void)requestTweets:(void (^)(NSArray *tweets, NSError *error))response fromUser:(User *)_user {
//    PFQuery *innerQuery = [PFQuery queryWithClassName:@"User"];
//    [innerQuery whereKey:@"userName" equalTo:_user.username];
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"Tweet"];
//    [query whereKey:@"user" matchesQuery:innerQuery];
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tweet"];
//    [query selectKeys:@[@"User"]];
//    [query includeKey:@"User.userName"];
    [query orderByDescending:@"createdAt"];
    
    if (_user)
        [query whereKey:@"user" equalTo:[PFObject objectWithoutDataWithClassName:@"User" objectId:_user.idUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *resultsTweets, NSError *error) {
        
        if (!resultsTweets) {
            response(nil, error);
        }
        else {
            NSMutableArray *tweets = [[NSMutableArray alloc] init];
            
            for (PFObject *resultTweet in resultsTweets)
            {
                [resultTweet fetchIfNeeded];
                
                Tweet *tweet = [[Tweet alloc] init];
                tweet.idTweet = resultTweet.objectId;
                tweet.message = [resultTweet objectForKey:@"message"];
                
//                PFObject *xxUser = resultTweet[@"user"];
//                
//                [xxUser fetchIfNeededInBackgroundWithBlock:^(PFObject *post, NSError *error) {
//                    NSString *title = post[@"userName"];
//                    // do something with your title variable
//                }];
                
                
                PFRelation *relationUser = resultTweet[@"user"];
                [[relationUser query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (error) {
                        // There was an error
                    } else {
                        // objects has all the Posts the current user liked.
                        NSLog(@"Aqui!");
                    }
                }];
                
                
                
                
                
                
                
//                PFRelation *relationUser = resultTweet[@"user"];
//                PFQuery *query = [relationUser query];
//                NSArray *array = [query findObjects];
//                
//                PFObject *objectUser = [array objectAtIndex:0];
//                
//                NSLog(@"UserName: %@", [[array objectAtIndex:0] objectForKey:@"userName"]);
//                
//                User *user = [[User alloc] init];
//                user.idUser = objectUser.objectId;
//                user.username = [objectUser objectForKey:@"userName"];
//                user.password = [objectUser objectForKey:@"password"];
//                user.fullName = [objectUser objectForKey:@"fullName"];
//                user.email = [objectUser objectForKey:@"email"];
//                user.about = [objectUser objectForKey:@"description"];
//                user.location = [objectUser objectForKey:@"location"];
//                user.url = [objectUser objectForKey:@"url"];
//                
//                if ([objectUser objectForKey:@"profileImage"])
//                {
//                    PFFile *pfFile = [objectUser objectForKey:@"profileImage"];
//                    user.profileImage = pfFile.url;
//                }
//                
//                tweet.user = user;
                
                [tweets addObject:tweet];
                
            }
            
            response(tweets, nil);
        }
    }];
    
}

@end
