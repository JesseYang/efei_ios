//
//  MainViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/2/14.
//
//

#import "MainViewController.h"

#define ShowQRScanViewControllerSegueId @"ShowQRScanViewController"

@interface MainViewController()<UITabBarControllerDelegate>
{
    
}

@end

@implementation MainViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedIndex = 1;
    
    self.delegate = self;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    return index != 0;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [tabBar.items indexOfObject:item];
    NSLog(@"selected item at index: %ld", index);
    if (index == 0)
    {
        [self performSegueWithIdentifier:ShowQRScanViewControllerSegueId sender:self];
    }
}

@end
