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
    
}


- (void) setupNavigator
{
    self.navigationItem.title = @"登陆";
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
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        if (success)
        {
            [[EFei instance].account save];
            
            [GetUserInfoCommand executeWithCompleteHandler:nil];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    };
    
    [SignInCommand executeWithUsername:self.usernameTextField.text
                              password:self.passwordTextField.text
                       completeHandler:handler];

}
@end
