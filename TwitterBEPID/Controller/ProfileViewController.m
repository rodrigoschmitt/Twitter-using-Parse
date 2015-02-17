//
//  ProfileViewController.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/16/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "ProfileViewController.h"
#import "Util.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.user.username;
    
    [Util circularProfile:self.imgProfile];
    
    if (self.user.profileImage)
        self.imgProfile.imageURL = [NSURL URLWithString:self.user.profileImage];
    
    self.lblFullName.text = self.user.fullName;
    self.lblDescription.text = self.user.about;
    self.lblLocation.text = self.user.location;
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
