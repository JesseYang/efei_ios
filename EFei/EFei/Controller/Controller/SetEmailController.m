//
//  SetEmailController.m
//  EFei
//
//  Created by Xiangzhen Kong on 3/16/15.
//
//

#import "SetEmailController.h"

@implementation SetEmailController

+ (SetEmailController*) instance
{
    static SetEmailController* _instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[SetEmailController alloc] init];
    });
    
    return _instance;
}

@end
