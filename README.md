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

LICENSE
--------------

The MIT License (MIT)

Copyright (c) 2015 Rodrigo Schmitt

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


