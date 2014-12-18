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
}

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

- (IBAction)onChangeEmail:(id)sender;

@end

@implementation EmailSettingViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
}

- (void) setupNavigationBar
{
    self.navigationItem.title = @"邮箱设置";
    
    self.emailLabel.text = [NSString stringWithFormat:@"Email: %@", [EFei instance].user.email];
}


- (IBAction)onChangeEmail:(id)sender
{
    
}

@end
