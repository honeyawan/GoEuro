//
//  GEItenary.m
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "GESortOption.h"

@implementation GESortOption

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    self.type = [[dictionary objectForKey:@"identifier"] intValue];
    self.title = [dictionary objectForKey:@"title"];
    return self;
}




@end
