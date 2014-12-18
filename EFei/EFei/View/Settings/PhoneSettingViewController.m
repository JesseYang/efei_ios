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
}

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation PhoneSettingViewController


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
}

- (void) setupNavigationBar
{
    self.navigationItem.title = @"手机设置";
    
    
    self.emailLabel.text = [NSString stringWithFormat:@"您的手机号为: %@", [EFei instance].user.mobile];
}

@end
