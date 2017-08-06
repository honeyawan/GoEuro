//
//  GEItenaryStore.m
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "GEItenaryStore.h"
#import "GENetworkAdapter.h"
#import "GETravelMode.h"
#import "GESortOption.h"
#import "GECoreDataManager.h"
@interface GEItenaryStore ()

@property (nonatomic,strong) NSMutableArray *travelOptions;
@property (nonatomic,strong) NSMutableArray *sortOptions;
@property (nonatomic,strong) NSMutableArray *travelModes;



@end
@implementation GEItenaryStore

static GEItenaryStore* sharedStore = nil;

+(GEItenaryStore*)sharedInstance {
    if (!sharedStore) {
        sharedStore = [[GEItenaryStore alloc] init];
    }
    return sharedStore;
}

- (id)init
{
    if (!sharedStore) {
        sharedStore = [super init];
        sharedStore.travelOptions = [NSMutableArray array];
    }
    return sharedStore;
}


-(NSArray *)getTravelModes {
    if (self.travelModes != nil)
        return self.travelModes;
    
    NSArray *modesDictionaries = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TravelModes" ofType:@"plist"]];
    NSMutableArray *modes = [NSMutableArray array];
    for (NSDictionary *dictionary in modesDictionaries) {
        GETravelMode *itenaryMode = [[GETravelMode alloc] initWithDictionary:dictionary];
        [modes addObject:itenaryMode];
    }
    self.travelModes = modes;
    return self.travelModes;
    
}

-(NSArray *)getSortOptions {
    
    if (self.sortOptions != nil)
        return self.sortOptions;
    
    NSArray *modesDictionaries = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SortOptions" ofType:@"plist"]];
    NSMutableArray *sortOptions = [NSMutableArray array];
    for (NSDictionary *dictionary in modesDictionaries) {
        GESortOption *option = [[GESortOption alloc] initWithDictionary:dictionary];
        [sortOptions addObject:option];
    }
    
    self.sortOptions = sortOptions;
    return self.sortOptions;

}


- (void)getItenariesWithURL:(NSString *)urlString completionHandler:(void (^)(NSArray *  array, NSError *  error))completion {

    // Pick from memory First
    NSArray *filteredOptions = [self getOptionsFromCacheWithUrl:urlString];
    if ([filteredOptions count] > 0) {
        completion(filteredOptions,nil);
        return;
    }

    __weak GEItenaryStore *weakSelf = self;

    // If not in memory then load from Network and write in DB
    [GENetworkAdapter getItenariesWithURL:urlString completionHandler:^(NSArray *array, NSError *error) {
        // Perform UI upadte and DB Operations OnMainThread
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil && array.count > 0){
                [[GECoreDataManager sharedInstance] updateTravelOptions:array forURL:urlString];
            }
            
            NSArray *optionsArray = [[GECoreDataManager sharedInstance] fetchTravelOptionsWithURL:urlString];
            [weakSelf.travelOptions addObjectsFromArray:optionsArray];
            completion(optionsArray,error);
        });
    }];
    
}

-(NSArray *)getOptionsFromCacheWithUrl:(NSString *)urlString {
    
   return  [self.travelOptions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"sourceURL == %@", urlString]];
    
}

@end
