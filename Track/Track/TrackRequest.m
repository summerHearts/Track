//
//  TrackRequest.m
//  Track
//
//  Created by Kenvin on 2016/03/10.
//  Copyright © 2016年 Kenvin. All rights reserved.
//

#import "TrackRequest.h"

#define APP_STATISTICS_URL     @"http://iapplog.imike.com:8000"

@implementation TrackRequest

+(BOOL)sendTrackDataSync:(NSString *)data{
    NSArray* dataArray = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    if(dataArray == nil || ![dataArray isKindOfClass:[NSArray class]]){
        return NO;
    }
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:dataArray, @"data", nil];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString* jsonStringPost = [jsonString stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
    jsonStringPost = [jsonStringPost stringByReplacingOccurrencesOfString:@"'{" withString:@"{"];
    jsonStringPost = [jsonStringPost stringByReplacingOccurrencesOfString:@"}'" withString:@"}"];
#if DEBUG
    NSLog(@"BI埋点数据:%@",jsonStringPost);
#endif
    NSURL *url=[NSURL URLWithString:APP_STATISTICS_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[jsonStringPost dataUsingEncoding:NSUTF8StringEncoding];
    NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return result != nil;
}

+(BOOL)sendTrackOTSDataSync:(NSString *)data{
    NSArray* dataArray = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    if(dataArray == nil || ![dataArray isKindOfClass:[NSArray class]]){
        return NO;
    }
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:dataArray, @"data", nil];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"baseUrl", @"sys/viewevent"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    return result != nil;
}

@end
