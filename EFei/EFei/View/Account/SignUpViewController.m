//
//  SignUpViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/20/14.
//
//

#import "SignUpViewController.h"
#import "AccountCommand.h"

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
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        NSLog(@"");
        
        if (success)
        {
            [self onCancel:nil];
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

@end
