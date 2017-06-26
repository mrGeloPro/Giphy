//
//  GiphyCollectionViewLayout.h
//  Giphy
//
//  Created by Oleg Halasa on 26.06.17.
//  Copyright © 2017 Oleh Hulovatyi. All rights reserved.
//

#import "BaseCollectionViewLayout.h"

@protocol HeightLayoutDelegate <NSObject>
-(float)getHeightFromIndexPath:(NSIndexPath *)indexPAth;

@end

@interface GiphyCollectionViewLayout : BaseCollectionViewLayout

@property(weak)id<HeightLayoutDelegate> delegate;

@end
