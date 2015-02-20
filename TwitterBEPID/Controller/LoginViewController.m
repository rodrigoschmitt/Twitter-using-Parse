//
//  LoginViewController.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "LoginViewController.h"
#import "Common.h"
#import "Util.h"
#import "UserControl.h"
#import "User.h"

#define kOFFSET_FOR_KEYBOARD 200.0

@interface LoginViewController ()

@property UITextField *activeField;

@end

@implementation LoginViewController

#pragma mark - Methods of UIButton (IBAction)

- (IBAction)nextButtonPressed:(UIButton *)sender {
    [self.txtPassword becomeFirstResponder];
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    [self loginUser];
}

#pragma mark - Methods Login user

- (void)loginUser {
    User *user = [[User alloc] init];
    user.username = self.txtUsername.text;
    user.password = self.txtPassword.text;
    
    [[UserControl singleton] loginUser:user response:^(bool success) {
        
        if (success) {
            // Save User Object in NSUserDefaults
            [Util archiveAndSaveObject:user toUserDefaultsWithKey:UD_USER_LOGGED];
            
            [self performSelectorOnMainThread:@selector(successfulLogin) withObject:nil waitUntilDone:NO];
            
        } else {
            
            [self performSelectorOnMainThread:@selector(errorRequestLogin) withObject:nil waitUntilDone:NO];
            
        }
    }];
}

- (void)successfulLogin {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)errorRequestLogin {
    
    [self alertWithTitle:@"Fail" message:@"Login or Password invalid!"];
    
}

- (void)alertWithTitle:(NSString *)_alertTitle message:(NSString *)_alertMessage {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_alertTitle
                                                    message:_alertMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
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
