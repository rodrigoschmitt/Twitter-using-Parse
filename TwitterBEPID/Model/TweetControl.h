//
//  TweetManager.h
//  TwitterParse
//
//  Created by Rodrigo Andrade on 2/17/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Tweet.h"

@interface TweetControl : NSObject

- (void)saveTweetWithMessage:(NSString *)message fromUser:(User *)user response:(void (^)(bool success))response;
- (void)favoriteThisTweet:(Tweet *)tweet fromUser:(User *)fromUser response:(void (^)(bool success))response;
- (void)requestTweets:(void (^)(NSArray *tweets, NSError *error))response fromUser:(User *)fromUser;

@end
