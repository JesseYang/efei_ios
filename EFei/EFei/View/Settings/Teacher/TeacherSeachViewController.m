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

#define TeacherAddTableViewCellId @"TeacherAddTableViewCellId"

#define ShowTeacherAddViewControllerSegueId @"ShowTeacherAddViewController"

@interface TeacherSeachViewController()
{
}

- (void)onAddTeacher:(id)sender event:(id)event;

@end

@implementation TeacherSeachViewController

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
}

- (void) setupViews
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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

- (void)onAddTeacher:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    [[SearchTeacherController instance] selectSearchedTeacher:indexPath.row];
    
    [self performSegueWithIdentifier:ShowTeacherAddViewControllerSegueId sender:self];
}


#pragma mark TableView

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherAddTableViewCell* cell = (TeacherAddTableViewCell*)[tableView dequeueReusableCellWithIdentifier:TeacherAddTableViewCellId forIndexPath:indexPath];
    cell.textLabel.text = @"";
    [cell.addButton addTarget:self action:@selector(onAddTeacher:event:) forControlEvents:UIControlEventTouchUpInside];
    
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
