//
//  Infos.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import <Foundation/Foundation.h>

@interface Infos : NSObject

@end

@interface SigninInfo : NSObject

@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* password;

@end


@interface SignUpInfo : NSObject

@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* nickName;
@property (nonatomic, copy) NSString* password;

@end



@interface ResetPasswordInfo : NSObject

@property (nonatomic, copy) NSString* phoneNumber;
@property (nonatomic, copy) NSString* verifyCode;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, copy) NSString* token;

@end


@interface ChangePasswordInfo : NSObject

@property (nonatomic, copy) NSString* password;
@property (nonatomic, copy) NSString* passwordNew;

@end


@interface GetTeacherInfo : NSObject

@property (nonatomic, assign) NSInteger scope;
@property (nonatomic, copy) NSString* subject;
@property (nonatomic, copy) NSString* name;

@property (nonatomic, strong) NSArray* results;

@end




@interface AddRemoveTeacherInfo : NSObject

@property (nonatomic, assign) NSInteger teacherId;
@property (nonatomic, assign) NSInteger classId;

@end

////////////////////////////////////////////////////////////////


@interface ExportInfo : NSObject

@property (nonatomic, copy) NSString* fileType;
@property (nonatomic, assign) BOOL hasAnswer;
@property (nonatomic, assign) BOOL hadNote;
@property (nonatomic, copy) NSString* noteIdStr;
@property (nonatomic, copy) NSString* email;

@end


