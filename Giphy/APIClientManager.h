//
//  APIClientManager.h
//  Giphy
//
//  Created by Oleg Halasa on 24.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "UIImage+animatedGIF.h"

@interface APIClientManager : NSObject

@property(nonatomic)AFHTTPSessionManager *manager;
+(APIClientManager *)sharedManager;
-(NSURLSessionDataTask *)getSearch:(NSString *)searchText withOffset:(NSInteger)offset count:(NSInteger)count onSuccess:(void(^)(NSArray *responseArray))success onFailure:(void(^)(NSError * error, NSInteger statusCode))failure;
- (void)loadAnimatedImageWithURL:(NSURL *const)url completion:(void (^)(UIImage *animatedImage))completion;
@end
