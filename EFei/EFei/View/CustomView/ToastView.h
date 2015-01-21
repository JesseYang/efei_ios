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
extern NSString* kErrorMessageWrongSignInFailed;
extern NSString* kErrorMessageWrongSignUpFailed;
extern NSString* kErrorMessageNoSuchUser;
extern NSString* kErrorMessageGetRestPasswordTokenFailed;
extern NSString* kErrorMessageResetPasswordFailed;


@interface ToastView : UIView

+ (void) showMessage:(NSString*)message;

@end