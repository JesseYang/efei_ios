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
        [self setupUI];
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
    UISwipeGestureRecognizer* leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(onSwipe:)];
    UISwipeGestureRecognizer* rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(onSwipe:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.noteContentView addGestureRecognizer:leftRecognizer];
    [self.noteContentView addGestureRecognizer:rightRecognizer];
    
    _richTextView = [[RichTextView alloc] initWithFrame:self.bounds];
    _richTextView.userInteractionEnabled = NO;
    [self.noteContentView addSubview:_richTextView];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    float x = 0;
    
    switch (self.status)
    {
        case NoteCellStatusNone:
            x = 0;
            break;
            
        case NoteCellStatusExport:
            x = SwipeDistance;
            break;
            
        case NoteCellStatusDelete:
            x = -SwipeDistance;
            break;
            
        case NoteCellStatusSelect:
            x = SwipeDistance;
            break;
            
        default:
            break;
    }
    
    CGRect rect = self.frame;
    rect.origin.x = x;
    rect.origin.y = 0;
    self.noteContentView.frame = rect;
    
    CGRect exportRect = self.exportButton.frame;
    exportRect.origin.x = 0;
    exportRect.origin.y = 0;
//    exportRect.size.height = self.frame.size.height;
    self.exportButton.frame = exportRect;
    
    
    CGRect deleteRect = self.deleteButton.frame;
    deleteRect.origin.x = self.frame.size.width - deleteRect.size.width;
    deleteRect.origin.y = 0;
    self.deleteButton.frame = deleteRect;
    
    
    CGRect tvRect = _richTextView.frame;
    tvRect.size = self.frame.size;
    _richTextView.frame = tvRect;
}

- (void) onSwipe:(UISwipeGestureRecognizer *)recognizer
{
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
            [self swipToExport];
            break;
            
        case NoteCellStatusDelete:
            [self swipToDelete];
            break;
            
        case NoteCellStatusSelect:
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
}

@end
