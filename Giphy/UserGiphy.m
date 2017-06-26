//
//  UserGiphy.m
//  Giphy
//
//  Created by Oleg Halasa on 25.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import "UserGiphy.h"

@implementation UserGiphy

-(id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        if(dictionary != nil){
            self.avatarUrl =  dictionary[@"avatar_url"] != nil ? [NSURL URLWithString:dictionary[@"avatar_url"] ]: nil;
             self.profileUrl = dictionary[@"profile_url"] != nil ?[NSURL URLWithString:dictionary[@"profile_url"]]: nil;
             self.userName = dictionary[@"username"] != nil ? dictionary[@"username"] : nil;
             self.displayName = dictionary[@"display_name"] != nil ? dictionary[@"display_name"] : nil;
             self.twitter = dictionary[@"twitter"] != nil ? dictionary[@"twitter"] : nil;
        }
    }
    
    return self;
}

@end
