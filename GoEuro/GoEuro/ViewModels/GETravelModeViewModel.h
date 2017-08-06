//
//  GEItenaryViewModel.h
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GEItenaryModeCollectionCell;
@class GEItenaryMode;

@interface GETravelModeViewModel : NSObject
-(void)configureCell:(GEItenaryModeCollectionCell *)cell
        forIndexPath:(NSIndexPath *)indexPath;
- (NSUInteger)numberOfItemsInSection:(NSInteger)section;
- (CGSize)itemsizeForCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
-(NSString *)selectedItenaryURl;
-(void)didSelectModeforIndexPath:(NSIndexPath *)indexPath;


@end
