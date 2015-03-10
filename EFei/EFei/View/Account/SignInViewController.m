//
//  SignInViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/20/14.
//
//

#import "SignInViewController.h"
#import "AccountCommand.h"
#import "EFei.h"
#import "UserCommand.h"
#import "ToastView.h"

@interface SignInViewController()
{
    
}

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

- (IBAction)onSignIn:(id)sender;

@end

@implementation SignInViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigator];
    [self setupViews];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupViews];
    
    if ([EFei instance].account.autoSignIn)
    {
        [EFei instance].account.autoSignIn = NO;
        [self onSignIn:self.signInButton];
    }
}


- (void) setupNavigator
{
    self.navigationItem.title = @"登录";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"返回"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:nil];
    self.navigationItem.backBarButtonItem=btnBack;
}

- (void) setupViews
{
    self.usernameTextField.text = [EFei instance].account.username;
    self.passwordTextField.text = [EFei instance].account.password;
    
    self.signInButton.layer.cornerRadius = 5;
}



- (IBAction)onSignIn:(id)sender
{
    if (self.usernameTextField.text.length == 0)
    {
        [ToastView showMessage:@"请输入用户名"];
        return;
    }
    
    
    if (self.passwordTextField.text.length == 0)
    {
        [ToastView showMessage:@"请输入密码"];
        return;
    }
    
    
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        if (success)
        {
            [[EFei instance].account save];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
            [self getUserInfo];
            
        }
        else
        {
//            [ToastView showMessage:@"用户名密码错误，请重试"];
        }
    };
    
    [SignInCommand executeWithUsername:self.usernameTextField.text
                              password:self.passwordTextField.text
                       completeHandler:handler];

}


- (void) getUserInfo
{
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
    };
    [GetUserInfoCommand executeWithCompleteHandler:handler];
}


@end
