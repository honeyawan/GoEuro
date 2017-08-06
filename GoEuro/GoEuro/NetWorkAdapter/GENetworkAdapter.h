//
//  GENetworkAdapter.h
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GENetworkAdapter : NSObject

+(void)getItenariesWithURL:(NSString *_Nonnull)urlString completionHandler:(void (^_Nonnull)(NSArray * _Nullable array, NSError * _Nullable error))completion;

@end
