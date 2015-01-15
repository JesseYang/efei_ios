//
//  ResetPasswordResultViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/9/15.
//
//

#import "ResetPasswordResultViewController.h"
#import "ResetPasswordController.h"
#import "EFei.h"
#import "AccountCommand.h"

@interface ResetPasswordResultViewController()
{
    NSInteger _countDown;
    NSTimer*  _timer;
}

@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBBI;

- (IBAction)onSignin:(id)sender;
- (IBAction)onResendCode:(id)sender;

@end

@implementation ResetPasswordResultViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigator];
    [self setupViews];
    
    if ([ResetPasswordController instance].email.length > 0)
    {
        [self getVerifyEmail];
    }
    else
    {
        [self getVerifyCode];
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void) setupNavigator
{
    if ([ResetPasswordController instance].email.length > 0)
    {
        self.navigationItem.title = @"找回密码";
    }
    else
    {
        self.navigationItem.title = @"手机验证";
    }
}

- (void) setupViews
{
    if ([ResetPasswordController instance].email.length > 0)
    {
        self.phoneView.hidden = YES;
        self.emailLabel.hidden = NO;
        self.emailLabel.text = [ResetPasswordController instance].email;
        
        self.rightBBI.title = @"登录";
    }
    else
    {
        self.phoneView.hidden = NO;
        self.emailView.hidden = YES;
        self.phoneLabel.text = [ResetPasswordController instance].phone;
        
        self.rightBBI.title = @"下一步";
    }
    
    self.sendCodeButton.layer.cornerRadius = 5;
}

- (IBAction)onSignin:(id)sender
{
    if ([ResetPasswordController instance].email.length > 0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [ResetPasswordController instance].authCode = self.codeTextField.text;
        [self performSegueWithIdentifier:@"ShowResetPasswordNewPwdViewController" sender:self];
    }
}

- (void) getVerifyEmail
{
    CompletionBlock hanlder = ^(NetWorkTaskType taskType, BOOL success) {
        if (success)
        {
        }
    };
    
    NSString* phone = [ResetPasswordController instance].email;
    [SendVerifyCodeCommand executeWithPhoneNumber:phone completeHandler:hanlder];
}

- (IBAction)onResendCode:(id)sender
{
    [self startCountDown];
}

- (void) getVerifyCode
{
    CompletionBlock hanlder = ^(NetWorkTaskType taskType, BOOL success) {
        if (success)
        {
            [self startCountDown];
        }
    };
    
    NSString* phone = [ResetPasswordController instance].phone;
    [SendVerifyCodeCommand executeWithPhoneNumber:phone completeHandler:hanlder];
}

- (void) startCountDown
{
    _countDown = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    self.sendCodeButton.enabled = NO;
    self.sendCodeButton.backgroundColor = [UIColor lightGrayColor];
    [self timerFireMethod:nil];
}

- (void) timerFireMethod:(id) sender
{
    NSString* title = [NSString stringWithFormat:@"重发验证码(%ld秒)",(long)_countDown];
    [self.sendCodeButton setTitle:title forState:UIControlStateNormal];
    self.sendCodeButton.titleLabel.text = title;
    _countDown --;
    
    if (_countDown == 0)
    {
        [_timer invalidate];
        
        [self.sendCodeButton setTitle:@"重发验证码" forState:UIControlStateNormal];
        self.sendCodeButton.enabled = YES;
        self.sendCodeButton.backgroundColor = [EFei instance].efeiColor;
    }
}


@end

