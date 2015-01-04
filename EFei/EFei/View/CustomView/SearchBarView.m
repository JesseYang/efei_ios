//
//  SearchBarView.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/4/15.
//
//

#import "SearchBarView.h"

#define TextFiledInsetX 35

@implementation InsetTextFiled

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds , TextFiledInsetX , 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds , TextFiledInsetX , 0);
}

@end


@interface SearchBarView()<UITextFieldDelegate>
{
    InsetTextFiled* _textField;
    UIImageView* _searchIcon;
    UIImageView* _clearIcon;
}

@end


@implementation SearchBarView

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
    
    
    _textField = [[InsetTextFiled alloc] init];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    _textField.delegate = self;
    [self addSubview:_textField];
    
    
    _searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_notebook_search.png"]];
    _searchIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_searchIcon];
    
    
    _clearIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_notebook_search.png"]];
    _clearIcon.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addSubview:_clearIcon];
    
    NSDictionary *viewsDictionary = @{@"textField":_textField,
                                      @"searchIcon":_searchIcon,
                                      @"clearIcon":_clearIcon};
    
    
    
    NSArray *textconstraintPosH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textField]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    NSArray *textconstraintPosV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textField]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    [self addConstraints:textconstraintPosH];
    [self addConstraints:textconstraintPosV];
    
    
    
    NSArray *iconConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[searchIcon(20)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    
    NSArray *iconConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[searchIcon(20)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    NSArray *iconConstraintPosX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[searchIcon]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    
    [_searchIcon addConstraints:iconConstraintV];
    [_searchIcon addConstraints:iconConstraintH];
    [self addConstraints:iconConstraintPosX];
    
    
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:_searchIcon
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0];
    [self addConstraint:c];
}


#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}


@end