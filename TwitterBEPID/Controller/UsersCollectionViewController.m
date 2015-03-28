//
//  UsersCollectionViewController.m
//  TwitterParse
//
//  Created by Rodrigo Andrade on 2/16/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "UsersCollectionViewController.h"
#import "Common.h"
#import "Util.h"
#import "UserManager.h"
#import "User.h"
#import "UserCollectionViewCell.h"
#import "ProfileViewController.h"

@interface UsersCollectionViewController () {
    NSArray *arrayUsers;
    NSInteger cellAtIndex;
}

@end

@implementation UsersCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - Custom Methods

- (void)loadData {
    
    User *user = [Util unarchiveObjectFromUserDefaultsWithKey:UD_USER_LOGGED];
    
    [[UserManager singleton] requestUsers:^(NSArray *users, NSError *error) {
        
        if (users) {
            arrayUsers = users;
            [self performSelectorOnMainThread:@selector(updateDataWithUsers) withObject:nil waitUntilDone:NO];
        }
        
    } userExcluded:user];
    
}

- (void)updateDataWithUsers {
    
    [self.collectionView reloadData];
    
}

#pragma mark - Methods of this ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Users";
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ProfileViewController *controller = (ProfileViewController *)segue.destinationViewController;
    controller.user = [arrayUsers objectAtIndex:cellAtIndex];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [arrayUsers count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UserCollectionViewCell * userCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"UserCell"
                                                                           forIndexPath:indexPath];
    [userCell configCell];
    
    User *user = [arrayUsers objectAtIndex:indexPath.row];
    
    if (user.profileImage)
        userCell.imgProfile.imageURL = [NSURL URLWithString:user.profileImage];
    
    userCell.lblUsername.text = user.username;

    return userCell;
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    cellAtIndex = indexPath.row;
    
    return YES;
    
}

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
