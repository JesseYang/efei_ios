//
//  SignUpViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/20/14.
//
//

#import "SignUpViewController.h"
#import "AccountCommand.h"
#import "ToastView.h"
#import "EFei.h"

@interface SignUpViewController()
{
    
}

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

- (IBAction)onSignUp:(id)sender;
- (IBAction)onCancel:(id)sender;

@end

@implementation SignUpViewController


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
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"注册";
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"直接登录"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(onCancel:)];
    self.navigationItem.rightBarButtonItem=btnBack;
}

- (void) setupViews
{
    self.signUpButton.layer.cornerRadius = 5;
}

- (IBAction)onSignUp:(id)sender
{
    if (![self checkPhoneNumber])
    {
        return;
    }
    
    
    if (![self checkPassword])
    {
        return;
    }
    
    if (![self checkRealName])
    {
        return;
    }
    
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        NSLog(@"");
        
        if (success)
        {
            [self onSuccess:nil];
        }
        
    };
    
    [SignUpCommand executeWithUsername:self.usernameTextField.text
                              nickName:self.nicknameTextField.text
                                idCode:nil phoneNumber:nil
                              authCode:nil password:self.passwordTextField.text
                       completeHandler:handler];
}

- (IBAction)onCancel:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onSuccess:(id)sender
{
    [EFei instance].account.username = self.usernameTextField.text;
    [EFei instance].account.password = self.passwordTextField.text;
    [EFei instance].account.autoSignIn = YES;
    
    [ToastView showMessage:kErrorMessageSignUpSuccess];
    [self.navigationController popViewControllerAnimated:NO];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (BOOL) checkPhoneNumber
{
    NSString* text = self.usernameTextField.text;
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if (text.length == 11 && [text rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        return YES;
    }
    else
    {
        [ToastView showMessage:kErrorMessageWrongPhoneNumber];
        return NO;
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


- (BOOL) checkRealName
{
    NSString* text = self.nicknameTextField.text;
    if (text.length > 0)
    {
        return YES;
    }
    else
    {
        [ToastView showMessage:kErrorMessageWrongRealName];
        return NO;
    }
}

@end
