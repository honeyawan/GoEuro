//
//  GEViewControllerTests.m
//  GoEuro
//
//  Created by Haneef Habib on 8/6/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import <UIKit/UIKit.h>
@interface GEViewControllerTests : XCTestCase

@property (nonatomic,strong) ViewController *viewController;

@end

@implementation GEViewControllerTests

- (void)setUp {
    
    [super setUp];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *controller = (ViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"ViewControllerID"];
    self.viewController = controller;
    UIView *controllerView = self.viewController.view;
    NSLog(@"%@",controllerView);
    
    
}

- (void)tearDown {
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
}



- (void)testIBOutletsNotNil {
    
    XCTAssertNotNil(self.viewController.itenaryTableView);
    XCTAssertNotNil(self.viewController.transportationModeCollectionView);
    XCTAssertNotNil(self.viewController.sortOptionsCollectionView);
}

- (void)testTableViewDataSourceNotNil {
    XCTAssertNotNil(self.viewController.itenaryTableView.dataSource);
}

- (void)testTableViewDelegateNotNil {
    XCTAssertNotNil(self.viewController.itenaryTableView.delegate);
}

- (void)testCollectionViewDataSourceNotNil {
    
    XCTAssertNotNil(self.viewController.transportationModeCollectionView.dataSource);
    XCTAssertNotNil(self.viewController.sortOptionsCollectionView.dataSource);
}

- (void)testCollectionViewDelegateNotNil {
    XCTAssertNotNil(self.viewController.transportationModeCollectionView.delegate);
    XCTAssertNotNil(self.viewController.sortOptionsCollectionView.delegate);
}

- (void)testConfromsTableViewDataSource {
    
    XCTAssert([self.viewController respondsToSelector:@selector(tableView:numberOfRowsInSection:)]);
    XCTAssert([self.viewController respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]);
}


- (void)testConfromsTableViewDelegate {
    XCTAssert([self.viewController respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]);
}

- (void)testConfromsCollectionViewDataSource {
    
    XCTAssert([self.viewController respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]);
    XCTAssert([self.viewController respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]);
}

- (void)testConfromsCollectionViewDelegate {
    XCTAssert([self.viewController respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]);
}


@end
