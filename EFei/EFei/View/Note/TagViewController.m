//
//  TagViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/12/14.
//
//

#import "TagViewController.h"

@interface TagViewController()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray* _tagTitles;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation TagViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _tagTitles = [NSArray arrayWithObjects:
                  @"不懂",
                  @"不会",
                  @"不对",
                  @"典型题",
                  @"计算错误",
                  @"概念错误",nil];
    
    self.navigationItem.title = @"标签编辑";
    
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
    return 6;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TagTableViewCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"icon_logo.png"];
    cell.textLabel.text = [_tagTitles objectAtIndex:indexPath.row];
    
    if (cell.accessoryView == nil)
    {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        imageView.image = nil;
        imageView.highlightedImage = [UIImage imageNamed:@"icon_logo.png"];
        cell.accessoryView = imageView;
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
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView* imageView = (UIImageView*)cell.accessoryView;
    
    imageView.highlighted = !imageView.highlighted;
}

//- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"Select a tag";
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
//    v.textLabel.font = [UIFont systemFontOfSize:15];
//    v.textLabel.textAlignment = NSTextAlignmentCenter;
//    v.backgroundView.backgroundColor = [UIColor whiteColor];
//}

@end
