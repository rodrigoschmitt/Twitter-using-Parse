//
//  TimelineViewController.h
//  TwitterParse
//
//  Created by Rodrigo Andrade on 2/15/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetViewController.h"
#import "User.h"

@interface TimelineViewController : UITableViewController <TweetViewControllerDelegate>

@property (strong) User *user;
@property BOOL profileViewController;

@end
