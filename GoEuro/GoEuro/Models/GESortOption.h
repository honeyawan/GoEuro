//
//  GEItenary.h
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GESortOption : NSObject
@property (nonatomic,assign) int type;
@property (nonatomic,strong) NSString *title;
-(id)initWithDictionary:(NSDictionary *)dictionary;

@end
