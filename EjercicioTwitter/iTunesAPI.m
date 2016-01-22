//
//  TwitterAPI.m
//  EjercicioTwitter
//
//  Created by Gerardo Fernandez on 1/7/16.
//  Copyright © 2016 Gerardo Fernandez. All rights reserved.
//

#import "iTunesAPI.h"
#import "AFNetworking.h"


@implementation iTunesAPI

+ (void) searchMediaByKeyword:(NSString *)keyword success: (void (^)(NSMutableArray* results)) success failure: (void (^)(NSString* errorMessage)) failure{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[[NSURL alloc] initWithString:@"https://itunes.apple.com"]];
    
    keyword = [keyword stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSLog(@"Keyword to search: %@", keyword);
    
    NSString *url = @"/search"; //[NSString stringWithFormat: @"/search?term=%@&media=music", keyword];
    
    [manager GET:url parameters: @{@"term": keyword, @"media": @"music"} progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"Download progress");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"Success response: %@", responseObject);
        success([responseObject objectForKey:@"results"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failure response: %@", error);
        failure(error.localizedDescription);
    }];
}

+ (void) getImageDataByUrl:(NSString *)imageUrl success: (void (^)(NSData* image)) success failure:(void (^)(NSString* errorMessage)) failure {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[[NSURL alloc] initWithString:@"https://itunes.apple.com"]];
    
    NSLog(@"Getting image: %@", imageUrl);
    
    [manager GET:imageUrl parameters: nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"Download progress");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"Success response: %@", responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failure response: %@", error);
        failure(error.localizedDescription);
    }];
}
@end
