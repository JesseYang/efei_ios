//
//  ToastView.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/20/15.
//
//

#import "ToastView.h"

NSString* kErrorMessageWrongUserName                = @"请输入用户名";
NSString* kErrorMessageWrongPhoneNumber             = @"请输入正确的手机号";
NSString* kErrorMessageWrongPassword                = @"请输入6-16位密码";
NSString* kErrorMessageWrongRealName                = @"请输入真实姓名";
NSString* kErrorMessageWrongEmail                   = @"请输入正确的邮箱地址";
NSString* kErrorMessageWrongSignInFailed            = @"登录失败，请重试";
NSString* kErrorMessageWrongSignUpFailed            = @"注册失败，请重试";
NSString* kErrorMessageSignUpSuccess                = @"注册成功, 已登录";
NSString* kErrorMessageNeedSignIn                   = @"请先登录或注册";
NSString* kErrorMessageNoSuchUser                   = @"用户不存在，请重试";
NSString* kErrorMessageGetRestPasswordTokenFailed   = @"验证码错误，请重试";
NSString* kErrorMessageResetPasswordFailed          = @"重置密码失败，请重试";
NSString* kErrorMessageNoExportDestination          = @"请选择导出方式";
NSString* kErrorMessageNoVerifyCode                 = @"请输入验证码";
NSString* kErrorMessageDownloadSuccess              = @"下载成功";
NSString* kErrorMessageDownloadFailed               = @"下载失败";
NSString* kErrorMessageSendToMailSuccess            = @"发送成功";
NSString* kErrorMessageAddTeacherSuccess            = @"添加教师成功";

@interface ToastView()

- (id) initWithMessage:(NSString*)message;
- (void) setupUI:(NSString*)message;

@end

@implementation ToastView

+ (void) showMessage:(NSString *)message
{
    ToastView* view = [[ToastView alloc] initWithMessage:message];
    
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    view.center = keyWindow.center;
    
    [keyWindow addSubview:view];
    
    [UIView animateWithDuration: 2.0f
                          delay: 0.5
                        options: UIViewAnimationOptionCurveEaseOut
                     animations: ^{
                         view.alpha = 0.0;
                     }
                     completion: ^(BOOL finished) {
                         [view removeFromSuperview];
                     }
     ];
}

- (id) initWithMessage:(NSString *)message
{
    self = [super init];
    
    if (self)
    {
        [self setupUI:message];
    }
    
    return self;
}

- (void) setupUI:(NSString*)message
{
    self.backgroundColor = [UIColor blackColor];
    self.layer.cornerRadius = 5.0f;
    
    UILabel* label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = message;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    CGSize size = [message sizeWithAttributes:@{NSFontAttributeName: label.font}];
    CGSize adjustedSize = CGSizeMake(MAX(ceilf(size.width), 200), MAX(ceilf(size.height), 80));
    
    CGRect rect = CGRectMake(0, 0, adjustedSize.width, adjustedSize.height);
    label.frame = rect;
    self.frame = rect;
}



@end
