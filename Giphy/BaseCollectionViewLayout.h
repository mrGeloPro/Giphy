//
//  BaseCollectionViewLayout.h
//  Giphy
//
//  Created by Oleg Halasa on 26.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, readonly) NSInteger totalItemsInSection;
@property (nonatomic, readonly) UIEdgeInsets contentInsets;

@property (nonatomic, assign) NSInteger totalColumns;
@property (nonatomic, assign) CGFloat interItemsSpacing;

//These methods should be overriden by inheritor
- (NSInteger)columnIndexForItemAtIndexPath:(NSIndexPath *)indexPath;
- (CGRect)calculateItemFrameAtIndexPath:(NSIndexPath *)indexPath columnIndex:(NSInteger)columnIndex columnYoffset:(CGFloat)columnYoffset;
- (void)calculateItemsSize;


@end
