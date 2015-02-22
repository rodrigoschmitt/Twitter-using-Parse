//
//  Util.h
//  TwitterParse
//
//  Created by Rodrigo Andrade on 2/16/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncImageView.h"

@interface Util : NSObject

+ (void)removeUserDefaultsWithKey:(NSString *)key;
+ (void)archiveAndSaveObject:(id)object toUserDefaultsWithKey:(NSString *)key;
+ (id)unarchiveObjectFromUserDefaultsWithKey:(NSString *)key;
+ (void)circularProfile:(AsyncImageView *)imgPrile;

@end
