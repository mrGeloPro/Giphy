//
//  DetailViewController.m
//  Giphy
//
//  Created by Oleg Halasa on 26.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import "DetailViewController.h"
#import "APIClientManager.h"
#import "UserTableViewCell.h"

@interface DetailViewController ()
@property (nonatomic)NSArray *titleArray;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArray = [NSArray arrayWithObjects:  @"Source", @"Tags", nil];
    
    _descriptionTableView.delegate =self;
    _descriptionTableView.dataSource = self;
   [[APIClientManager sharedManager]loadAnimatedImageWithURL:_giphy.image completion:^(UIImage *animatedImage) {
       _giphyImageView.image = animatedImage;
   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        UserTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
        if(_giphy.user.avatarUrl != nil){
        [[APIClientManager sharedManager]loadAnimatedImageWithURL:_giphy.user.avatarUrl completion:^(UIImage *animatedImage) {
           cell.avatarImageView.image = animatedImage;
        }];
        }else{
            cell.avatarImageView.image = [UIImage imageNamed:@"def_avatar"];
        }
        if(_giphy.user.userName != nil){
        cell.nameLabel.text = _giphy.user.userName;
        }else{
           cell.nameLabel.text = @"Name is missing";
        }
        return cell;
    }else{
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _titleArray[indexPath.row -1];
        if(indexPath.row == 1){
            if(![_giphy.source isEqualToString:@""]){
            cell.detailTextLabel.text = _giphy.source;
            }else{
              cell.detailTextLabel.text = @"None";
            }
        }else if (indexPath.row == 2){
            NSString * result = [_giphy.tags componentsJoinedByString:@""];
        if(_giphy.tags.count != 0){
            cell.detailTextLabel.text = result;
        }else{
            cell.detailTextLabel.text = @"None";
        }
        }
    return cell;
    }
 
}



@end
