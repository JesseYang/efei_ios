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
    NSString* password = self.passwordTextField.text;
    if (password.length > 0)
    {
        CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        };
        
        NSString* phone = [ResetPasswordController instance].phone;
        NSString* authCode = [ResetPasswordController instance].authCode;
        NSString* password = self.passwordTextField.text;
        
        [ResetPasswordCommand executeWithPhoneNumber:phone authCode:authCode password:password completeHandler:handler];
    }
}

@end

