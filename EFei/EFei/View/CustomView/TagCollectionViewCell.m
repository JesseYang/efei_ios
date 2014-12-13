//
//  TagCollectionViewCell.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/13/14.
//
//

#import "TagCollectionViewCell.h"
#import "UIColor+Hex.h"

#define CellColor @"#4979BD"

#define CellPadding 10
#define CellHeight 30

@interface TagCollectionViewCell()
{
}

- (void) setupUI;

@end

@implementation TagCollectionViewCell

+ (CGSize) cellSizeWithString:(NSString*)string
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, CellHeight)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    
    return CGSizeMake(rect.size.width+CellPadding*2+CellHeight, CellHeight);
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
    self.backgroundColor = [UIColor colorWithHexString:CellColor];
    self.layer.cornerRadius = 5;
    
    _contentLabel = [UILabel new];
    _contentLabel.textColor = [UIColor whiteColor];
    _contentLabel.font = [UIFont systemFontOfSize:20];
    _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_contentLabel];
    
    _deleteButton = [UIButton new];
    [_deleteButton setImage:[UIImage imageNamed:@"icon_knowledge_tag_delete.jpg"] forState:UIControlStateNormal];
    _deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_deleteButton];
    
    NSDictionary *viewsDictionary = @{@"contentLabel":_contentLabel,
                                      @"deleteButton":_deleteButton
                                      };
    
    NSArray *buttonConstraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[deleteButton(30)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    NSArray *buttonConstraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[deleteButton(30)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    [_deleteButton addConstraints:buttonConstraintH];
    [_deleteButton addConstraints:buttonConstraintV];
    
    NSArray *constraintPosH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentLabel]-5-[deleteButton]|"
                                                                      options:NSLayoutFormatAlignAllTop
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *constraintPosV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentLabel]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    [self addConstraints:constraintPosH];
    [self addConstraints:constraintPosV];
    
    
}

@end
