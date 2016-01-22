//
//  TwitterAPI.h
//  EjercicioTwitter
//
//  Created by Gerardo Fernandez on 1/7/16.
//  Copyright © 2016 Gerardo Fernandez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface iTunesAPI : AFHTTPSessionManager
+ (void) searchMediaByKeyword: (NSString *) keyword success: (void (^)(NSMutableArray* results)) success failure: (void (^)(NSString* errorMessage)) failure;
+ (void) getImageDataByUrl:(NSString *)imageUrl success: (void (^)(NSData* image)) success failure:(void (^)(NSString* errorMessage)) failure;
@end
