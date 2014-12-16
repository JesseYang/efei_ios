//
//  PersonalSettingController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import "PersonalSettingController.h"
#import "EFei.h"

@interface PersonalSettingController()
{
    User* _tempUser;
}

@end

@implementation PersonalSettingController

+ (PersonalSettingController*) instance
{
    static PersonalSettingController* _instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[PersonalSettingController alloc] init];
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

- (NSString*) setting
{
    NSString* s = nil;
    switch (self.type)
    {
        case PersonalSettingTypeName:
            s = [EFei instance].user.name;
            break;
            
        case PersonalSettingTypeEmail:
            s = [EFei instance].user.email;
            break;
            
        case PersonalSettingTypePhone:
            s = [EFei instance].user.mobile;
            break;
            
        default:
            break;
    }
    
    return s;
}


- (void) startChange
{
    _tempUser = [[EFei instance].user copy];
}

- (void) cancelChange
{
    _tempUser = nil;
}

- (void) confirmChange
{
    [EFei instance].user.name = _tempUser.name;
    [EFei instance].user.email = _tempUser.email;
    [EFei instance].user.mobile = _tempUser.mobile;
}

@end
