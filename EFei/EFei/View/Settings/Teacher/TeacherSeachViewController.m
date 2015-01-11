//
//  TeacherSeachViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/8/15.
//
//

#import "TeacherSeachViewController.h"
#import "TeacherAddTableViewCell.h"
#import "EFei.h"
#import "SearchTeacherController.h"
#import "SearchBarView.h"
#import "UserCommand.h"

#define TeacherAddTableViewCellId @"TeacherAddTableViewCellId"

#define ShowTeacherAddViewControllerSegueId @"ShowTeacherAddViewController"

@interface TeacherSeachViewController()<SearchBarViewDelegate>
{
    SearchBarView* _searchBarView;
    
    NSArray* _teachers;
}

- (void) onBack:(id)sender;

- (void)onAddTeacher:(id)sender event:(id)event;

@end

@implementation TeacherSeachViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupData];
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
    
    self.navigationItem.leftBarButtonItem = [self barItemWithImage:[UIImage imageNamed:@"icon_setting_teacher_back.png"]
                                                             title:@"返回"
                                                            target:self
                                                            action:@selector(onBack:)];
}

- (UIBarButtonItem*)barItemWithImage:(UIImage*)image title:(NSString*)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, image.size.width + 50, image.size.height);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    
    CGSize imageSize = button.imageView.frame.size;
//    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, imageSize.width/2, 0.0, 0.0);
    button.imageEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width/2, 0.0, 0.0);
    
    return barButtonItem;
}

- (void) setupViews
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    float width = self.view.frame.size.width - 140;
    float height = 30;
    float x = (self.navigationController.navigationBar.frame.size.width - width) / 2;
    float y = 5;
    CGRect rect = CGRectMake(x, y, width, height);
    _searchBarView = [[SearchBarView alloc] initWithFrame:rect];
    _searchBarView.delegate = self;
    _searchBarView.editing = YES;
    
    [self.navigationController.navigationBar addSubview:_searchBarView];
}

- (void) setupData
{
    _teachers = [SearchTeacherController instance].searchedTeachers;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Force your tableview margins (this may be a bad idea)
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark -- Action

- (void) onBack:(id)sender
{
    [_searchBarView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onAddTeacher:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    [[SearchTeacherController instance] selectSearchedTeacher:indexPath.row];
    
    [self performSegueWithIdentifier:ShowTeacherAddViewControllerSegueId sender:self];
}

#pragma mark -- SearchBarViewDelegate
- (void) searchBarVie:(SearchBarView *)searchBarView textDidChanged:(NSString *)text
{
    
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        [self setupData];
        [self.tableView reloadData];
        
    };
    
    [GetTeachersCommand executeWithSubject:0 name:text completeHandler:handler];
}

- (void) searchBarViewDidTapped:(SearchBarView *)searchBarView
{
    
}

#pragma mark -- TableView

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _teachers.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherAddTableViewCell* cell = (TeacherAddTableViewCell*)[tableView dequeueReusableCellWithIdentifier:TeacherAddTableViewCellId forIndexPath:indexPath];
    
    [cell.addButton addTarget:self action:@selector(onAddTeacher:event:) forControlEvents:UIControlEventTouchUpInside];
    
    Teacher* teacher = [_teachers objectAtIndex:indexPath.row];
    cell.textLabel.text = teacher.name;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



@end
