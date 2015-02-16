//
//  Util.m
//  TwitterBEPID
//
//  Created by Rodrigo Andrade on 2/16/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "Util.h"

@implementation Util

#pragma mark - Archive Objects in NSUserDefaults

+ (void)archiveAndSaveObject:(id)object toUserDefaultsWithKey:(NSString *)key
{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:encodedObject forKey:key];
    [userDefaults synchronize];
}

+ (id)unarchiveObjectFromUserDefaultsWithKey:(NSString *)key
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    
    if (encodedObject != nil) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    } else {
        return nil;
    }
}

@end
