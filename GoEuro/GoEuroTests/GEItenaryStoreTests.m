//
//  GEItenaryStoreTests.m
//  GoEuro
//
//  Created by Haneef Habib on 8/6/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GEItenaryStore.h"
#import "GETravelMode.h"
@interface GEItenaryStoreTests : XCTestCase
@property (nonatomic,weak) GEItenaryStore *sharedStore;

@end

@implementation GEItenaryStoreTests

- (void)setUp {
    [super setUp];
    self.sharedStore = [GEItenaryStore sharedInstance];
}

- (void)tearDown {
    [super tearDown];
}


-(void)testSingleton {
    GEItenaryStore *sotre = [[GEItenaryStore alloc] init];
    XCTAssertEqualObjects(sotre,self.sharedStore );
}

- (void)testGetSortOptions {
    NSArray *sortOptions = [self.sharedStore getSortOptions];
    XCTAssertGreaterThan(sortOptions.count, 0);
}

- (void)testGetTravelModes {
    NSArray *travelModes = [self.sharedStore getTravelModes];
    XCTAssertGreaterThan(travelModes.count, 0);
}


-(void)testFetchTravelOptions {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works Correctly!"];

    NSArray *travelModes = [self.sharedStore getTravelModes];
    GETravelMode *mode = [travelModes firstObject];
    [[GEItenaryStore sharedInstance] getItenariesWithURL:mode.itenaryURL completionHandler:^(NSArray *array, NSError *error) {
        if (error == nil && array.count > 0) {
            [expectation fulfill];
        }
    }];
    
    //Wait 10 second to get Travel Options otherwise fail:
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if(error)
        {
            XCTFail(@"Not Able To Get Travel Options:%@", error);
        }
        
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
