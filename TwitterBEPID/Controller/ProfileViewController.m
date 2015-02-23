//
//  ProfileViewController.m
//  TwitterParse
//
//  Created by Rodrigo Andrade on 2/16/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "ProfileViewController.h"
#import "TimelineViewController.h"
#import "Common.h"
#import "Util.h"

@interface ProfileViewController () {
    TimelineViewController *controller;
}

@end

@implementation ProfileViewController

#pragma mark - Methods of UIButton (IBAction)

- (IBAction)logoutButtonPressed:(UIButton *)sender {
    [Util removeUserDefaultsWithKey:UD_USER_LOGGED];
    
    self.user = nil;
    
    self.tabBarController.selectedIndex = 0;
}

#pragma mark - Custom Methods

- (void)loadProfile {
    
    if ([self.parentViewController.title isEqualToString:@"Users"]) {
        [self.btnMessage setHidden:NO];
        [self.btnFollow setHidden:NO];
        [self.btnLogout setHidden:YES];
    } else {
        self.user = [Util unarchiveObjectFromUserDefaultsWithKey:UD_USER_LOGGED];
        
        [self.btnMessage setHidden:YES];
        [self.btnFollow setHidden:YES];
        [self.btnLogout setHidden:NO];
        
        [self.navigationController.toolbar setNeedsDisplay];
    }
    
    self.title = self.user.username;
    
    [Util circularProfile:self.imgProfile];
    
    if (self.user.profileImage)
        self.imgProfile.imageURL = [NSURL URLWithString:self.user.profileImage];
    
    self.lblFullName.text = self.user.fullName;
    self.lblDescription.text = self.user.about;
    self.lblLocation.text = self.user.location;
}

#pragma mark - Methods of This ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadProfile];
    
    controller.profileViewController = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Profile";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    controller = (TimelineViewController *)segue.destinationViewController;
    controller.profileViewController = YES;
    
    if (!self.user)
        controller.user = [Util unarchiveObjectFromUserDefaultsWithKey:UD_USER_LOGGED];
    else
        controller.user = self.user;
}

@end
