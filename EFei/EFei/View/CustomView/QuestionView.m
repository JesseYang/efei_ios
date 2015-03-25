//
//  QuestionView.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/9/14.
//
//

#import "QuestionView.h"
#import "Question.h"
#import "RichTextView.h"
#import "EFei.h"

@interface QuestionView()
{
    RichTextView* _questionContentView;
    RichTextView* _questionAnswerView;
    UIView*       _separator2;
    UIView*       _answerFlagView;
    
    UIImageView*  _answerImageView;
    
    NSLayoutConstraint* _descriptionHeightConstraint;
    NSLayoutConstraint* _answerHeightConstraint;
    
    float _height;
}

- (void) setupUI;

- (void) onAnswerButton:(id)sender;

- (void) showAnswer;
- (void) hideAnswer;

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
    titleLabel.text = @"题目";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIImageView* imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.image = [UIImage imageNamed:@"icon_question_show_answer.png"];
    [self addSubview:imageView];
    _answerImageView = imageView;
    
    UIButton* answerButton = [UIButton new];
    answerButton.translatesAutoresizingMaskIntoConstraints = NO;
    [answerButton setTitleColor:[EFei instance].efeiColor forState:UIControlStateNormal];
    [answerButton setTitle:@"答案" forState:UIControlStateNormal];
    [answerButton addTarget:self action:@selector(onAnswerButton:) forControlEvents:UIControlEventTouchUpInside];
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
    _separator2 = separator2;
    
    UIView* flagView = [UIView new];
    flagView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:flagView];
    _answerFlagView = flagView;
    [self setupAnswerFlagView];
    
    CGRect contentRect = CGRectMake(0, 55, 320, 100);
    _questionContentView = [[RichTextView alloc] initWithFrame:contentRect];
    _questionContentView.translatesAutoresizingMaskIntoConstraints = NO;
    _questionContentView.scrollEnabled = NO;
    [self addSubview:_questionContentView];
    
    CGRect answerRect = CGRectMake(0, 55, 320, 100);
    _questionAnswerView = [[RichTextView alloc] initWithFrame:answerRect];
    _questionAnswerView.translatesAutoresizingMaskIntoConstraints = NO;
    _questionAnswerView.scrollEnabled = NO;
    [self addSubview:_questionAnswerView];
    
    _questionContentView.text = @"测试，这是一个问题";
    _questionAnswerView.text = @"测试，这是一个答案";
    
    // constraint
    
    NSDictionary *viewsDictionary = @{@"titleLabel":titleLabel,
                                      @"answerButton":answerButton,
                                      @"separator1":separator1,
                                      @"separator2":separator2,
                                      @"questionContentView":_questionContentView,
                                      @"questionAnswerView": _questionAnswerView,
                                      @"answerImageView": _answerImageView,
                                      @"answerFlagView": _answerFlagView
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
    
    
    NSArray *answerImageConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[answerImageView(10)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    
    NSArray *answerImageConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[answerImageView(20)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    
    
    [_answerImageView addConstraints:answerImageConstraintH];
    [_answerImageView addConstraints:answerImageConstraintV];
    
    
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
    
    
    NSArray *answerFlagConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[answerFlagView(20)]"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDictionary];
    
    NSArray *answerFlagConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[answerFlagView(60)]"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDictionary];
    
    
    [_answerFlagView addConstraints:answerFlagConstraintH];
    [_answerFlagView addConstraints:answerFlagConstraintV];
    
//    NSArray *contentConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[questionContentView(100)]"
//                                                                             options:0
//                                                                             metrics:nil
//                                                                               views:viewsDictionary];
    
//    [_questionContentView addConstraints:contentConstraintH];
    
    _descriptionHeightConstraint = [NSLayoutConstraint constraintWithItem:_questionContentView
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:0.f
                                                                 constant:100];
    
    [self addConstraint:_descriptionHeightConstraint];
    
    
    _answerHeightConstraint = [NSLayoutConstraint constraintWithItem:_questionAnswerView
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:0.f
                                                                 constant:100];
    
    [self addConstraint:_answerHeightConstraint];
    
//    NSArray *questionAnswerConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[questionAnswerView(80)]"
//                                                                          options:0
//                                                                          metrics:nil
//                                                                            views:viewsDictionary];
//    
//    [_questionAnswerView addConstraints:questionAnswerConstraintH];
    
    NSArray *constraintPosV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[titleLabel]-5-[separator1]-10-[questionContentView]-10-[separator2]-10-[answerFlagView]-5-[questionAnswerView]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *constraintPosH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[titleLabel]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *constraintPosH2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[answerImageView]-2-[answerButton]-20-|"
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
    
    NSArray *contentConstraintPos = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[questionContentView]-10-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:viewsDictionary];
    NSArray *answerConstraintPos = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[questionAnswerView]-10-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:viewsDictionary];
    
    
    NSArray *answerFlagConstraintPos = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[answerFlagView]"
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
    [self addConstraints:answerFlagConstraintPos];
    
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
    
    
    NSLayoutConstraint* constraint2 = [NSLayoutConstraint constraintWithItem:_answerImageView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:answerButton
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0
                                                                   constant:0.0];
    
    
    [self addConstraint:constraint2];
}

