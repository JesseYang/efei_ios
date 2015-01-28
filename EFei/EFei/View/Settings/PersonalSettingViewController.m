//
//  PersonalSettingViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import "PersonalSettingViewController.h"
#import "EFei.h"
#import "PersonalSettingController.h"
#import "UserCommand.h"

#define NavigationBarTilte @"个人设置"

#define PersonalSettingsImage @"icon_settings_personal.jpg"
#define RightArrowImage @"line_icon_arrow.png"

#define CellReuseIdentifier @"CellReuseIdentifier"

#define TitleName @"姓名"
#define TitleEmail @"邮箱"
#define TitlePhone @"手机号"


@interface PersonalSettingViewController()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray*      _titlesArray;
    NSArray*      _contentArray;
    NSArray*      _actionArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation PersonalSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupData];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getUserInfo];
}

- (void) setupNavigationBar
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = NavigationBarTilte;
    
}

- (void) setupData
{
    _titlesArray = @[TitleName, TitleEmail, TitlePhone];
    
    _actionArray = @[@"onNameClicked", @"onEmailClicked", @"onPhoneClicked"];
    
    User* user = [EFei instance].user;
    _contentArray = @[user.name, user.email, user.mobile];
}

- (void) getUserInfo
{
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        [self setupData];
        [self.tableView reloadData];
        
    };
    [GetUserInfoCommand executeWithCompleteHandler:handler];
}


#pragma mark - UITableView


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titlesArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 24.0f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellReuseIdentifier];
    }
    
    NSString* title = [_titlesArray objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = title;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width/2, cell.frame.size.height)];
    label.textAlignment = NSTextAlignmentRight;
    NSString* content = [_contentArray objectAtIndex:indexPath.row];
    label.text = content;
    cell.accessoryView = label;
    
    return cell;
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString* actionString = [_actionArray objectAtIndex:indexPath.row];
    
    SEL selector = NSSelectorFromString(actionString);
    IMP imp = [self methodForSelector:selector];
    void (*func)(id, SEL) = (void *)imp;
    func(self, selector);
}


#pragma mark - Actions

- (void) onNameClicked
{
    [self performSegueWithIdentifier:@"ShowNameEditingViewController" sender:self];
}

- (void) onEmailClicked
{
//    [PersonalSettingController instance].type = PersonalSettingTypeEmail;
//    
//    [self showSettings];
    
    if ([EFei instance].user.email.length > 0)
    {
        [self performSegueWithIdentifier:@"ShowEmailSettingViewController" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"ShowEmailEditingViewController" sender:self];
    }
}

- (void) onPhoneClicked
{
//    [PersonalSettingController instance].type = PersonalSettingTypePhone;
//    
//    [self showSettings];
    
    if ([EFei instance].user.mobile.length > 0)
    {
        [self performSegueWithIdentifier:@"ShowPhoneSettingViewController" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"ShowPhoneEditingViewController" sender:self];
    }
}

- (void) showSettings
{
    if ([PersonalSettingController instance].setting.length > 0)
    {
        [self performSegueWithIdentifier:@"ShowEmailSettingViewController" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"ShowEmailEditingViewController" sender:self];
    }
}

@end

