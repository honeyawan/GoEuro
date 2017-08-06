//
//  GEItenaryStore.m
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "GECoreDataManager.h"
#import "GETravelOptionMO+CoreDataClass.h"

@implementation GECoreDataManager

static GECoreDataManager* sharedStore = nil;

+(GECoreDataManager*)sharedInstance {
    if (!sharedStore) {
        sharedStore = [[GECoreDataManager alloc] init];
    }
    return sharedStore;
}

- (id)init
{
    if (!sharedStore) {
        sharedStore = [super init];
    }
    return sharedStore;
}


-(void)updateTravelOptions:(NSArray *)options forURL:(NSString *)urlString {
    
    [self deleteSavedTravelOptionsForURL:urlString];
    [self addNewTravelOptions:options forURL:urlString];
    
}

-(void)addNewTravelOptions:(NSArray *)options forURL:(NSString *)urlString {

    NSManagedObjectContext *context = self.managedObjectContext;
    for (NSDictionary *dictionary in options) {
        GETravelOptionMO *option = [NSEntityDescription insertNewObjectForEntityForName:@"TravelOption" inManagedObjectContext:context];
        option.arrivalTime = [dictionary objectForKey:@"arrival_time"];
        option.departureTime = [dictionary objectForKey:@"departure_time"];
        option.numberOfStops = [[dictionary objectForKey:@"number_of_stops"] intValue];
        option.price = [[dictionary objectForKey:@"price_in_euros"] intValue];
        option.providerLogo = [dictionary objectForKey:@"provider_logo"];
        option.entityID = [[dictionary objectForKey:@"id"] intValue];
        option.sourceURL = urlString;
    }
    [self saveContext];

}

-(void)deleteSavedTravelOptionsForURL:(NSString *)urlString {
    
    NSArray *travelOptions = [self fetchTravelOptionsWithURL:urlString];
    NSManagedObjectContext *context = self.managedObjectContext;
    for (GETravelOptionMO *travelOption in travelOptions) {
        [context deleteObject:travelOption];
    }
    [self saveContext];
}

-(NSArray *)fetchTravelOptionsWithURL:(NSString *)urlString {
    
    NSManagedObjectContext *context = self.managedObjectContext;
    NSFetchRequest *request = [GETravelOptionMO fetchRequest];
    [request setPredicate:[NSPredicate predicateWithFormat:@"sourceURL == %@", urlString]];
    NSArray *results = [context executeFetchRequest:request error:nil];
    return results;
    
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

@synthesize managedObjectModel = _managedObjectModel;
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GoEuro" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    
    NSURL *url = [[[[NSFileManager alloc] init] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *storeURL = [url URLByAppendingPathComponent:@"GoEuro.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:@"true",NSMigratePersistentStoresAutomaticallyOption,@"true",NSInferMappingModelAutomaticallyOption, nil];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
    }
    
    return _persistentStoreCoordinator;
}



@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"GoEuro"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                }
            }];
        }
    }
    
    return _persistentContainer;
}


#pragma mark - Core Data Saving Context
- (void)saveContext {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        [context reset];
        [self saveContext];
    }
}



@end
