//
//  SearchView.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/12/14.
//
//

#import "SearchView.h"

#define TableViewCellId @"TableViewCellId"

@interface SearchView()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
//    UIView* _searchBar;
    
    UITextField* _textField;
    UITableView* _tableView;
    
    NSArray* _searchResult;
    
    NSLayoutConstraint* _heightConstraint;
}

- (void) setupUI;

- (void) textFieldDidChange:(id)sender;
- (void) onAdd:(id)sender;

@end

@implementation SearchView

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupUI];
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUI];
    }
    
    return self;
}

- (void) setupUI
{
    self.backgroundColor = [UIColor clearColor];

    [self setupSearchBar];
    [self addSubview:_searchBar];
    
    [self setupTableView];
    [self addSubview:_tableView];
    
    NSDictionary *viewsDictionary = @{@"searchBar":_searchBar,
                                      @"tableView":_tableView};
    NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[searchBar(50)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    
    [_searchBar addConstraints:constraintV];
    
    NSArray *constraintPosH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[searchBar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *constraintPosV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[searchBar]-1-[tableView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    
    NSArray *tableViewConstraintPosH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];

    [self addConstraints:constraintPosH];
    [self addConstraints:constraintPosV];
    [self addConstraints:tableViewConstraintPosH];
    
    
    _heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:0.0
                                                      constant:51];
    [self addConstraint:_heightConstraint];
}

-(void) setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    float height = 51 + _searchResult.count * 44;
    [_heightConstraint setConstant:height];
    
    [self layoutIfNeeded];
}

- (void) setupSearchBar
{
    _searchBar = [[UIView alloc] init];
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    UIImageView* iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_question_topic_edit.png"]];
    iconView.translatesAutoresizingMaskIntoConstraints = NO;
    [_searchBar addSubview:iconView];
    
    _textField = [[UITextField alloc] init];
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    _textField.delegate = self;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_searchBar addSubview:_textField];
    
    UIButton* addButton = [[UIButton alloc] init];
    addButton.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    addButton.layer.cornerRadius = 5;
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addButton.translatesAutoresizingMaskIntoConstraints = NO;
    [addButton addTarget:self action:@selector(onAdd:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:addButton];
    
    
    NSDictionary *viewsDictionary = @{@"iconView":iconView,
                                      @"textField":_textField,
                                      @"addButton":addButton
                                      };
    NSArray *iconConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[iconView(22)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    
    NSArray *iconConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[iconView(22)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    
    [iconView addConstraints:iconConstraintV];
    [iconView addConstraints:iconConstraintH];
    
    
    NSArray *textConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[textField(30)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    
    [_textField addConstraints:textConstraintV];
    
    
    NSArray *buttonConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[addButton(30)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    
    NSArray *buttonConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[addButton(60)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    
    [addButton addConstraints:buttonConstraintV];
    [addButton addConstraints:buttonConstraintH];
    
    NSArray *constraintPosH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[iconView]-10-[textField]-10-[addButton]-10-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *constraintPosV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-14-[iconView]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *constraintPosV2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[textField]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *constraintPosV3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[addButton]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    
    
    [_searchBar addConstraints:constraintPosV];
    [_searchBar addConstraints:constraintPosH];
    [_searchBar addConstraints:constraintPosV2];
    [_searchBar addConstraints:constraintPosV3];
    
}

- (void) setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellId];
    
}

- (void) resizeContent
{
    CGRect rect = self.frame;
    rect.size.height = 50 + 1 + _searchResult.count * 44;
    self.frame = rect;
    
    [self layoutIfNeeded];
    
    [_tableView reloadData];
}

- (void) onAdd:(id)sender
{
    [_textField endEditing:YES];
    
    if ([self.delegate respondsToSelector:@selector(searchView:didAddContent:)])
    {
        [self.delegate searchView:self didAddContent:_textField.text];
    }
    
    _textField.text = @"";
    _searchResult = nil;
    [self resizeContent];
    
    NSLog(@"%f", self.frame.size.height);
}


//- (void) textFieldDidEndEditing:(UITextField *)textField
- (void) textFieldDidChange:(id)sender
{
    if ([self.dataSource respondsToSelector:@selector(searchView:searchResultWithText:)])
    {
        _searchResult = [self.dataSource searchView:self searchResultWithText:_textField.text];
        
        [self resizeContent];
    }
}

#pragma mark - UITableView

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchResult.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellId forIndexPath:indexPath];
    cell.textLabel.text = [_searchResult objectAtIndex:indexPath.row];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _textField.text = [_searchResult objectAtIndex:indexPath.row];
    
    [self onAdd:nil];
}

@end
