//
//  ResetPasswordNewPwdViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/9/15.
//
//

#import "ResetPasswordNewPwdViewController.h"
#import "ResetPasswordController.h"
#import "AccountCommand.h"
#import "ToastView.h"

@interface ResetPasswordNewPwdViewController ()
{
    
}

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)onDone:(id)sender;

@end

@implementation ResetPasswordNewPwdViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigator];
    [self setupViews];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void) setupNavigator
{
    self.navigationItem.title = @"重设密码";
}

- (void) setupViews
{
}

- (IBAction)onDone:(id)sender
{
    if (![self checkPassword])
    {
        return;
    }
    
    NSString* password = self.passwordTextField.text;
    if (password.length > 0)
    {
        CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
            
            if (success)
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                [ToastView showMessage:kErrorMessageResetPasswordFailed];
            }
            
        };
        
        NSString* password = self.passwordTextField.text;
        NSString* token = [ResetPasswordController instance].resetPasswordToken;
        
        [ResetPasswordCommand executeWithToken:token password:password completeHandler:handler];
    }
}

- (BOOL) checkPassword
{
    NSString* text = self.passwordTextField.text;
    if (text.length >= 6 && text.length <= 16)
    {
        return YES;
    }
    else
    {
        [ToastView showMessage:kErrorMessageWrongPassword];
        return NO;
    }
}


@end

