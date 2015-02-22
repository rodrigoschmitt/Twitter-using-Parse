//
//  TweetViewController.h
//  TwitterParse
//
//  Created by Rodrigo Andrade on 2/15/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TweetViewControllerDelegate;

@interface TweetViewController : UIViewController <UITextViewDelegate> {
    id <TweetViewControllerDelegate> __unsafe_unretained delegate;
}

@property (unsafe_unretained) id <TweetViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *txtMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)tweetButtonPressed:(UIBarButtonItem *)sender;

@end

@protocol TweetViewControllerDelegate <NSObject>

@optional

- (void)doneTweetViewController;

@end
