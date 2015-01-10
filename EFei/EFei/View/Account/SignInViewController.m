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

@interface SignInViewController()
{
    
}

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

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
}

- (void) setupViews
{
    self.usernameTextField.text = [EFei instance].account.username;
    self.passwordTextField.text = [EFei instance].account.password;
}



- (IBAction)onSignIn:(id)sender
{
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        if (success)
        {
            [[EFei instance].account save];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    };
    
    [SignInCommand executeWithUsername:self.usernameTextField.text
                              password:self.passwordTextField.text
                       completeHandler:handler];

}
@end
