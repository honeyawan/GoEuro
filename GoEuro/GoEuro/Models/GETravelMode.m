//
//  GEItenary.m
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "GETravelMode.h"

@implementation GETravelMode

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    self.identifier = [dictionary objectForKey:@"identifier"];
    self.title = [dictionary objectForKey:@"title"];
    self.itenaryURL = [dictionary objectForKey:@"itenaryURL"];
    return self;
}


@end
