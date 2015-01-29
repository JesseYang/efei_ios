//
//  NotebookSearchViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/4/15.
//
//

#import "NotebookSearchViewController.h"
#import "SearchBarView.h"
#import "NotebookCommand.h"
#import "EFei.h"
#import <IQKeyboardManager.h>

@interface NotebookSearchViewController()<UITableViewDataSource, UITableViewDelegate, SearchBarViewDelegate>
{
    NSArray* _histories;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NotebookSearchViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigator];
    [self setupData];
    [self setupViews];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.searchBarView.delegate = self;
    [self.searchBarView beginEditing];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    
}


- (void) setupNavigator
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

- (void) setupViews
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.searchBarView.delegate = self;
}

- (void) setupData
{
    _histories = [EFei instance].searchManager.searchHistroies;
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

- (void) searchNotebookWithKeyword:(NSString*)keyword
{
    if (keyword.length > 0)
    {
        [[EFei instance].searchManager addSearch:keyword];
        [self.navigationController popViewControllerAnimated:YES];
        
        if (self.doneBlock != nil)
        {
            self.doneBlock(keyword);
        }
    }
}

#pragma mark -- SearchBarView


- (void) searchBarViewDidTapped:(SearchBarView*)searchBarView
{
}

- (void) searchBarVieDidBeginEditing:(SearchBarView *)searchBarView
{
    [self setupData];
    [self.tableView reloadData];
}

- (void) searchBarVie:(SearchBarView*)searchBarView textDidChanged:(NSString*)text
{
}

- (void) searchBarViewSearchButtonTapped:(SearchBarView *)searchBarView withText:(NSString *)text
{
    [self searchNotebookWithKeyword:text];
}


#pragma mark -- TableView

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_histories.count > 0)
    {
        return _histories.count + 1;
    }
    else
    {
        return 0;
    }
    
    return 0;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"NotebookSearchTableViewCell" forIndexPath:indexPath];
    
    if (indexPath.row < _histories.count)
    {
        cell.textLabel.text = [_histories objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = @"清除历史记录";
    }
    
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
    if (indexPath.row >= _histories.count)
    {
        [[EFei instance].searchManager clearHistory];
        [self setupData];
        [self.tableView reloadData];
    }
    else
    {
        [self.searchBarView endEditing];
        NSString* keyword = [_histories objectAtIndex:indexPath.row];
        [self searchNotebookWithKeyword:keyword];
    }
    
}



@end