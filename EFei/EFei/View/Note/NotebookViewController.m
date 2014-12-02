//
//  MainViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/30/14.
//
//

#import "NotebookViewController.h"
#import "NoteCell.h"
#import "NoteViewTapGestureRecognizer.h"

#define NoteCellIdentifier @"NoteCellIdentifier"



@interface NotebookViewController()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextViewDelegate>
{
    UITextField *textField;
    
    BOOL _select;
}

@property (weak, nonatomic) IBOutlet UICollectionView *noteCollectionView;


- (IBAction)onYiFei:(id)sender;
- (IBAction)onSelect:(id)sender;

@end

@implementation NotebookViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    float width = 200;
    float height = 34;
    float x = (self.navigationController.navigationBar.frame.size.width - width) / 2;
    float y = 2;
    textField = [[UITextField alloc] initWithFrame: CGRectMake(x, y, width, height)];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    
    
    [self.navigationController.navigationBar addSubview:textField];

    
//    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"firstsecondthirdfourth"];
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,5)];
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5,6)];
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(11,5)];
//    [string addAttribute:NSUnderlineColorAttributeName value:[UIColor redColor] range:NSMakeRange(16, 5)];
//    
//    [string addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(16, 5)];
    
    NSDictionary * wordToColorMapping = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], @"first",
                                         [UIColor greenColor], @"second",
                                         [UIColor blueColor], @"third",
                                         nil];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@""];
    
    
    
    
    for (NSString * word in wordToColorMapping)
    {
        UIColor * color = [wordToColorMapping objectForKey:word];
        NSDictionary * attributes = [NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName,
                                     [NSNumber numberWithInt:NSUnderlineStyleSingle], NSUnderlineStyleAttributeName,
                                     [UIFont systemFontOfSize:15], NSFontAttributeName,
                                     nil];
        NSAttributedString * subString = [[NSAttributedString alloc] initWithString:word attributes:attributes];
        [string appendAttributedString:subString];
    }
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithFloat:5.5], NSBaselineOffsetAttributeName,
                                 [UIFont systemFontOfSize:9], NSFontAttributeName, nil];
    NSAttributedString * subString = [[NSAttributedString alloc] initWithString:@"2" attributes:attributes];
    [string appendAttributedString:subString];
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"like after"];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"icon_logo.png"];
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    [attributedString replaceCharactersInRange:NSMakeRange(4, 1) withAttributedString:attrStringWithImage];
    
    
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"icon_logo.png"];
    
    NSMutableAttributedString *imageAttrString = [[NSAttributedString attributedStringWithAttachment:attachment] mutableCopy];
    
    // sets the paragraph styling of the text attachment
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];            // centers image horizontally
    [paragraphStyle setParagraphSpacing:10];   // adds some padding between the image and the following section
    [imageAttrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [imageAttrString length])];
    
    
    [string appendAttributedString:imageAttrString];
    
    UITextView* label = [[UITextView alloc] initWithFrame:CGRectMake(0, 200, 300, 300)];
    label.editable = NO;
    label.selectable = NO;
    label.attributedText = string;
    label.delegate = self;
//    [self.view addSubview:label];
    
    NoteViewTapGestureRecognizer* recongnizer = [[NoteViewTapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    [label addGestureRecognizer:recongnizer];
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"textview : %ld, %ld --   %@", range.location, range.length, text);
    
    return YES;
}

- (void) onTapped:(id)sender
{
    NoteViewTapGestureRecognizer* recongnizer = (NoteViewTapGestureRecognizer*)sender;
    NSTextAttachment* attached = recongnizer.textAttachment;
    NSLog(@"%@", attached);
}

- (IBAction)onYiFei:(id)sender
{
    
}

- (IBAction)onSelect:(id)sender
{
    _select = !_select;
    
    [self.noteCollectionView performBatchUpdates:^{
        
//        NSInteger count = [self collectionView:self.noteCollectionView numberOfItemsInSection:0];
//        
//        for (int i=0; i<count; i++)
//        {
//            NSIndexPath* index = [NSIndexPath indexPathForItem:i inSection:0];
//            NoteCell* cell = (NoteCell*)[self.noteCollectionView cellForItemAtIndexPath:index];
//            cell.status = NoteCellStatusSelect;
//        }
        
        for (NoteCell* cell in self.noteCollectionView.visibleCells)
        {
            if (_select)
            {
                cell.status = NoteCellStatusSelect;
            }
            else
            {
                cell.status = NoteCellStatusNone;
            }
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
//    [self.noteCollectionView reloadData];
}

- (void) updateViewConstraints
{
    
    
//    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:textField
//                                                                  attribute:NSLayoutAttributeCenterX
//                                                                  relatedBy:NSLayoutRelationEqual
//                                                                     toItem:textField.superview
//                                                                  attribute:NSLayoutAttributeCenterX
//                                                                 multiplier:0.5
//                                                                   constant:0.0];
//    [self.view addConstraint:constraint];
    
    [super updateViewConstraints];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NoteCell* cell = (NoteCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NoteCellIdentifier forIndexPath:indexPath];
    
//    if (_select)
//    {
//        cell.status = NoteCellStatusSelect;
//    }
//    else
//    {
//        cell.status = NoteCellStatusNone;
//    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select cell at index: %ld", indexPath.row);
    return;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, 102);
}

- (void) collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NoteCell* noteCell = (NoteCell*) cell;
    if (_select)
    {
        [noteCell setStatusWithNoAnimation:NoteCellStatusSelect];
    }
    else
    {
        [noteCell setStatusWithNoAnimation:NoteCellStatusNone];
    }
}

@end



/*
 
 其中，content、items以及answer_content中都会以字符串的形式表示题目或者解析的内容，
 在字符串中，会以双美元符号（$$）作为起始和终止嵌入公式、图片或者带有格式的文字，嵌入的内容可以有：
 und_blabla：表示blabla是带有下划线的
 sub_blabla：表示blabla是下标
 sup_blabla：表示blabla是上标
 ita_blabla：表示blabla是斜体
 equ_{name}*{width}*{height}：表示一个公式图片，其中name为该公式图片的文件名，
 width为图片宽度，height为图片高度。该图片的下载地址为“#{image server}/public/download/#{name}.png”
 math_{name}*{width}*{height}：和equ_{name}*{width}*{height}完全一致
 fig_{name}*{width}*{height}：表示一张图片，具体解释同上

 
 */
