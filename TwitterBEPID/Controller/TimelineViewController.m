//
//  TimelineViewController.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/15/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "TimelineViewController.h"
#import "TweetViewController.h"
#import "TimelineTableViewCell.h"
#import "Common.h"
#import "Util.h"
#import "User.h"
#import "TweetControl.h"
#import "Tweet.h"

@interface TimelineViewController () {
    NSArray *arrayTweets;
}

@end

@implementation TimelineViewController

#pragma mark - Custom Methods

- (void)loadData:(UIRefreshControl *)refreshControl {
    
    TweetControl *tweetControl = [[TweetControl alloc] init];
    
    [tweetControl requestTweets:^(NSArray *tweets, NSError *error) {
        
        arrayTweets = tweets;
        [self performSelectorOnMainThread:@selector(updateDataWithTweets) withObject:nil waitUntilDone:NO];
        
    } fromUser:self.user];
    
    if (refreshControl)
        [refreshControl endRefreshing];
}

- (void)favoriteThisTweet:(Tweet *)tweet {
    
    TweetControl *tweetControl = [[TweetControl alloc] init];
    
    [tweetControl favoriteThisTweet:[arrayTweets objectAtIndex:0] fromUser:[Util unarchiveObjectFromUserDefaultsWithKey:UD_USER_LOGGED] response:^(bool success) {
        
        if (success)
        {
            NSLog(@"Salvo com sucesso!");
        }
    }];
    
}

- (void)updateDataWithTweets {
    
    [self.tableView reloadData];
    
//    [self favoriteThisTweet:nil];
    
}

#pragma mark - Methods of TweetViewController (Delegate)

- (void)doneTweetViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self loadData:nil];
}

#pragma mark - Methods of UIViewController

- (void)viewWillAppear:(BOOL)animated {
    
    if (![Util unarchiveObjectFromUserDefaultsWithKey:UD_USER_LOGGED])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self presentViewController:vc animated:YES completion:nil];
    }
//    else
//    {
//        User *user = [Util unarchiveObjectFromUserDefaultsWithKey:UD_USER_LOGGED];
//        NSLog(@"Full Name: %@", user.fullName);
//    }
//    
//    [self loadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Timeline";
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadData:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    [self loadData:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayTweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimelineTableViewCell * tweetCell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    [tweetCell configCell];
    
    Tweet *tweet = [arrayTweets objectAtIndex:indexPath.row];
    
    tweetCell.lblFullname.text = tweet.user.fullName;
    tweetCell.lblUsername.text = [NSString stringWithFormat:@"@%@", tweet.user.username];
    tweetCell.lblTweet.text = tweet.message;
    
    if (tweet.user.profileImage)
        tweetCell.imgProfile.imageURL = [NSURL URLWithString:tweet.user.profileImage];
    
    return tweetCell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueTweetViewController"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        TweetViewController *tweetViewController= (TweetViewController *)navigationController.topViewController;
        tweetViewController.delegate = self;
    }
}

@end
