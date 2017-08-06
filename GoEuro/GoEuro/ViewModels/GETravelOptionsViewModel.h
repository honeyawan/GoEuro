//
//  GEItenaryViewModel.h
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GEItenaryTableViewCell;
@interface GETravelOptionsViewModel : NSObject

-(void)fetchItenariesWithURL:(NSString *)urlString
                  sortOption:(int)sortType
           completionHandler:(void (^) (NSError *  error))completion;

-(void)configureCell:(GEItenaryTableViewCell *)cell
        forIndexPath:(NSIndexPath *)indexPath;

-(NSUInteger)numberOfRowsInSection:(NSInteger)section;

-(void)sortOptionsWithSortType:(int)type;

@end
