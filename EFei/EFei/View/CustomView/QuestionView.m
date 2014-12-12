//
//  QuestionView.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/9/14.
//
//

#import "QuestionView.h"
#import "Question.h"
#import "NoteTextView.h"

@interface QuestionView()
{
    NoteTextView* _questionContentView;
    NoteTextView* _questionAnswerView;
}

- (void) setupUI;

@end

@implementation QuestionView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUI];
    }
    return self;
}


- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

- (void) setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel* titleLabel = [UILabel new];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.backgroundColor = [UIColor colorWithRed:0.95 green:0.47 blue:0.48 alpha:1.0];
    titleLabel.text = @"题目";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIButton* answerButton = [UIButton new];
    answerButton.translatesAutoresizingMaskIntoConstraints = NO;
    answerButton.backgroundColor = [UIColor colorWithRed:0.95 green:0.47 blue:0.48 alpha:1.0];
    [answerButton setTitle:@"答案" forState:UIControlStateNormal];
    [self addSubview:answerButton];
    
    CGRect separatorRect = CGRectMake(10, 50, 320, 1);
    UIView* separator1 = [[UIView alloc] initWithFrame:separatorRect];
    separator1.backgroundColor = [UIColor blackColor];
    separator1.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:separator1];
    
    separatorRect.origin.y = 150;
    UIView* separator2 = [[UIView alloc] initWithFrame:separatorRect];
    separator2.backgroundColor = [UIColor lightGrayColor];
    separator2.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:separator2];
    
    CGRect contentRect = CGRectMake(0, 55, 320, 100);
    _questionContentView = [[NoteTextView alloc] initWithFrame:contentRect];
    _questionContentView.translatesAutoresizingMaskIntoConstraints = NO;
    _questionContentView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_questionContentView];
    
    CGRect answerRect = CGRectMake(0, 55, 320, 100);
    _questionAnswerView = [[NoteTextView alloc] initWithFrame:answerRect];
    _questionAnswerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_questionAnswerView];
    
    _questionContentView.text = @"测试，这是一个问题";
    _questionAnswerView.text = @"测试，这是一个答案";
    
    // constraint
    
    NSDictionary *viewsDictionary = @{@"titleLabel":titleLabel,
                                      @"answerButton":answerButton,
                                      @"separator1":separator1,
                                      @"separator2":separator2,
                                      @"questionContentView":_questionContentView,
                                      @"questionAnswerView": _questionAnswerView
                                      };
    NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel(30)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[titleLabel(60)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    [titleLabel addConstraints:constraintH];
    [titleLabel addConstraints:constraintV];
    
    NSArray *answerConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[answerButton(30)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    
    NSArray *answerConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[answerButton(60)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    
    
    [answerButton addConstraints:answerConstraintH];
    [answerButton addConstraints:answerConstraintV];
    
    
    
    NSArray *separatorConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[separator1(1)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    
    [separator1 addConstraints:separatorConstraintH];
    
    
    NSArray *separator2ConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[separator2(1)]"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:viewsDictionary];
    
    [separator2 addConstraints:separator2ConstraintH];
    
    NSArray *contentConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[questionContentView(80)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDictionary];
    
    [_questionContentView addConstraints:contentConstraintH];
    
    NSArray *questionAnswerConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[questionAnswerView(80)]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    
    [_questionAnswerView addConstraints:questionAnswerConstraintH];
    
    NSArray *constraintPosV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[titleLabel]-5-[separator1]-10-[questionContentView]-10-[separator2]-10-[questionAnswerView]"
                                                                      options:NSLayoutFormatAlignAllLeft
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *constraintPosH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[titleLabel]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *constraintPosH2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[answerButton]-20-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *separatorConstraintPos = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[separator1]-0-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    NSArray *separator2ConstraintPos = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[separator2]-0-|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDictionary];
    
    NSArray *contentConstraintPos = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[questionContentView]-20-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:viewsDictionary];
    NSArray *answerConstraintPos = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[questionAnswerView]-20-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:viewsDictionary];
    
    [self addConstraints:constraintPosV];
    [self addConstraints:constraintPosH];
    [self addConstraints:constraintPosH2];
    [self addConstraints:separatorConstraintPos];
    [self addConstraints:separator2ConstraintPos];
    [self addConstraints:contentConstraintPos];
    [self addConstraints:answerConstraintPos];
    
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:answerButton
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:titleLabel
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:0.0];
    
//    NSLayoutConstraint* separatorConstraint = [NSLayoutConstraint constraintWithItem:separator1
//                                                                  attribute:NSLayoutAttributeLeft
//                                                                  relatedBy:NSLayoutRelationEqual
//                                                                     toItem:titleLabel
//                                                                  attribute:NSLayoutAttributeLeft
//                                                                 multiplier:1.0
//                                                                   constant:0.0];
//    NSLayoutConstraint* separator2Constraint = [NSLayoutConstraint constraintWithItem:separator2
//                                                                           attribute:NSLayoutAttributeLeft
//                                                                           relatedBy:NSLayoutRelationEqual
//                                                                              toItem:separator1
//                                                                           attribute:NSLayoutAttributeLeft
//                                                                          multiplier:1.0
//                                                                            constant:0.0];
    
    [self addConstraint:constraint];
//    [self addConstraint:separatorConstraint];
//    [self addConstraint:separator2Constraint];
    
    
}

- (void) setQuestion:(Question *)question
{
    _question = question;
    
    [_questionContentView setNoteContent:_question.contents];
}


@end
