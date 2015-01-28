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
#import "SubjectViewController.h"
#import "UIColor+Hex.h"

#define SubjectLabelTextColor @"#4d71aa"

#define TeacherAddTableViewCellId @"TeacherAddTableViewCellId"

#define ShowTeacherAddViewControllerSegueId @"ShowTeacherAddViewController"
#define ShowSubjectViewControllerSegueId @"ShowSubjectViewController"

@interface TeacherSeachViewController()<SearchBarViewDelegate>
{
    SearchBarView* _searchBarView;
    
    NSArray* _teachers;
    
    SubjectType _currentSubjectType;
}

- (void) onBack:(id)sender;

- (void)onAddTeacher:(id)sender event:(id)event;

@end

@implementation TeacherSeachViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _currentSubjectType = SubjectTypeAll;
    
    [self setupData];
    [self setupNavigator];
    [self setupViews];
    [self updateRightBarButtonItem];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _searchBarView.hidden = NO;
}


- (void) setupNavigator
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem* leftBarButtonItem = [self barItemWithImage:[UIImage imageNamed:@"icon_setting_teacher_back.png"]
                                                             title:@"返回"
                                                            target:self
                                                            action:@selector(onBack:)];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                            target:nil
                                                                            action:nil];
    spacer.width = -10; // for example shift right bar button to the right
    
    self.navigationItem.leftBarButtonItems = @[spacer, leftBarButtonItem];
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
    
    float width = self.view.frame.size.width - 160;
    float height = 30;
    float x = (self.navigationController.navigationBar.frame.size.width - width) / 2;
    float y = 7;
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

- (void) updateRightBarButtonItem
{
    NSString* title = [[EFei instance].subjectManager subjectNameWithType:_currentSubjectType];
    self.navigationItem.rightBarButtonItem.title = title;
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

#pragma mark -- Navigation
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    _searchBarView.hidden = YES;
    
    if ([segue.identifier isEqualToString:ShowSubjectViewControllerSegueId])
    {
        SubjectViewController* subjectVC = (SubjectViewController*)segue.destinationViewController;
        subjectVC.subjectType = _currentSubjectType;
        subjectVC.doneBlock = ^(SubjectType type){
            
            _currentSubjectType = type;
            [self updateRightBarButtonItem];
            
        };
    }
}


#pragma mark -- SearchBarViewDelegate
- (void) searchBarVie:(SearchBarView *)searchBarView textDidChanged:(NSString *)text
{
    
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        [self setupData];
        [self.tableView reloadData];
        
    };
    
    [GetTeachersCommand executeWithSubject:_currentSubjectType name:text completeHandler:handler];
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
    cell.subjectLabel.text = teacher.subjectName;
    cell.subjectLabel.textColor = [UIColor colorWithHexString:SubjectLabelTextColor];
    cell.schoolLabel.text = teacher.school;
    cell.nameLabel.text = teacher.name;
    
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
