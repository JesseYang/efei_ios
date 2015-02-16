//
//  NetWorkTaskGetAppVersion.m
//  EFei
//
//  Created by Xiangzhen Kong on 2/16/15.
//
//

#import "NetWorkTaskGetAppVersion.h"
#import "EFei.h"
#import "TaskManager.h"
#import <ASIHTTPRequest.h>
#import <SBJsonParser.h>

static NSString* kResponseVersionKey = @"ios";

@implementation NetWorkTaskGetAppVersion

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeGetAppVersion];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeGetAppVersion;
    }
    return self;
}

- (void) start
{
    NSString* urlString = @"http://dev.efei.org/welcome/app_version";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@", url);
    
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    request.timeOutSeconds = 60;
    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    ASIHTTPRequest* __weak weakRequest = request;
    [request setCompletionBlock:^{
        
        NSString *responseString = [weakRequest responseString];
        SBJsonParser * parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *jsonDic = [parser objectWithString:responseString];
        if ([self parseResultDict:jsonDic])
        {
            [self sucess];
        }
        else
        {
            [self failed];
        }
    }];
    
    [request setFailedBlock:^{
        NSLog(@"ASIHTTPRequest error: %@", weakRequest.error);
        [self failed];
    }];
    
    [request setUseCookiePersistence:YES];
    [request startAsynchronous];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    NSString* version = [dict objectForKey:kResponseVersionKey];
    NSLog(@"App version:  %@", version);
    
    [EFei instance].account.lastestVersion = version;
    
    return YES;
}


@end
