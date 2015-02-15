//
//  RegisterViewController.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"
#import "UserManager.h"

#define kOFFSET_FOR_KEYBOARD 200.0

@interface RegisterViewController ()

@property UITextField *activeField;

@end

@implementation RegisterViewController

#pragma mark - Methods of UIButton (IBAction)

- (IBAction)nextButtonPressed:(UIButton *)sender {
    
    UIView *subView = [_scrollView viewWithTag:sender.tag + 1];
    
    if ([subView isKindOfClass:[UITextField class]])
    {
        [subView becomeFirstResponder];
    }
}

- (IBAction)finishButtonPressed:(UIButton *)sender {
    
    User *user = [[User alloc] init];
    user.username = self.txtUserName.text;
    user.fullName = self.txtFullName.text;
    user.email = self.txtEmail.text;
    user.about = self.txtAbout.text;
    user.location = self.txtLocation.text;
    user.url = self.txtUrl.text;
    user.password = self.txtPassword.text;
    
    UserManager *userManager = [[UserManager alloc] init];
    [userManager registerUser:user];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Custom Methods

- (void)keyboardWasShown {
   [_scrollView setContentOffset:CGPointMake(0.0, _activeField.frame.origin.y - kOFFSET_FOR_KEYBOARD) animated:YES];
}

- (void)keyboardWillBeHidden
{
    [_scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}

- (void)resignOnTap:(id)iSender {
    [_activeField resignFirstResponder];
    
    [self keyboardWillBeHidden];
}

#pragma mark - UITextField (Delegate)

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _activeField = textField;
    
    [self keyboardWasShown];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _activeField = nil;
}

#pragma mark - Methods of this ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
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
