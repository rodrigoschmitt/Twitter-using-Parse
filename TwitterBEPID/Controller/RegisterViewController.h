//
//  RegisterViewController.h
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtFullName;
@property (weak, nonatomic) IBOutlet UITextField *txtLocation;
@property (weak, nonatomic) IBOutlet UITextField *txtAbout;
@property (weak, nonatomic) IBOutlet UITextField *txtUrl;

- (IBAction)nextButtonPressed:(UIButton *)sender;
- (IBAction)finishButtonPressed:(UIButton *)sender;


@end
