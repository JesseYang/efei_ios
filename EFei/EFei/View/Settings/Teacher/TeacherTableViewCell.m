//
//  TeacherTableViewCell.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/8/15.
//
//

#import "TeacherTableViewCell.h"

@interface TeacherTableViewCell()
{
    BOOL _deleting;
}

- (void) setupUI;
- (void) onSwipe:(UISwipeGestureRecognizer*)recognizer;

@end

@implementation TeacherTableViewCell

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
    [self.contentView addGestureRecognizer:leftRecognizer];
    [self.contentView addGestureRecognizer:rightRecognizer];
    
    _deleting = NO;
    self.deleteButton.userInteractionEnabled = _deleting;
}


- (void) onSwipe:(UISwipeGestureRecognizer *)recognizer
{
    float delta = 0.0;
    if (!_deleting && recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        delta = self.deleteButton.frame.size.width * -1;
    }
    
    
    if (_deleting && recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        delta = self.deleteButton.frame.size.width;
    }
    
    
    if (delta > 1.0 || delta < -1.0)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect rect1 = self.subjectLabel.frame;
            rect1.origin.x += delta;
            self.subjectLabel.frame = rect1;
            
            
            CGRect rect2 = self.schoolLabel.frame;
            rect2.origin.x += delta;
            self.schoolLabel.frame = rect2;
            
            
            CGRect rect3 = self.nameLabel.frame;
            rect3.origin.x += delta;
            self.nameLabel.frame = rect3;
            
        } completion:^(BOOL finished) {
            
            _deleting = !_deleting;
            self.deleteButton.userInteractionEnabled = _deleting;
            
        }];
    }
}

- (void) resetUI
{
    if (_deleting)
    {
        float delta = self.deleteButton.frame.size.width;
        CGRect rect1 = self.subjectLabel.frame;
        rect1.origin.x += delta;
        self.subjectLabel.frame = rect1;
        
        
        CGRect rect2 = self.schoolLabel.frame;
        rect2.origin.x += delta;
        self.schoolLabel.frame = rect2;
        
        
        CGRect rect3 = self.nameLabel.frame;
        rect3.origin.x += delta;
        self.nameLabel.frame = rect3;
        
        _deleting = NO;
        self.deleteButton.userInteractionEnabled = _deleting;
    }
}

@end
