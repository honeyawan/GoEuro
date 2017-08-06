//
//  GEItenaryViewModel.m
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "GESortOptionViewModel.h"
#import "GEItenaryStore.h"
#import "GESortOption.h"
#import "GEItenaryModeCollectionCell.h"
@interface GESortOptionViewModel ()

@property (nonatomic,strong) NSArray *sortOptions;
@property (nonatomic,strong) GESortOption *selectionOption;


@end

@implementation GESortOptionViewModel


-(id)init {    
    self = [super init];
    self.sortOptions = [[GEItenaryStore sharedInstance] getSortOptions];
    self.selectionOption = self.sortOptions.count > 0 ? [self.sortOptions firstObject] : nil;
    return self;
}

- (NSUInteger)numberOfItemsInSection:(NSInteger)section {
    return self.sortOptions.count;
}

- (CGSize)itemsizeForCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    return  self.sortOptions.count> 0 ? CGSizeMake(collectionView.frame.size.width/self.sortOptions.count, collectionView.frame.size.height) : CGSizeZero;
}

-(void)configureCell:(GEItenaryModeCollectionCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    GESortOption *option = [self sortOptionForIndexPath:indexPath];
    cell.lblTitle.text = option.title;
    cell.selectionIndicatorView.hidden = (option != self.selectionOption);
 }


-(void)didSelectSortforIndexPath:(NSIndexPath *)indexPath {
    GESortOption *option = [self sortOptionForIndexPath:indexPath];
    self.selectionOption = option;
}

-(GESortOption *)sortOptionForIndexPath :(NSIndexPath *)indexPath {
    return self.sortOptions[indexPath.row];
}

-(int)getSelectedSortType {
    return self.selectionOption.type;
}



@end
