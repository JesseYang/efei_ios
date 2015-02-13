//
//  TeacherClassViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/8/15.
//
//

#import "TeacherClassViewController.h"
#import "Teacher.h"
#import "UserCommand.h"
#import "ToastView.h"

#define TeacherClassTableViewCellId @"TeacherClassTableViewCellId"

@interface TeacherClassViewController()
{
    
}

@end

@implementation TeacherClassViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
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
    self.navigationItem.title = @"选择班级";
}

- (void) setupViews
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void) addTeacherWithClassIndex:(NSInteger)index
{
    TeacherClass* tc = [self.teacher.classes objectAtIndex:index];
    self.teacher.classId = tc.classId;
    
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        if (success)
        {
            [ToastView showMessage:kErrorMessageAddTeacherSuccess];
        }
        
        [self.navigationController popToRootViewControllerAnimated:YES];
//        [self.navigationController popViewControllerAnimated:NO];
//        [self.navigationController popViewControllerAnimated:YES];
    };
    
    [AddTeacherCommand executeWithTeacher:self.teacher completeHandler:handler];
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

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.teacher.classes.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:TeacherClassTableViewCellId forIndexPath:indexPath];
    TeacherClass* tc = [self.teacher.classes objectAtIndex:indexPath.row];
    cell.textLabel.text = tc.name;
    
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
    [self addTeacherWithClassIndex:indexPath.row];
}





@end