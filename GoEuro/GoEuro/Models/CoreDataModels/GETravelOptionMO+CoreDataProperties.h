//
//  GETravelOptionMO+CoreDataProperties.h
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "GETravelOptionMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GETravelOptionMO (CoreDataProperties)

+ (NSFetchRequest<GETravelOptionMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *providerLogo;
@property (nullable, nonatomic, copy) NSString *arrivalTime;
@property (nullable, nonatomic, copy) NSString *departureTime;
@property (nullable, nonatomic, copy) NSString *sourceURL;
@property (nonatomic) int16_t numberOfStops;
@property (nonatomic) int16_t price;
@property (nonatomic) int64_t entityID;


@end

NS_ASSUME_NONNULL_END
