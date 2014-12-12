//
//  SearchView.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/12/14.
//
//

#import "SearchView.h"

@interface SearchView()
{
//    UIView* _searchBar;
    
    UITextField* _textField;
}

- (void) setupUI;

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
    
    NSDictionary *viewsDictionary = @{@"searchBar":_searchBar
                                      };
    NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[searchBar(50)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    
    [_searchBar addConstraints:constraintV];
    
    NSArray *constraintPosH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[searchBar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *constraintPosV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[searchBar]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    [self addConstraints:constraintPosH];
    [self addConstraints:constraintPosV];
}

- (void) setupSearchBar
{
    _searchBar = [[UIView alloc] init];
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    UIImageView* iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_logo.png"]];
    iconView.translatesAutoresizingMaskIntoConstraints = NO;
    [_searchBar addSubview:iconView];
    
    _textField = [[UITextField alloc] init];
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
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
    NSArray *iconConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[iconView(30)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    
    NSArray *iconConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[iconView(30)]"
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
                                                                      options:NSLayoutFormatAlignAllTop
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *constraintPosV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[iconView]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    
    [_searchBar addConstraints:constraintPosV];
    [_searchBar addConstraints:constraintPosH];
    
}

- (void) onAdd:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(searchView:didAddContent:)])
    {
        [self.delegate searchView:self didAddContent:_textField.text];
    }
    
    _textField.text = @"";
}

@end
