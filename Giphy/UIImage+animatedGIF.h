//
//  UIImage+animatedGIF.h
//  Giphy
//
//  Created by Oleg Halasa on 25.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (animatedGIF)

+ (UIImage * _Nullable)animatedImageWithAnimatedGIFData:(NSData * _Nonnull)theData;
+ (UIImage * _Nullable)animatedImageWithAnimatedGIFURL:(NSURL * _Nonnull)theURL;

@end
