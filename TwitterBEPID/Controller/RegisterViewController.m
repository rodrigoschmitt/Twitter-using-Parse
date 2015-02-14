//
//  RegisterViewController.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

#pragma mark - Methods of UIButton (IBAction)

- (IBAction)finishButtonPressed:(UIButton *)sender {
    
    PFObject *registerUser = [PFObject objectWithClassName:@"User"];
    registerUser[@"userName"] = @"rodrigoandrade";
    registerUser[@"fullName"] = @"Rodrigo S Andrade";
    registerUser[@"email"] = @"rodrigo.andrade@me.com";
    registerUser[@"description"] = @"Aluno no BEPiD";
    registerUser[@"location"] = @"Porto Alegre/RS";
    registerUser[@"url"] = @"http://www.devmac.com.br";
    [registerUser saveInBackground];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Methods of this ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
