//
//  Account.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "Account.h"

@interface Account()

- (void) initClientVersion;

@end

@implementation Account

- (id) init
{
    self = [super init];
    if (self)
    {
        self.token = @"9eWXA9uQgH2YKPrOkoo2wnC8W7wavDI8RdMNpaKi6BuNP6DFjPjJ8F_cIOAwP6Bh";
        
        [self initClientVersion];
    }
    return self;
}

- (void) initClientVersion
{
    _client = [[UIDevice currentDevice].systemName copy];
}

@end
