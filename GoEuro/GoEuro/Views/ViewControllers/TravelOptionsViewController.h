//
//  ViewController.h
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TravelOptionsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UITableView *itenaryTableView;
@property (weak, nonatomic) IBOutlet UIView *offerInfoMsgView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UICollectionView *transportationModeCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *sortOptionsCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *lblCityTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sortOptionVerticalOffset;

- (IBAction)onBTNSort:(id)sender;

@end

