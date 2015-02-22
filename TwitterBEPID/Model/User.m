//
//  RegisterUser.m
//  TwitterParse
//
//  Created by Rodrigo Andrade on 2/14/15.
//  Copyright (c) 2015 DevMac. All rights reserved.
//

#import "User.h"

@implementation User

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.idUser forKey:@"idUser"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.fullName forKey:@"fullName"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.about forKey:@"about"];
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.password forKey:@"password"];
    [encoder encodeObject:self.profileImage forKey:@"profileImage"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        self.idUser = [decoder decodeObjectForKey:@"idUser"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.fullName = [decoder decodeObjectForKey:@"fullName"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.about = [decoder decodeObjectForKey:@"about"];
        self.location = [decoder decodeObjectForKey:@"location"];
        self.url = [decoder decodeObjectForKey:@"url"];
        self.password = [decoder decodeObjectForKey:@"password"];
        self.profileImage = [decoder decodeObjectForKey:@"profileImage"];
    }
    return self;
}


@end
