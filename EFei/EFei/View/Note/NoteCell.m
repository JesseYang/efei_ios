//
//  NoteCell.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/30/14.
//
//

#import "NoteCell.h"
#import "Note.h"
#import "RichTextView.h"

#define SwipeDistance 80

@interface NoteCell()
{
    RichTextView* _richTextView;
}

- (void) setupUI;

- (void) onSwipe:(UISwipeGestureRecognizer*)recognizer;

- (void) onSelected:(UIButton*) button;

- (void) resetUI;
- (void) swipToExport;
- (void) swipToDelete;
- (void) swipToSelect;

@end

@implementation NoteCell

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
    }
    
    return self;
}


- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        [self setupUI];
    }
    
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void) setupUI
{
    if (self.noteContentView == nil)
    {
        return;
    }
    
    [self.selectButton addTarget:self action:@selector(onSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UISwipeGestureRecognizer* leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(onSwipe:)];
    UISwipeGestureRecognizer* rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(onSwipe:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.noteContentView addGestureRecognizer:leftRecognizer];
    [self.noteContentView addGestureRecognizer:rightRecognizer];
    
    _richTextView = [[RichTextView alloc] initWithFrame:self.bounds];
    _richTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _richTextView.userInteractionEnabled = NO;
    [self.noteContentView addSubview:_richTextView];
    
    
    
    NSLayoutConstraint *cW = [NSLayoutConstraint constraintWithItem:_richTextView
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.noteContentView
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1
                                                          constant:0];
    [self.noteContentView addConstraint:cW];
    
    NSLayoutConstraint *cH = [NSLayoutConstraint constraintWithItem:_richTextView
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.noteContentView
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1
                                                          constant:0];
    [self.noteContentView addConstraint:cH];
    
    NSDictionary *viewsDictionary = @{@"richTextView":_richTextView};
//    NSArray *textconstraintPosH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[richTextView]|"
//                                                                          options:0
//                                                                          metrics:nil
//                                                                            views:viewsDictionary];
    NSArray *textconstraintPosV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[richTextView]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictionary];
    
//    [self.noteContentView addConstraints:textconstraintPosH];
    [self.noteContentView addConstraints:textconstraintPosV];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
//    _richTextView.frame = self.noteContentView.bounds;
}

//- (void) layoutSubviews
//{
//    [super layoutSubviews];
//    
//    float x = 0;
//    
//    switch (self.status)
//    {
//        case NoteCellStatusNone:
//            x = 0;
//            break;
//            
//        case NoteCellStatusExport:
//            x = SwipeDistance;
//            break;
//            
//        case NoteCellStatusDelete:
//            x = -SwipeDistance;
//            break;
//            
//        case NoteCellStatusSelect:
//            x = SwipeDistance;
//            break;
//            
//        default:
//            break;
//    }
//    
//    CGRect rect = self.frame;
//    rect.origin.x = x;
//    rect.origin.y = 0;
//    self.noteContentView.frame = rect;
//    
//    CGRect exportRect = self.exportButton.frame;
//    exportRect.origin.x = 0;
//    exportRect.origin.y = 0;
//    self.exportButton.frame = exportRect;
//    
//    CGRect selectRect = self.selectButton.frame;
//    selectRect.origin.x = 0;
//    selectRect.origin.y = 0;
//    self.selectButton.frame = exportRect;
//    
//    CGRect deleteRect = self.deleteButton.frame;
//    deleteRect.origin.x = self.frame.size.width - deleteRect.size.width;
//    deleteRect.origin.y = 0;
//    self.deleteButton.frame = deleteRect;
//    
//    
//    CGRect tvRect = _richTextView.frame;
//    tvRect.size = self.frame.size;
//    _richTextView.frame = tvRect;
//}

- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (self.selected)
    {
        [self.selectButton setImage:[UIImage imageNamed:@"icon_notebook_select.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.selectButton setImage:[UIImage imageNamed:@"icon_notebook_unselect.png"] forState:UIControlStateNormal];
    }
}

- (void) onSelected:(UIButton *)button
{
    if (self.selected)
    {
        [button setImage:[UIImage imageNamed:@"icon_notebook_unselect.png"] forState:UIControlStateNormal];
    }
    else
    {
        [button setImage:[UIImage imageNamed:@"icon_notebook_select.png"] forState:UIControlStateNormal];
    }
    
    self.selected = !self.selected;
}

- (void) onSwipe:(UISwipeGestureRecognizer *)recognizer
{
    if (self.status == NoteCellStatusSelect)
    {
        return;
    }
    
    switch (recognizer.direction)
    {
        case UISwipeGestureRecognizerDirectionLeft:
            if (self.status == NoteCellStatusNone)
            {
                self.status = NoteCellStatusDelete;
            }
            else if (self.status != NoteCellStatusDelete)
            {
                self.status = NoteCellStatusNone;
            }
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            if (self.status == NoteCellStatusNone)
            {
                self.status = NoteCellStatusExport;
            }
            else if (self.status != NoteCellStatusExport)
            {
                self.status = NoteCellStatusNone;
            }
            break;
            
        default:
            break;
    }
}

- (void) setStatus:(NoteCellStatus)status
{
    if (status == _status)
    {
        return;
    }
    _status = status;
    
    switch (self.status)
    {
        case NoteCellStatusNone:
            [self resetUI];
            break;
            
        case NoteCellStatusExport:
            self.exportButton.hidden = NO;
            self.selectButton.hidden = YES;
            [self swipToExport];
            break;
            
        case NoteCellStatusDelete:
            [self swipToDelete];
            break;
            
        case NoteCellStatusSelect:
            self.exportButton.hidden = YES;
            self.selectButton.hidden = NO;
            [self swipToSelect];
            break;
            
        default:
            break;
    }
    
}

- (void) setStatusWithNoAnimation:(NoteCellStatus)status
{
    if (status == _status)
    {
        return;
    }
    _status = status;
    
    CGRect rect = self.noteContentView.frame;
    switch (self.status)
    {
        case NoteCellStatusNone:
            rect.origin.x = 0;
            break;
            
        case NoteCellStatusExport:
            rect.origin.x = SwipeDistance;
            break;
            
        case NoteCellStatusDelete:
            rect.origin.x = -SwipeDistance;
            break;
            
        case NoteCellStatusSelect:
            rect.origin.x = SwipeDistance;
            break;
            
        default:
            break;
    }
    self.noteContentView.frame = rect;
}

- (void) resetUI
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = self.noteContentView.frame;
        rect.origin.x = 0;
        self.noteContentView.frame = rect;
    }];
    
    if (self.selected)
    {
        [self onSelected:self.selectButton];
    }
}

- (void) swipToExport
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = self.noteContentView.frame;
        rect.origin.x = SwipeDistance;
        self.noteContentView.frame = rect;
    }];
}

- (void) swipToDelete
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = self.noteContentView.frame;
        rect.origin.x = -SwipeDistance;
        self.noteContentView.frame = rect;
    }];
}

- (void) swipToSelect
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = self.noteContentView.frame;
        rect.origin.x = SwipeDistance;
        self.noteContentView.frame = rect;
    }];
}

- (void) beSelectState
{
    CGRect rect = self.noteContentView.frame;
    rect.origin.x = SwipeDistance;
    self.noteContentView.frame = rect;
}

- (void) configWithNote:(Note*)note
{
    [_richTextView setNoteContent:note.contents];
    
    
    if (note.tag.length > 0)
    {
        self.tagLabel.text = [NSString stringWithFormat:@"标签: %@", note.tag];
    }
    else
    {
        self.tagLabel.text = @"无标签";
    }
    
    if (note.topicString.length > 0)
    {
        self.topicLabel.text = [NSString stringWithFormat:@"标签: %@", note.topicString];
    }
    else
    {
        self.topicLabel.text = @"无知识点";
    }
    
    if (note.summary.length > 0)
    {
        self.summaryLabel.text = [NSString stringWithFormat:@"标签: %@", note.summary];
    }
    else
    {
        self.summaryLabel.text = @"无总结";
    }
}

@end
