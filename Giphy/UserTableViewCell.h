//
//  UserTableViewCell.h
//  Giphy
//
//  Created by Oleg Halasa on 26.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
