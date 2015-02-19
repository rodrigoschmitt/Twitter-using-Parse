//
//  RegisterViewController.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"
#import "UserControl.h"

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
    
    UserControl *userControl = [[UserControl alloc] init];
    [userControl registerUser:user profileImage:self.imgProfile.image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)profileImageButtonPressed:(UIButton *)sender {
    UIActionSheet *actionButtonActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                         delegate:self
                                                                cancelButtonTitle:@"Cancel"
                                                           destructiveButtonTitle:nil
                                                                otherButtonTitles:@"Take photo", @"Choose existing", nil];
    [actionButtonActionSheet showInView:self.view];
}

#pragma mark - Methods for Profile Image

- (void)takePhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)chooseExistingPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - Methods for Show or Hidden Keyboard

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

#pragma mark - Methods of UIImagePickerController (Delegate)

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imgProfile.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - UIActionSheet (Delegate)

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self takePhoto];
    }
    else if (buttonIndex == 1) {
        [self chooseExistingPhoto];
    }
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
    
    self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.width / 2;
    self.imgProfile.clipsToBounds = YES;
    self.imgProfile.layer.borderWidth = 3.0f;
    self.imgProfile.layer.borderColor = [UIColor grayColor].CGColor;

    
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
