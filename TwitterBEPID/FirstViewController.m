//
//  FirstViewController.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "FirstViewController.h"
#import "UserManager.h"
#import "User.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![[UserManager singleton] loadLocalUserLogged])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        User *user = [[UserManager singleton] loadLocalUserLogged];
        NSLog(@"Full Name: %@", user.fullName);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
