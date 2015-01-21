//
//  TeacherViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/8/15.
//
//

#import "TeacherViewController.h"
#import "TeacherTableViewCell.h"
#import "EFei.h"
#import "UserCommand.h"
#import "UIColor+Hex.h"

#define SubjectLabelTextColor @"#4d71aa"
#define TeacherTableViewCellId @"TeacherTableViewCellId"

@interface TeacherViewController()
{
    NSArray* _teachers;
}

@end


@implementation TeacherViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupData];
    [self setupNavigator];
    [self setupViews];
    
    [self getTeachers];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void) setupNavigator
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的老师";
}

- (void) setupViews
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void) setupData
{
    _teachers = [EFei instance].user.teachers;
}

- (void) getTeachers
{
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
      
        [self setupData];
        [self.tableView reloadData];
        
    };
    [GetTeachersCommand executeWithCompleteHandler:handler];
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


- (void)onDeleteTeacher:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    
    Teacher* teacher = [_teachers objectAtIndex:indexPath.row];
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        if(success)
        {
            [self setupData];
            [self.tableView reloadData];
        }
        
    };
    [RemoveTeacherCommand executeWithTeacher:teacher completeHandler:handler];
}


#pragma mark -- TableView

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _teachers.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherTableViewCell* cell = (TeacherTableViewCell*)[tableView dequeueReusableCellWithIdentifier:TeacherTableViewCellId forIndexPath:indexPath];
    Teacher* teacher = [_teachers objectAtIndex:indexPath.row];
    cell.subjectLabel.text = teacher.subjectName;
    cell.subjectLabel.textColor = [UIColor colorWithHexString:SubjectLabelTextColor];
    cell.schoolLabel.text = teacher.school;
    cell.nameLabel.text = teacher.name;
    
    [cell.deleteButton addTarget:self action:@selector(onDeleteTeacher:event:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell resetUI];
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        Teacher* teacher = [_teachers objectAtIndex:indexPath.row];
        CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
            
            if(success)
            {
                [self setupData];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
            }
            
        };
        [RemoveTeacherCommand executeWithTeacher:teacher completeHandler:handler];
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


@end
