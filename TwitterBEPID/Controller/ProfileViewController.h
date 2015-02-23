//
//  ProfileViewController.h
//  TwitterParse
//
//  Created by Rodrigo Andrade on 2/16/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "User.h"

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet AsyncImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblFullName;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnFollow;
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;
@property (weak, nonatomic) IBOutlet UIView *containerTimeline;

@property (strong) User *user;

- (IBAction)logoutButtonPressed:(UIButton *)sender;

@end
