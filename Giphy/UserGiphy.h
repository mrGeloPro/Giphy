//
//  UserGiphy.h
//  Giphy
//
//  Created by Oleg Halasa on 25.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserGiphy : NSObject

@property(nonatomic)NSURL * avatarUrl;
@property(nonatomic)NSURL *profileUrl;
@property(nonatomic)NSString *userName;
@property(nonatomic)NSString *displayName;
@property(nonatomic)NSString *twitter;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
