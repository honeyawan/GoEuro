//
//  GEItenaryTableViewCell.h
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GEItenaryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *providerLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblArrivalDepartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberOfStops;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;

@end
