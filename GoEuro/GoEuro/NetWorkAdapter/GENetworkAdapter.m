//
//  GENetworkAdapter.m
//  GoEuro
//
//  Created by Haneef Habib on 8/5/17.
//  Copyright © 2017 Demo. All rights reserved.
//

#import "GENetworkAdapter.h"

@implementation GENetworkAdapter

-(id)init {
    
    self = [super init];
    return self;
    
}

+(void) getItenariesWithURL:(NSString *)urlString completionHandler:(void (^)(NSArray * array, NSError * _Nullable error))completion{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray *jsonObjects = nil;
        if (error == nil) {
            jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        }
        completion(jsonObjects,error);

    }];
    
    [dataTask resume];
    
}
@end
