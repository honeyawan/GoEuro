//
//  GEItenary.h
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GETravelOption : NSObject
@property (nonatomic,strong) NSString *identifier;
@property (nonatomic,strong) NSNumber *euroPrice;
@property (nonatomic,strong) NSString *departureTime;
@property (nonatomic,strong) NSString *arrivalTime;
@property (nonatomic,strong) NSString *traverDuration;
@property (nonatomic,strong) NSNumber *numberOfStops;
@property (nonatomic,strong) NSString *logo;

-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
