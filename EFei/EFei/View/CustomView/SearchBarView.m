//
//  SearchBarView.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/4/15.
//
//

#import "SearchBarView.h"
#import "UIColor+Hex.h"

#define TextFieldBackgroundColor @"#2e64a9"
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
    UIButton* _clearIcon;
}

- (void) onTapped:(id)sender;
- (void) onClear:(id)sender;
- (void) onTextChanged:(id)sender;

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

- (void) beginEditing
{
    [_textField becomeFirstResponder];
}

- (void) endEditing
{
    [_textField resignFirstResponder];
}

- (void) setupUI
{
    self.backgroundColor = [UIColor clearColor];
    
    
    _textField = [[InsetTextFiled alloc] init];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.textColor = [UIColor whiteColor];
    _textField.backgroundColor = [UIColor colorWithHexString:TextFieldBackgroundColor];
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeySearch;
    [_textField addTarget:self action:@selector(onTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_textField];
    
    
    _searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_notebook_search.png"]];
    _searchIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_searchIcon];
    
    
    _clearIcon = [[UIButton alloc] init];
    _clearIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [_clearIcon setImage:[UIImage imageNamed:@"icon_question_topic_delete.png"] forState:UIControlStateNormal];
    [_clearIcon addTarget:self action:@selector(onClear:) forControlEvents:UIControlEventTouchUpInside];
    _clearIcon.hidden = YES;
    
    [self addSubview:_clearIcon];
    
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
    
    
    NSArray *cleanIconConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[clearIcon(20)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    
    NSArray *cleanIconConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[clearIcon(20)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    NSArray *cleanIconConstraintPosX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[clearIcon]-10-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    
    [_clearIcon addConstraints:cleanIconConstraintV];
    [_clearIcon addConstraints:cleanIconConstraintH];
    [self addConstraints:cleanIconConstraintPosX];
    
    
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:_searchIcon
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0];
    [self addConstraint:c];
    
    
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:_clearIcon
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0];
    [self addConstraint:c1];
    
    
    
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    [self addGestureRecognizer:recognizer];
    
    self.editing = NO;
}

- (void) onTapped:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(searchBarViewDidTapped:)])
    {
        [self.delegate searchBarViewDidTapped:self];
    }
}

- (void) setEditing:(BOOL)editing
{
    _editing = editing;
    
    _textField.userInteractionEnabled = _editing;
//    _textField.text = @"";
}

- (void) onClear:(id)sender
{
    _textField.text = @"";
    _clearIcon.hidden = YES;
    
    if ([self.delegate respondsToSelector:@selector(searchBarViewDidClearText:)])
    {
        [self.delegate searchBarViewDidClearText:self];
    }
}

- (void) onTextChanged:(id)sender
{
    _clearIcon.hidden = (_textField.text.length == 0);
}

#pragma mark UITextFieldDelegate


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarVieDidBeginEditing:)])
    {
        [self.delegate searchBarVieDidBeginEditing:self];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarViewSearchButtonTapped:withText:)])
    {
        [self.delegate searchBarViewSearchButtonTapped:self withText:textField.text];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _textField)
    {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

@end