//
//  ViewController.m
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "ViewController.h"
#import "GETravelOptionsViewModel.h"
#import "GETravelModeViewModel.h"
#import "GEItenaryTableViewCell.h"
#import "GEItenaryModeCollectionCell.h"
#import "GESortOptionViewModel.h"

@interface ViewController ()

@property (nonatomic,strong)GETravelOptionsViewModel* itenaryViewModel;
@property (nonatomic,strong)GETravelModeViewModel* modeViewModel;
@property (nonatomic,strong)GESortOptionViewModel* sortViewModel;

@end

@implementation ViewController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.itenaryViewModel = [[GETravelOptionsViewModel alloc] init];
    self.modeViewModel = [[GETravelModeViewModel alloc] init];
    self.sortViewModel = [[GESortOptionViewModel alloc] init];
    [self fetchItenaries];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PrivateMethods

-(void)fetchItenaries {
    
    
    [self.itenaryViewModel fetchItenariesWithURL:[self.modeViewModel selectedItenaryURl] sortOption:[self.sortViewModel getSelectedSortType] completionHandler:^(NSError * _Nullable error) {
        if (error) {
            // Show Error Message
        }
        else {
            [self.itenaryTableView reloadData];
        }
    }];
}

-(void)sortItenaries {
    [self.itenaryViewModel sortOptionsWithSortType:[self.sortViewModel getSelectedSortType]];
}


#pragma mark - IBAction

- (IBAction)onBTNSort:(id)sender {
    
    [UIView animateWithDuration:1.0 animations:^{
        self.sortOptionVerticalOffset.constant = self.sortOptionVerticalOffset.constant == 30 ? -10.0 : 30;
    }];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.itenaryViewModel numberOfRowsInSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GEItenaryTableViewCell *cell = (GEItenaryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    [self.itenaryViewModel configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;

}


#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.modeViewModel numberOfItemsInSection:section];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (collectionView == self.sortOptionsCollectionView) {
        
        GEItenaryModeCollectionCell *cell = (GEItenaryModeCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UISortOptionCellID" forIndexPath:indexPath];
        [self.sortViewModel configureCell:cell forIndexPath:indexPath];

        return cell;
        
    }
    else {
        GEItenaryModeCollectionCell *cell = (GEItenaryModeCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
        [self.modeViewModel configureCell:cell forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.sortOptionsCollectionView) {
        return [self.sortViewModel itemsizeForCollectionView:collectionView atIndexPath:indexPath];
    }
    else {
        return [self.modeViewModel itemsizeForCollectionView:collectionView atIndexPath:indexPath];
    }
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.sortOptionsCollectionView) {
        [self.sortViewModel didSelectSortforIndexPath:indexPath];
        [self sortItenaries];
        [self onBTNSort:nil];
    }
    else {
        [self.modeViewModel didSelectModeforIndexPath:indexPath];
        [self fetchItenaries];
    }
    
    [collectionView reloadData];
    [self.itenaryTableView reloadData];
    [self.itenaryTableView setContentOffset:CGPointZero animated:false];

}

@end
