//
//  PhoneSettingViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import "PhoneSettingViewController.h"
#import "EFei.h"

@interface PhoneSettingViewController()
{
    BOOL _shouldBack;
}

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *changePhoneButton;


- (IBAction)onChangePhone:(id)sender;

@end

@implementation PhoneSettingViewController


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupView];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_shouldBack)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void) setupNavigationBar
{
    self.navigationItem.title = @"手机设置";
    
    
    self.emailLabel.text = [NSString stringWithFormat:@"您的手机号为: %@", [EFei instance].user.mobile];
}


- (void) setupView
{
    self.changePhoneButton.layer.cornerRadius = 5;
}

- (IBAction)onChangePhone:(id)sender
{
    _shouldBack = YES;
}

@end

