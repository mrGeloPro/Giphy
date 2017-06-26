//
//  DetailViewController.h
//  Giphy
//
//  Created by Oleg Halasa on 26.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "Giphy.h"

@interface DetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *giphyImageView;
@property (weak, nonatomic) IBOutlet UITableView *descriptionTableView;
@property (strong, nonatomic) Giphy *giphy;

@end
