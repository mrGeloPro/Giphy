//
//  SearchGiphyViewController.h
//  Giphy
//
//  Created by Oleg Halasa on 24.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "GiphyCollectionViewLayout.h"

@interface SearchGiphyViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end
