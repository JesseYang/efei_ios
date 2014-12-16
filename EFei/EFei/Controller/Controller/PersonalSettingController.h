//
//  PersonalSettingController.h
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PersonalSettingTypeName,
    PersonalSettingTypeEmail,
    PersonalSettingTypePhone,
} PersonalSettingType;

@interface PersonalSettingController : NSObject

@property (nonatomic, copy) NSString* setting;

@property (nonatomic, assign) PersonalSettingType type;

+ (PersonalSettingController*) instance;

- (void) startChange;
- (void) cancelChange;
- (void) confirmChange;

@end
