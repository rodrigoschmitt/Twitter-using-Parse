//
//  TweetViewController.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/15/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "TweetViewController.h"
#import "Common.h"
#import "TweetManager.h"
#import "Util.h"
#import "User.h"

@interface TweetViewController () {
    NSInteger countNumber;
}

@end

@implementation TweetViewController

@synthesize delegate;

#pragma mark - Methods of UIButton (IBAction)

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tweetButtonPressed:(UIBarButtonItem *)sender
{
    if (countNumber >= 0 && countNumber < 140) {
        
        [self tweetMessage:self.txtMessage.text];
        
    }
    else {
        [self alertWithTitle:@"Over Limit" message:@"Your tweet is over 140 characters."];
    }
    
}

#pragma mark - Custom Methods

- (void)tweetMessage:(NSString *)message {
    
    TweetManager *tweetManager = [[TweetManager alloc] init];
    
    [tweetManager saveTweetWithMessage:message fromUser:[Util unarchiveObjectFromUserDefaultsWithKey:UD_USER_LOGGED] response:^(bool success) {
        
        if (success) {
            [self performSelectorOnMainThread:@selector(doneViewController) withObject:nil waitUntilDone:NO];
        } else {
            [self performSelectorOnMainThread:@selector(errorRequestLogin) withObject:nil waitUntilDone:NO];
        }
    }];
}

- (void)doneViewController {
    
    if ([self.delegate respondsToSelector:@selector(doneTweetViewController)])
        [self.delegate doneTweetViewController];
}

- (void)errorRequestLogin {
    [self alertWithTitle:@"Fail" message:@"Something is wrong, try later!"];
}

- (void)alertWithTitle:(NSString *)_alertTitle message:(NSString *)_alertMessage {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_alertTitle message:_alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Methods of UItextView (Delegate)

- (void)textViewDidChange:(UITextView *)textView {
    
    countNumber = 140 - self.txtMessage.text.length;
    
    self.lblCount.text = [NSString stringWithFormat:@"%li", (long)countNumber];
}

#pragma mark - Methods of This ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Compose";
    
    [self.txtMessage isFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
