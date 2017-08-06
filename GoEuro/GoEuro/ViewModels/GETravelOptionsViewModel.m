//
//  GEItenaryViewModel.m
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "GETravelOptionsViewModel.h"
#import "GEItenaryStore.h"
#import "GEItenaryTableViewCell.h"
#import "GETravelOptionMO+CoreDataClass.h"
#import <SDWebImage/UIImageView+WebCache.h>

typedef enum
{
    sortTypeDepartureTime = 0,
    sortTypeArrivalTime,
    sortTypeDuration
} sortType;

@interface GETravelOptionsViewModel ()

@property (nonatomic,strong) NSArray *itenaries;

@end

@implementation GETravelOptionsViewModel

-(id)init {    
    self = [super init];
    return self;
}

-(void)fetchItenariesWithURL:(NSString *)urlString
                  sortOption:(int)sortType
           completionHandler:(void (^) (NSError * _Nullable error))completion{
    
    self.itenaries = nil;
    __weak GETravelOptionsViewModel *weakSelf = self;
    [[GEItenaryStore sharedInstance] getItenariesWithURL:urlString completionHandler:^(NSArray *array, NSError * _Nullable error) {
        weakSelf.itenaries = array;
        [weakSelf sortOptionsWithSortType:sortType];
        completion(array.count > 0 ? nil : error);
    }];
}

-(void)sortOptionsWithSortType:(int)type {
    NSArray *sortedArray;
    
    switch (type) {
        
        case sortTypeArrivalTime:
            sortedArray = [self.itenaries sortedArrayUsingComparator:^NSComparisonResult(GETravelOptionMO* a, GETravelOptionMO* b) {
                return [a.arrivalTime compare:b.arrivalTime];
            }];
            break;

        case sortTypeDuration: {
                sortedArray = [self.itenaries sortedArrayUsingComparator:^NSComparisonResult(GETravelOptionMO* a, GETravelOptionMO* b) {
                    NSNumber* aDuration = [NSNumber numberWithInt:[self durationTimeWithArrival:a.arrivalTime departure:a.departureTime]];
                    NSNumber* bDuration = [NSNumber numberWithInt:[self durationTimeWithArrival:b.arrivalTime departure:b.departureTime]];
                    return [aDuration compare:bDuration];
                }];
        }
            break;
            
        default:
            sortedArray = [self.itenaries sortedArrayUsingComparator:^NSComparisonResult(GETravelOptionMO* a, GETravelOptionMO* b) {
                return [a.departureTime compare:b.departureTime];
            }];
            break;
            
    }

    self.itenaries = sortedArray;
}

- (NSUInteger)numberOfRowsInSection:(NSInteger)section {
    return self.itenaries.count;
}

-(void)configureCell:(GEItenaryTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    GETravelOptionMO *itenary = [self itenaryAtIndexPath:indexPath];
    cell.lblNumberOfStops.text = [self textForNumberOfStops:itenary.numberOfStops];
    cell.lblDuration.text = [self durationStringWithArrival:itenary.arrivalTime departure:itenary.departureTime];
    cell.lblArrivalDepartTime.text = [self getDepartureAndArrivalText:itenary.departureTime departure:itenary.arrivalTime];
    cell.lblPrice.text = [NSString stringWithFormat:@"€ %d",itenary.price];
    NSString *logoUrl = [itenary.providerLogo stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
    [cell.providerLogo sd_setImageWithURL:[NSURL URLWithString:logoUrl]];
 }


-(NSString *)textForNumberOfStops:(int)number {
    return number > 0 ? [NSString stringWithFormat:@"%d Stops",number] : @"Direct";
}

- (NSString *)durationStringWithArrival:(NSString *)arrival
                        departure:(NSString *)departure {
    
    int durationTimeInMinutes = [self durationTimeWithArrival:arrival departure:departure];
    return [self getDurationStringFromMinutes:durationTimeInMinutes];
}

-(int)durationTimeWithArrival:(NSString *)arrival
                 departure:(NSString *)departure {
    int arrivalTime = [self getTotalMinutesFromTimeString:arrival];
    int departureTime = [self getTotalMinutesFromTimeString:departure];
    if (arrivalTime < departureTime) {
        // 24 Hours Clock
        arrivalTime += 12*60;
    }
    
    return arrivalTime - departureTime;
    
}

-(NSString *)getDurationStringFromMinutes:(int)timeInMinutes {
    
    int hours = timeInMinutes/60;
    int minutes = timeInMinutes%60;
    return [NSString stringWithFormat:@"%d:%d",hours,minutes];
    
}


-(int)getTotalMinutesFromTimeString:(NSString *)timeString {
    
    NSArray *components = [timeString componentsSeparatedByString:@":"];
    int arrivalHours = 0;
    int arrivalMinutes = 0;
    if (components.count == 2) {
        arrivalHours = [[components firstObject] intValue];
        arrivalMinutes = [[components lastObject] intValue];
    }
    return (arrivalHours*60 + arrivalMinutes);

}

-(NSString *)getDepartureAndArrivalText:(NSString *)arrival
                              departure:(NSString *)departure {
    return [NSString stringWithFormat:@"%@ - %@",arrival,departure];
}
- (GETravelOptionMO *)itenaryAtIndexPath:(NSIndexPath*)indexPath {
    
    return self.itenaries[indexPath.row];
}



@end
