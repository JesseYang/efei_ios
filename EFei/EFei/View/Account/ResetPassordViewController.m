//
//  ResetPassordViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/9/15.
//
//

#import "ResetPassordViewController.h"
#import "ResetPasswordController.h"

@interface ResetPassordViewController()
{
    
}

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


- (IBAction)onNext:(id)sender;


@end

@implementation ResetPassordViewController


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
    self.navigationItem.title = @"找回密码";
    
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"返回"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:nil];
    self.navigationItem.backBarButtonItem=btnBack;
}

- (void) setupViews
{
    [[ResetPasswordController instance] startResetPassword];
}


- (IBAction)onNext:(id)sender
{
    NSString* text = self.emailTextField.text;
    
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if (text.length == 11 && [text rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        [ResetPasswordController instance].phone = text;
    }
    else
    {
        [ResetPasswordController instance].email = text;
    }
    
    [self performSegueWithIdentifier:@"ShowResetPasswordResultViewController" sender:self];
}


@end
