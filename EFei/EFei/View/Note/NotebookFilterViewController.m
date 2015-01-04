//
//  NotebookFilterViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/4/15.
//
//

#import "NotebookFilterViewController.h"


@implementation NotebookFilterViewController

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
    self.navigationItem.title = self.filter.name;
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

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filter.items.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FilterTableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.filter.items objectAtIndex:indexPath.row];
    
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
    self.filter.selectedIndex = indexPath.row;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.doneBlock(self.filter);
}



@end