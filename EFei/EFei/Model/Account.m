//
//  Account.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "Account.h"

#define UserDefaultUsernameKey @"EFeiUsernameKey"
#define UserDefaultPasswordKey @"EFeiPasswordKey"

@interface Account()

- (void) initClientVersion;

@end

@implementation Account

- (id) init
{
    self = [super init];
    if (self)
    {
//        self.token = @"9eWXA9uQgH2YKPrOkoo2wnC8W7wavDI8RdMNpaKi6BuNP6DFjPjJ8F_cIOAwP6Bh";
        
        [self initClientVersion];
        
        [self load];
    }
    return self;
}

- (void) initClientVersion
{
    _client = [[UIDevice currentDevice].systemName copy];
}

- (BOOL) needSignIn
{
    return self.token.length == 0;
}

- (void) signout
{
    self.token = @"";
}

- (void) save
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
    [accountDefaults setObject:self.username forKey:UserDefaultUsernameKey];
    [accountDefaults setObject:self.password forKey:UserDefaultPasswordKey];
    
    [accountDefaults synchronize];
}

- (void) load
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
    self.username = [accountDefaults objectForKey:UserDefaultUsernameKey];
    self.password = [accountDefaults objectForKey:UserDefaultPasswordKey];
    
    [accountDefaults synchronize];
}

@end
