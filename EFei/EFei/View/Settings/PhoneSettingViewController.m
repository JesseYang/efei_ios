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
    
    self.emailLabel.text = [NSString stringWithFormat:@"Phone: %@", [EFei instance].user.mobile];
}

@end
