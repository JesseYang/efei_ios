//
//  MainViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/2/14.
//
//

#import "MainViewController.h"
#import "UIColor+Hex.h"

#define NavigationBarBackgroundColor @"#4979BD"

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
    
    UIColor* efeiColor = [UIColor colorWithHexString:NavigationBarBackgroundColor];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : efeiColor }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : efeiColor }
                                             forState:UIControlStateSelected];
    
    for (UITabBarItem  *tab in self.tabBar.items)
    {
        tab.image = [tab.image imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
        tab.selectedImage = [tab.image imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    }
    
    [[UINavigationBar appearance] setBarTintColor:efeiColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]}];
    
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
