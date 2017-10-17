//
//  ViewController.m
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "TravelOptionsViewController.h"
#import "GETravelOptionsViewModel.h"
#import "GETravelModeViewModel.h"
#import "GEItenaryTableViewCell.h"
#import "GEItenaryModeCollectionCell.h"
#import "GESortOptionViewModel.h"

@interface TravelOptionsViewController ()

@property (nonatomic,strong)GETravelOptionsViewModel* itenaryViewModel;
@property (nonatomic,strong)GETravelModeViewModel* modeViewModel;
@property (nonatomic,strong)GESortOptionViewModel* sortViewModel;

@end

@implementation TravelOptionsViewController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:true];
    self.itenaryViewModel = [[GETravelOptionsViewModel alloc] init];
    self.modeViewModel = [[GETravelModeViewModel alloc] init];
    self.sortViewModel = [[GESortOptionViewModel alloc] init];
    
    [self.itenaryViewModel addObserver:self forKeyPath:@"itenaries" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld  context:nil];
    
    [self fetchItenaries];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    if ([keyPath isEqualToString:@"itenaries"]) {
        [self.itenaryTableView reloadData];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PrivateMethods

-(void)fetchItenaries {
    
    [self.spinner startAnimating];
    __weak TravelOptionsViewController *weakSelf = self;
    [self.itenaryViewModel fetchItenariesWithURL:[self.modeViewModel selectedItenaryURl] sortOption:[self.sortViewModel getSelectedSortType] completionHandler:^(NSError * _Nullable error) {
        [weakSelf.spinner stopAnimating];
        if (error) {
            // Show Error Message
        }
        else {
//            [weakSelf.itenaryTableView reloadData];
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

-(void)showInfoMessage {
    self.view.userInteractionEnabled = false;
    [UIView animateWithDuration:0.5 animations:^{
        self.offerInfoMsgView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self hideInfoMessage];
    }];
}

-(void)hideInfoMessage {
    
    [UIView animateWithDuration:0.5 delay:0.75 options:UIViewAnimationOptionCurveLinear animations:^{
        self.offerInfoMsgView.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = true;

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
    [self showInfoMessage];
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
