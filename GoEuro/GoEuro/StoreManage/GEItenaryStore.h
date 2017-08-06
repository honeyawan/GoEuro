//
//  GEItenaryStore.h
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GEItenaryStore : NSObject

+(GEItenaryStore*)sharedInstance;

/// Returns all the itenaries agains the given url.
/// urlString is uniquea for each travel mode and hence differentiates travel options
/// Will return Previously saved objects if unable to fetch from url
- (void)getItenariesWithURL:(NSString *)urlString completionHandler:(void (^)(NSArray *  array, NSError *  error))completion;

/// Returns Array of Modes like Bus/Train/Flight from a local file
- (NSArray *)getTravelModes;

/// Returns Array of Sort Options (departure/arrival/duration) from a local file
- (NSArray *)getSortOptions;



@end
