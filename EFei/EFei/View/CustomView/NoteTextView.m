//
//  NoteTextView.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/3/14.
//
//

#import "NoteTextView.h"
#import "NoteViewTapGestureRecognizer.h"

#define AttributeSeparator @"$$"

#define AttributeSeparatorText @"_"
#define AttributeSeparatorImage @"*"

#define TextAttributeTagUnderLine @"und"
#define TextAttributeTagSub @"sub"
#define TextAttributeTagSup @"sup"
#define TextAttributeTagIta @"ita"

#define ImageAttributeTagEqu @"equ"
#define ImageAttributeTagMath @"math"
#define ImageAttributeTagFigure @"fig"


@interface NoteTextView()
{
    NSMutableAttributedString* _attributedString;
    
    NSDictionary* _textAttributeDict;
}

- (void) setupUI;
- (void) onTapped:(id)sender;

- (void) processLine:(NSString*)line;
- (void) processNormalString:(NSString*)string;
- (void) processAttributedString:(NSString*)string;

@end

@implementation NoteTextView


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
    self.editable = NO;
    self.selectable = NO;
    _attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    
    NSDictionary * attributesUnderLine = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:NSUnderlineStyleSingle], NSUnderlineStyleAttributeName,
                                 [UIFont systemFontOfSize:15], NSFontAttributeName,
                                 nil];
    
    NSDictionary * attributesSub = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithFloat:-5.5], NSBaselineOffsetAttributeName,
                                    [UIFont systemFontOfSize:9], NSFontAttributeName, nil];
    
    NSDictionary * attributesSup = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithFloat:5.5], NSBaselineOffsetAttributeName,
                                    [UIFont systemFontOfSize:9], NSFontAttributeName, nil];
    
    NSDictionary * attributesIta = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont italicSystemFontOfSize:15], NSFontAttributeName,
                                    nil];
    
    _textAttributeDict = [NSDictionary dictionaryWithObjectsAndKeys:attributesUnderLine, TextAttributeTagUnderLine,
                          attributesSub, TextAttributeTagSub,
                          attributesSup, TextAttributeTagSup,
                          attributesIta, TextAttributeTagIta,
                          nil];
    

    NoteViewTapGestureRecognizer* recongnizer = [[NoteViewTapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    [self addGestureRecognizer:recongnizer];
}

- (void) setNoteContent:(NSArray *)contents
{
    for (NSString* line in contents)
    {
        [self processLine:line];
        NSAttributedString* lineBreak = [[NSAttributedString alloc] initWithString:@"\n"];
        [_attributedString appendAttributedString:lineBreak];
    }
    
    self.attributedText = _attributedString;
}


- (void) onTapped:(id)sender
{
    NoteViewTapGestureRecognizer* recongnizer = (NoteViewTapGestureRecognizer*)sender;
    NSTextAttachment* attached = recongnizer.textAttachment;
    NSLog(@"%@", attached);
    
    if ([self.noteDelegate respondsToSelector:@selector(noteTextView:didClickImage:)])
    {
        [self.noteDelegate noteTextView:self didClickImage:nil];
    }
}


- (void) processLine:(NSString*)line
{
    NSArray* words = [line componentsSeparatedByString:AttributeSeparator];
    
    for (NSInteger index = 0; index < words.count; index++)
    {
        [self processNormalString:[words objectAtIndex:index]];
        
        index ++;
        if (index < words.count)
        {
            [self processAttributedString:[words objectAtIndex:index]];
        }
    }
    
}

- (void) processNormalString:(NSString*)string
{
    if (string.length == 0)
    {
        return;
    }
    
    NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:string];
    [_attributedString appendAttributedString:attributedString];
}

- (void) processAttributedString:(NSString*)string
{
    if (string.length == 0)
    {
        return;
    }
    
    NSArray* array = [string componentsSeparatedByString:AttributeSeparatorText];
    NSString* tag = [array objectAtIndex:0];
    NSString* content = [array objectAtIndex:1];
    
    NSAttributedString* attributedString = [self attributedStringWithTextTag:tag content:content];
    if (attributedString == nil)
    {
        attributedString = [self attributedStringWithImageTag:tag content:content];
    }
    
    [_attributedString appendAttributedString:attributedString];
}

- (NSAttributedString*) attributedStringWithTextTag:(NSString*)tag content:(NSString*)content
{
    NSDictionary* attribute = [_textAttributeDict objectForKey:tag];
    
    if (attribute == nil)
    {
        return nil;
    }
    
    NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:content attributes:attribute];
    return attributedString;
}

- (NSAttributedString*) attributedStringWithImageTag:(NSString*)tag content:(NSString*)content
{
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"icon_logo.png"];
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    return attrStringWithImage;
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


