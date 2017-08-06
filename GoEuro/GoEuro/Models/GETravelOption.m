//
//  GEItenary.m
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "GETravelOption.h"

@implementation GETravelOption

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    self.arrivalTime = [dictionary objectForKey:@"arrival_time"];
    self.departureTime = [dictionary objectForKey:@"departure_time"];
    self.numberOfStops = [dictionary objectForKey:@"number_of_stops"];
    self.euroPrice = [dictionary objectForKey:@"price_in_euros"];
    self.logo = [dictionary objectForKey:@"provider_logo"];
    self.identifier = [dictionary objectForKey:@"id"];
    return self;
}




@end
