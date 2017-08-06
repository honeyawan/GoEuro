//
//  GEItenaryStore.h
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GECoreDataManager : NSObject

@property (readonly, strong) NSPersistentContainer * persistentContainer;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


+(GECoreDataManager*)sharedInstance;
-(void)updateTravelOptions:(NSArray *)options forURL:(NSString *)urlString;
-(NSArray *)fetchTravelOptionsWithURL:(NSString *)urlString;


@end
