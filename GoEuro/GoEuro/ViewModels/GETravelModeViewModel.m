//
//  GEItenaryViewModel.m
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "GETravelModeViewModel.h"
#import "GEItenaryStore.h"
#import "GETravelMode.h"
#import "GEItenaryModeCollectionCell.h"
@interface GETravelModeViewModel ()

@property (nonatomic,strong) NSArray *transportModes;
@property (nonatomic,strong) GETravelMode *selectedMode;


@end

@implementation GETravelModeViewModel

-(id)init {
    
    self = [super init];
    self.transportModes = [[GEItenaryStore sharedInstance] getTravelModes];
    self.selectedMode = self.transportModes.count > 0 ? [self.transportModes firstObject] : nil;    
    return self;
}

- (NSUInteger)numberOfItemsInSection:(NSInteger)section {
    return self.transportModes.count;
}

- (CGSize)itemsizeForCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    return  self.transportModes.count> 0 ? CGSizeMake(collectionView.frame.size.width/self.transportModes.count, collectionView.frame.size.height) : CGSizeZero;
}

-(void)configureCell:(GEItenaryModeCollectionCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    GETravelMode *mode = [self itenaryModeForIndexPath:indexPath];
    cell.lblTitle.text = mode.title;
    cell.selectionIndicatorView.hidden = (mode != self.selectedMode);
 }


-(void)didSelectModeforIndexPath:(NSIndexPath *)indexPath {
    GETravelMode *mode = [self itenaryModeForIndexPath:indexPath];
    self.selectedMode = mode;
}

-(GETravelMode *)itenaryModeForIndexPath :(NSIndexPath *)indexPath {
    return self.transportModes[indexPath.row];
}

-(NSString *)selectedItenaryURl {
    return self.selectedMode.itenaryURL;
}





@end
