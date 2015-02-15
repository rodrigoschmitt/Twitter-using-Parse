//
//  LoginViewController.h
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)nextButtonPressed:(UIButton *)sender;
- (IBAction)loginButtonPressed:(UIButton *)sender;

@end
