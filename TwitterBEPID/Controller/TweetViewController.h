//
//  TweetViewController.h
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/15/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *txtMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)tweetButtonPressed:(UIBarButtonItem *)sender;

@end
