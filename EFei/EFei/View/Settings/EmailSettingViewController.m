//
//  EmailSettingViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import "EmailSettingViewController.h"
#import "EFei.h"

@interface EmailSettingViewController()
{
    BOOL _shouldBack;
}

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeMailButton;

- (IBAction)onChangeEmail:(id)sender;

@end

@implementation EmailSettingViewController

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
    self.navigationItem.title = @"邮箱设置";
    
    self.emailLabel.text = [NSString stringWithFormat:@"您当前绑定的邮箱为: %@", [EFei instance].user.email];
}

- (void) setupView
{
    self.changeMailButton.layer.cornerRadius = 5;
}


- (IBAction)onChangeEmail:(id)sender
{
    _shouldBack = YES;
}

@end
