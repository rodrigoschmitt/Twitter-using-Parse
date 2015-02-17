//
//  TweetViewController.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/15/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController () {
    NSInteger countNumber;
}

@end

@implementation TweetViewController

#pragma mark - Methods of UIButton (IBAction)

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tweetButtonPressed:(UIBarButtonItem *)sender
{
    if (countNumber >= 0) {
        
    }
    else {
        [self alertWithTitle:@"Over Limit" message:@"Your tweet is over 140 characters."];
    }
    
}

#pragma mark - Custom Methods

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