- (void) setupAnswerFlagView
{
    UIImageView* flagImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    flagImageView.translatesAutoresizingMaskIntoConstraints = NO;
    flagImageView.image = [UIImage imageNamed:@"icon_question_answer_flag.png"];
    [_answerFlagView addSubview:flagImageView];
    
    UILabel* flagLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 45, 20)];
    flagLabel.translatesAutoresizingMaskIntoConstraints = NO;
    flagLabel.font = [UIFont systemFontOfSize:15];
    flagLabel.textColor = [UIColor lightGrayColor];
    flagLabel.text = @"答案";
    [_answerFlagView addSubview:flagLabel];
    
    NSDictionary *viewsDictionary = @{@"flagImageView":flagImageView,
                                      @"flagLabel":flagLabel
                                      };
    NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[flagImageView(20)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    
    NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[flagImageView(12)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    
    [flagImageView addConstraints:constraintH];
    [flagImageView addConstraints:constraintV];
    
    NSArray *constraintH2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[flagLabel(20)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    
    NSArray *constraintV2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[flagLabel(45)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    
    [flagLabel addConstraints:constraintH2];
    [flagLabel addConstraints:constraintV2];
    
    NSArray *constraintPosV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[flagImageView]"
                                                                      options:0
                                                                      metrics:nil
                                                                         views:viewsDictionary];
    NSArray *constraintPosV2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[flagLabel]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    
    NSArray *constraintPosH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[flagImageView]-3-[flagLabel]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    
    [_answerFlagView addConstraints:constraintPosH];
    [_answerFlagView addConstraints:constraintPosV1];
    [_answerFlagView addConstraints:constraintPosV2];
}


-(void) setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    CGSize textViewSize = [_questionContentView sizeThatFits:CGSizeMake(_questionContentView.frame.size.width, FLT_MAX)];
    [_descriptionHeightConstraint setConstant:textViewSize.height];
    
    textViewSize = [_questionAnswerView sizeThatFits:CGSizeMake(_questionAnswerView.frame.size.width, FLT_MAX)];
    [_answerHeightConstraint setConstant:textViewSize.height];
    
    [self layoutIfNeeded];
}

- (float) viewHeight
{
    CGSize textViewSize = [_questionContentView sizeThatFits:CGSizeMake(_questionContentView.frame.size.width, FLT_MAX)];
    
    float height = textViewSize.height + 60;
    
    if (!_questionAnswerView.hidden)
    {
        CGSize textViewSize = [_questionAnswerView sizeThatFits:CGSizeMake(_questionAnswerView.frame.size.width, FLT_MAX)];
        height += (textViewSize.height + 60);
    }
    
    return height;
}

- (void) setQuestion:(Question *)question
{
    _question = question;
    
    NSMutableArray* array = [[NSMutableArray alloc] initWithArray:_question.contents];
    for (int i=0; i<_question.items.count; i++)
    {
        NSString* item = [_question.items objectAtIndex:i];
        NSString* str = [NSString stringWithFormat:@"(%c) %@", 'A'+i, item];
        [array addObject:str];
    }
    
    _questionContentView.imagePath = _question.imagePath;
    [_questionContentView setNoteContent:array];
    
    if (_question.answerContents.count == 0 && _question.answer == -1)
    {
        [self hideAnswer];
    }
    else
    {
        NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:(_question.answerContents.count+1)];
        if (_question.answer != -1)
        {
            char c = _question.answer + 'A';
            NSString* ans = [[NSString alloc] initWithFormat:@"%c", c];
            [array addObject:ans];
        }
        
        if (_question.answerContents.count > 0)
        {
            [array addObjectsFromArray:_question.answerContents];
        }
        
        _questionAnswerView.imagePath = _question.imagePath;
        [_questionAnswerView setNoteContent:array];
    }
}

- (void) onAnswerButton:(id)sender
{
    if (_height <= 0)
    {
        _height = self.frame.size.height;
    }
    
    if (_questionAnswerView.hidden)
    {
        [self showAnswer];
    }
    else
    {
        [self hideAnswer];
    }
}

- (void) showAnswer
{
    if (_question.answerContents.count == 0 && _question.answer == -1)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"答案未上传或未公开"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    _answerImageView.image = [UIImage imageNamed:@"icon_question_show_answer.png"];
    
    float delta = _height - (_questionContentView.frame.origin.y + _questionContentView.frame.size.height);
    
    CGRect rect = self.frame;
    rect.size.height += delta;
    self.frame = rect;
    
    _questionAnswerView.hidden = NO;
    _separator2.hidden = NO;
    _answerFlagView.hidden = NO;
    
    if ([self.delegate respondsToSelector:@selector(questionView:showHideAnswer:withHeightChange:)])
    {
        [self.delegate questionView:self showHideAnswer:YES withHeightChange:delta];
    }
}

- (void) hideAnswer
{
    _answerImageView.image = [UIImage imageNamed:@"icon_question_hide_answer.png"];
    
    float delta = _height - (_questionContentView.frame.origin.y + _questionContentView.frame.size.height);
    CGRect rect = self.frame;
    rect.size.height -= delta;
    self.frame = rect;
    
    _questionAnswerView.hidden = YES;
    _separator2.hidden = YES;
    _answerFlagView.hidden = YES;
    
    if ([self.delegate respondsToSelector:@selector(questionView:showHideAnswer:withHeightChange:)])
    {
        [self.delegate questionView:self showHideAnswer:NO withHeightChange:-1*delta];
    }
}


@end
