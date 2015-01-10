//
//  ResetPasswordController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/9/15.
//
//

#import "ResetPasswordController.h"

@implementation ResetPasswordController

+ (ResetPasswordController*) instance
{
    static ResetPasswordController* _instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[ResetPasswordController alloc] init];
    });
    
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void) startResetPassword
{
    self.email = @"";
    self.phone = @"";
}

- (void) resetPassword:(NSString *)password withHandler:(CompletionBlock)handler
{
    
}

@end
