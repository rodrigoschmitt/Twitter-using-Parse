<b>Sample code for implementation examples of Twitter features using Parse.</b>

Features:
* Register
* Follow
* Tweets (Post's)
* Favorites
* Messages

<b>Installation</b>

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

You need change ApplicationId and ClientKey with your own keys. Open up your AppDelegate.m and add the following to it:

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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


