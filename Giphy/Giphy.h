//
//  Giphy.h
//  Giphy
//
//  Created by Oleg Halasa on 25.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserGiphy.h"

@interface Giphy : NSObject

@property(nonatomic)NSString *userName;
@property(nonatomic)NSArray *tags;
@property(nonatomic)NSArray *featuredTags;
@property(nonatomic)NSString *source;
@property(nonatomic)UserGiphy *user;
@property(nonatomic)NSURL *sourcePostUrl;
@property(nonatomic)NSURL *smallImage;
@property(nonatomic)NSURL *image;
@property(nonatomic)NSString *smallImageHeight;


-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
