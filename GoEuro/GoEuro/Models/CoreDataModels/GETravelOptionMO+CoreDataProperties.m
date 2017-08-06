//
//  GETravelOptionMO+CoreDataProperties.m
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "GETravelOptionMO+CoreDataProperties.h"

@implementation GETravelOptionMO (CoreDataProperties)

+ (NSFetchRequest<GETravelOptionMO *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TravelOption"];
}

@dynamic entityID;
@dynamic providerLogo;
@dynamic price;
@dynamic arrivalTime;
@dynamic departureTime;
@dynamic numberOfStops;
@dynamic sourceURL;

@end
