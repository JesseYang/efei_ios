//
//  NetWorkTask.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
    // Account
    NetWorkTaskTypeSignin,
    NetWorkTaskTypeSignup,
    NetWorkTaskTypeSignout,
    NetWorkTaskTypeSendVerifyCode,
    NetWorkTaskTypeGetResetPasswordToken,
    NetWorkTaskTypeResetPassword,
    
    // User
    NetWorkTaskTypeGetUserInfo,
    NetWorkTaskTypeRename,
    NetWorkTaskTypeChangePassword,
    NetWorkTaskTypeChangeEmail,
    NetWorkTaskTypeChangeMobile,
    NetWorkTaskTypeVerifyMobile,
    NetWorkTaskTypeGetTeachers,
    NetWorkTaskTypeAddTeacher,
    NetWorkTaskTypeDeleteTeacher,
    NetWorkTaskTypeFeedback,
    
    // Question
    NetWorkTaskTypeParseShortUrl,
    NetWorkTaskTypeGetQuestion,
    NetWorkTaskTypeAddQuestion,
    
    // Notebook
    NetWorkTaskTypeGetTopics,
    NetWorkTaskTypeGetNoteList,
    NetWorkTaskTypeGetNote,
    NetWorkTaskTypeDeleteNote,
    NetWorkTaskTypeUpdateNote,
    NetWorkTaskTypeExportNotes,
    NetWorkTaskTypeGetNotebookUpdateTime,
} NetWorkTaskType;

typedef enum : NSUInteger
{
    HttpMethodGet,
    HttpMethodPost,
    HttpMethodPut,
    HttpMethodDelete,
} HttpMethod;


typedef enum : NSUInteger {
    NetWorkTaskErrorCodeUnknown          = 0,
    NetWorkTaskErrorCodeUserNotExist     = -1,
    NetWorkTaskErrorCodeWrongPassword    = -2,
    NetWorkTaskErrorCodeUserExist        = -3,
    NetWorkTaskErrorCodeBlankUserName    = -4,
    NetWorkTaskErrorCodeWrongVerifyCode  = -5,
    NetWorkTaskErrorCodeWrongToken       = -6,
    NetWorkTaskErrorCodeExpired          = -7,
    NetWorkTaskErrorCodeRequireSignin    = -8,
    NetWorkTaskErrorCodeTeacherNotExist  = -9,
    NetWorkTaskErrorCodeQuestionNotExist = -10,
    NetWorkTaskErrorCodeNoteNotExist     = -11,
    
    NetWorkTaskErrorCodeUnsupportMethod  = -98,
    NetWorkTaskErrorCodeParseDataError   = -99,
} NetWorkTaskErrorCode;


typedef void (^CompletionBlock)(NetWorkTaskType taskType, BOOL success);

@interface NetWorkTask : NSObject

@property (nonatomic, assign) NetWorkTaskType taskType;
@property (nonatomic, assign) HttpMethod httpMethod;
@property (nonatomic, retain) id data;
@property (nonatomic, copy) NSString* path;
@property (nonatomic, copy) NSString* error;
@property (nonatomic, assign) NetWorkTaskErrorCode errorCode;
@property (nonatomic, retain) NSMutableDictionary* parameterDict;
@property (nonatomic, copy) CompletionBlock completionBlock;

- (void) start;

- (void) cancel;

- (void) pause;

- (void) resume;

- (void) sucess;

- (void) failed;

- (void) prepareParameter;

- (BOOL) parseResultDict:(NSDictionary*)dict;

@end

