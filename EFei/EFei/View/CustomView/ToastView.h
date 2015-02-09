//
//  ToastView.h
//  EFei
//
//  Created by Xiangzhen Kong on 1/20/15.
//
//

#import <UIKit/UIKit.h>

extern NSString* kErrorMessageWrongUserName;
extern NSString* kErrorMessageWrongPhoneNumber;
extern NSString* kErrorMessageWrongPassword;
extern NSString* kErrorMessageWrongRealName;
extern NSString* kErrorMessageWrongEmail;
extern NSString* kErrorMessageWrongSignInFailed;
extern NSString* kErrorMessageSignUpSuccess;
extern NSString* kErrorMessageNeedSignIn;
extern NSString* kErrorMessageWrongSignUpFailed;
extern NSString* kErrorMessageNoSuchUser;
extern NSString* kErrorMessageGetRestPasswordTokenFailed;
extern NSString* kErrorMessageResetPasswordFailed;
extern NSString* kErrorMessageNoExportDestination;
extern NSString* kErrorMessageNoVerifyCode;
extern NSString* kErrorMessageDownloadSuccess;
extern NSString* kErrorMessageDownloadFailed;
extern NSString* kErrorMessageSendToMailSuccess;
extern NSString* kErrorMessageAddTeacherSuccess;
extern NSString* kErrorMessageSendFeedbackSuccess;
extern NSString* kErrorMessageSendFeedbackFailed;

@interface ToastView : UIView

+ (void) showMessage:(NSString*)message;

@end
