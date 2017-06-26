//
//  Giphy.m
//  Giphy
//
//  Created by Oleg Halasa on 25.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import "Giphy.h"

@implementation Giphy

-(id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        if(dictionary != nil){
        NSDictionary *giphy = dictionary;
        self.userName = giphy[@"username"] != nil ? giphy[@"username"] : nil;
        self.tags = giphy[@"tags"] != nil ? giphy[@"tags"] : nil;
        self.featuredTags = giphy[@"featured_tags"] != nil ? giphy[@"featured_tags"] : nil;
        self.source = giphy[@"source_tld"] != nil ? giphy[@"source_tld"] : nil;
        self.sourcePostUrl = giphy[@"source_post_url"] != nil ? [NSURL URLWithString:giphy[@"source_post_url"]] : nil;
        
        self.user = [[UserGiphy alloc]initWithDictionary:giphy[@"user"]];
        
        NSDictionary *images = giphy[@"images"] != nil ? giphy[@"images"] : nil;
        if(images != nil){
            
            NSDictionary * fixedWidthSmall = images[@"fixed_width_small"] != nil ? images[@"fixed_width_small"] : nil;
            if(fixedWidthSmall != nil){
                self.smallImage = fixedWidthSmall[@"url"] != nil ? [NSURL URLWithString:fixedWidthSmall[@"url"]]: nil;
                self.smallImageHeight = fixedWidthSmall[@"height"] != nil ? [NSString stringWithFormat:@"%@",fixedWidthSmall[@"height"] ]: nil;
            }
            NSDictionary * fixedWidth = images[@"fixed_width"] != nil ? images[@"fixed_width"] : nil;
            if(fixedWidth != nil){
                self.image = fixedWidth[@"url"] != nil ? [NSURL URLWithString:fixedWidth[@"url"]]: nil;
            }
            
        }
      }
    }
    
    return self;
}

@end
