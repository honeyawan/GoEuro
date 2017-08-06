//
//  GECoreDataManagerTests.m
//  GoEuro
//
//  Created by Haneef Habib on 8/6/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>
#import "GECoreDataManager.h"

@interface GECoreDataManagerTests : XCTestCase

@property (nonatomic,weak) GECoreDataManager *manager;

@end

@implementation GECoreDataManagerTests

- (void)setUp {
    [super setUp];
    self.manager = [GECoreDataManager sharedInstance];
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testSingleton {
    GECoreDataManager *manager = [[GECoreDataManager alloc] init];
    XCTAssertEqualObjects(manager,self.manager);
}

- (void)testContextExists {
    
    NSManagedObjectContext *context =  [self.manager managedObjectContext];
    XCTAssertNotNil(context);

    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPersistenCoordinatorExists {
    
    NSPersistentStoreCoordinator *coordinator =  [self.manager persistentStoreCoordinator];
    XCTAssertNotNil(coordinator);
    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


- (void)testManageObjectModelExists {
    
    NSManagedObjectModel *model =  [self.manager managedObjectModel];
    XCTAssertNotNil(model);
    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testReadWriteTravelOptions {
    
}



@end
