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
    }
    return self;
}

- (void) initClientVersion
{
    _client = [[UIDevice currentDevice].systemName copy];
}

@end
