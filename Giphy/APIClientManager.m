//
//  APIClientManager.m
//  Giphy
//
//  Created by Oleg Halasa on 24.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import "APIClientManager.h"
#import "UIImage+animatedGIF.h"

static NSString * api_key = @"47b26f9cbbab4ce6b33d95ae95d799e5";

@implementation APIClientManager


+(APIClientManager *)sharedManager{
    static APIClientManager * manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[APIClientManager alloc]init];
    });
    
    return manager;
}
-(id)init{
   self = [super init];
    if(self){
        NSURL *url = [NSURL URLWithString:@"https://api.giphy.com/v1/gifs/"];
        _manager = [[AFHTTPSessionManager manager]initWithBaseURL:url];
    }
    return self;
}
#define EmptyIfNil(...) ((__VA_ARGS__) ? (__VA_ARGS__) : @"nil")
-(NSURLSessionDataTask *)getSearch:(NSString *)searchText withOffset:(NSInteger)offset count:(NSInteger)count onSuccess:(void(^)(NSArray *responseArray))success onFailure:(void(^)(NSError * error, NSInteger statusCode))failure{

    NSDictionary *parameters =@{@"q":EmptyIfNil(searchText),
                                @"api_key": EmptyIfNil(api_key),
                                @"offset": EmptyIfNil([NSString stringWithFormat:@"%ld",(long)offset]),
                                @"limit": EmptyIfNil([NSString stringWithFormat:@"%ld",(long)count]),};

    NSURLSessionDataTask * task = [_manager GET:@"search" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDictionary = responseObject;
        NSArray *responseObjectArray = responseDictionary[@"data"];
            if (success) {
                    success(responseObjectArray);
            }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        	NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (error) {
            failure(error , response.statusCode);
        }
    }];

    return task;
}

- (void)loadAnimatedImageWithURL:(NSURL *const)url completion:(void (^)(UIImage *animatedImage))completion
{
    NSString *const filename = [NSString stringWithFormat:@"%@", url];// url.pathExtension;
    NSString *const diskPath = [NSHomeDirectory() stringByAppendingPathComponent:filename];
    
    NSData * __block animatedImageData = [[NSFileManager defaultManager] contentsAtPath:diskPath];
    UIImage * __block animatedImage = [UIImage animatedImageWithAnimatedGIFData:animatedImageData];
    
    if (animatedImage) {
        if (completion) {
            completion(animatedImage);
        }
    } else {
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            animatedImageData = data;
            animatedImage = [UIImage animatedImageWithAnimatedGIFData: animatedImageData];
            if (animatedImage) {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(animatedImage);
                    });
                }
                [data writeToFile:diskPath atomically:YES];
            }
        }] resume];
    }
}


@end
