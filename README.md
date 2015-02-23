Introduction
------------

<b>Sample code for implementation examples like Twitter features using Parse.</b>

Features: <br>
* Register
* Follow
* Tweets (Post's)
* Favorites
* Messages
 
This project uses this object library
------------

- Multiple Storyboards
- Circular Profile Picture
- Camera App Using UIImagePickerController
- UICollectionViews
- UITableView
- Container View


Installation
------------

First you need create a new App on Parse.com and create this tables below:

<b>Tweets</b> (Custom class)<br>
fromUser (Pointer\<_User\>)<br>
message (string)<br>

<b>Favorite</b><br>
Tweet (Pointer\<Tweets\>)<br>
fromUser (Pointer\<_User\>)<br>

<b>User</b> (User class)<br>
fullname (String)<br>
location (String)<br>
profileImage (File)<br>
description (String)<br>
url (String)<br>
coverImage (File)<br>

Xcode Setup
------------

You need change ApplicationId and ClientKey with your own keys. Open up your AppDelegate.m and add the following to it:

\- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
 
    // Initialize Parse.
    [Parse setApplicationId:@"<b>YourApplicationId</b>"
                  clientKey:@"<b>YourClientKey</b>"];
 
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
 
    // ...
}

More information: https://www.parse.com/docs/ios_guide#top/iOS


