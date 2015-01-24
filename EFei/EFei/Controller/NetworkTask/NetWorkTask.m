//
//  NetWorkTask.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import "NetWorkTask.h"
#import <ASIHTTPRequest.h>
#import <SBJson.h>
#import "EFei.h"

NSString* kNetworkNotificationName = @"EFeiNetworkNotificationName";

static NSString* kBaseUrl = @"http://dev.efei.org";

static NSString* kBaseResponseSuccessKey = @"success";
static NSString* kBaseResponseTokenKey = @"auth_key";
static NSString* kBaseResponseCodeKey = @"code";

static NSString* kBaseRequestTokenKey = @"auth_key";
static NSString* kBaseReqeustClientKey = @"client";
static NSString* kBaseReqeustMessageKey = @"message";

@interface NetWorkTask()
{
    NSDictionary* _dataDict;
}

- (void) startGet;
- (void) startPost;
- (void) startPut;
- (void) startDelete;

- (void) parseResult:(NSString*)result;

@end

@implementation NetWorkTask

- (id) init
{
    self = [super init];
    if (self)
    {
        self.parameterDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) start
{
    [self prepareParameter];
    switch (self.httpMethod)
    {
        case HttpMethodGet:
            [self startGet];
            break;
            
        case HttpMethodPost:
            [self startPost];
            break;
            
        case HttpMethodPut:
            [self startPut];
            break;
            
        case HttpMethodDelete:
            [self startDelete];
            break;
            
        default:
            self.errorCode = NetWorkTaskErrorCodeUnsupportMethod;
            [self failed];
            break;
    }
}

- (void) cancel
{
    
}

- (void) pause
{
    
}

- (void) resume
{
    
}

- (void) sucess
{
    if (self.completionBlock != nil)
    {
        self.completionBlock(self.taskType, YES);
    }
}

- (void) failed
{
    NSLog(@"NetworkTask failed. Error code: %ld. %@", self.errorCode, self.error);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkNotificationName object:self.error];
    
    if (self.completionBlock != nil)
    {
        self.completionBlock(self.taskType, NO);
    }
}

- (void) prepareParameter
{
    
}

- (void) parseResult:(NSString *)result
{
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    
    NSMutableDictionary *jsonDic = [parser objectWithString:result];
    BOOL success = [[jsonDic objectForKey:kBaseResponseSuccessKey] boolValue];
    NSString* token = [jsonDic objectForKey:kBaseResponseTokenKey];
    
    if (success)
    {
        if (token.length > 0)
        {
            [EFei instance].account.token = token;
        }
        
        [jsonDic removeObjectForKey:kBaseResponseSuccessKey];
        [jsonDic removeObjectForKey:kBaseResponseTokenKey];
        
        
        if ([self parseResultDict:jsonDic])
        {
            [self sucess];
        }
        else
        {
            self.errorCode = NetWorkTaskErrorCodeParseDataError;
            [self failed];
        }
    }
    else
    {
        self.errorCode = [[jsonDic objectForKey:kBaseResponseCodeKey] integerValue];
        self.error = [jsonDic objectForKey:kBaseReqeustMessageKey];
        [self failed];
    }
}

- (BOOL) parseResultDict:(NSDictionary*)dict
{
    NSLog(@"Task result: %@", dict);
    return YES;
}


- (void) startGet
{
    NSMutableString* urlString = [NSMutableString stringWithFormat:@"%@/%@?",kBaseUrl, self.path];
    
    if (self.taskType != NetWorkTaskTypeParseShortUrl)
    {
        NSString* token = [EFei instance].account.token;
        NSString* client = [EFei instance].account.client;
        if (token.length > 0)
        {
            [urlString appendFormat:@"%@=%@&", kBaseRequestTokenKey, token];
        }
        [urlString appendFormat:@"%@=%@&", kBaseReqeustClientKey, client];
        
        for (NSString* key in self.parameterDict.allKeys)
        {
            NSString* value = [self.parameterDict objectForKey:key];
            [urlString appendFormat:@"%@=%@&", key, value];
        }
    }
    
    [urlString deleteCharactersInRange:NSMakeRange(urlString.length-1, 1)];
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", url);
    
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    request.timeOutSeconds = 60;
    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    ASIHTTPRequest* __weak weakRequest = request;
    [request setCompletionBlock:^{
        
        NSString *responseString = [weakRequest responseString];
        NSLog(@"ResponseString : %@", responseString);
        [self parseResult:responseString];
    }];
    
    [request setFailedBlock:^{
        NSLog(@"ASIHTTPRequest error: %@", weakRequest.error);
        [self failed];
    }];
    
    [request setUseCookiePersistence:YES];
    [request startAsynchronous];
}

- (void) startPost
{
    [self doPost:@"POST"];
}

- (void) startPut
{
    [self doPost:@"PUT"];
}

- (void) startDelete
{
    [self doPost:@"DELETE"];
}

- (void) doPost:(NSString*)method
{
    NSMutableString* urlString = [NSMutableString stringWithFormat:@"%@/%@",kBaseUrl, self.path];
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setTimeOutSeconds:60];
    
    
    NSString* token = [EFei instance].account.token;
    NSString* client = [EFei instance].account.client;
    if (token.length > 0)
    {
        [self.parameterDict setObject:token forKey:kBaseRequestTokenKey];
    }
    [self.parameterDict setObject:client forKey:kBaseReqeustClientKey];
    
    if ([NSJSONSerialization isValidJSONObject:self.parameterDict])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.parameterDict options:NSJSONWritingPrettyPrinted error:&error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        
        [request setPostBody:tempJsonData];
    }
    [request buildPostBody];
    [request setRequestMethod:method];
    
    ASIHTTPRequest* __weak weakRequest = request;
    [request setCompletionBlock:^{
        NSString *responseString = [weakRequest responseString];
        [self parseResult:responseString];
    }];
    
    [request setFailedBlock:^{
        NSLog(@"ASIHTTPRequest error: %@", weakRequest.error);
        [self failed];
    }];
    
    [request setUseCookiePersistence:YES];
    [request startAsynchronous];
}

@end
