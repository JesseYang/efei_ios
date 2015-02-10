//
//  NoteTextView.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/3/14.
//
//

#import "RichTextView.h"
#import "RichTextViewGestureRecognizer.h"
#import "UIImage+Resize.h"
#import <SDWebImageManager.h>

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

#define TextFontSize 14


@interface RichTextView()
{
    NSMutableAttributedString* _attributedString;
    
    NSDictionary* _textAttributeDict;
    NSDictionary* _imageAttributeDict;
    
    CGFloat _maxHeightOfLine;
}

- (void) setupUI;
- (void) onTapped:(id)sender;

- (void) processLine:(NSString*)line;
- (void) processNormalString:(NSString*)string;
- (void) processAttributedString:(NSString*)string;

@end

@implementation RichTextView


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
                                 [UIFont systemFontOfSize:TextFontSize], NSFontAttributeName,
                                 nil];
    
    NSDictionary * attributesSub = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithFloat:-5.5], NSBaselineOffsetAttributeName,
                                    [UIFont systemFontOfSize:9], NSFontAttributeName, nil];
    
    NSDictionary * attributesSup = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithFloat:5.5], NSBaselineOffsetAttributeName,
                                    [UIFont systemFontOfSize:9], NSFontAttributeName, nil];
    
    NSDictionary * attributesIta = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont italicSystemFontOfSize:TextFontSize], NSFontAttributeName,
                                    nil];
    
    _textAttributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                          attributesUnderLine, TextAttributeTagUnderLine,
                          attributesSub, TextAttributeTagSub,
                          attributesSup, TextAttributeTagSup,
                          attributesIta, TextAttributeTagIta,
                          nil];
    

    RichTextViewGestureRecognizer* recongnizer = [[RichTextViewGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    [self addGestureRecognizer:recongnizer];
}

- (void) setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    [super setUserInteractionEnabled:userInteractionEnabled];
    
    if (!userInteractionEnabled)
    {
        [self removeGestureRecognizer:[self.gestureRecognizers firstObject]];
    }
}


- (void) setNoteContent:(NSArray *)contents
{
    _attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    for (NSString* line in contents)
    {
        _maxHeightOfLine = [self maxHeightOfLine:line];
        [self processLine:line];
        NSAttributedString* lineBreak = [[NSAttributedString alloc] initWithString:@"\n"];
        [_attributedString appendAttributedString:lineBreak];
    }
    
    self.attributedText = _attributedString;
}


- (void) onTapped:(id)sender
{
    RichTextViewGestureRecognizer* recongnizer = (RichTextViewGestureRecognizer*)sender;
    NSTextAttachment* attached = recongnizer.textAttachment;
    NSLog(@"%@", attached);
    
    if ([self.noteDelegate respondsToSelector:@selector(noteTextView:didClickImage:)])
    {
        [self.noteDelegate noteTextView:self didClickImage:nil];
    }
}

- (CGFloat) maxHeightOfLine:(NSString*)line
{
    CGFloat maxHeight = 25;
    
    NSArray* words = [line componentsSeparatedByString:AttributeSeparator];
    
    for (NSInteger index = 1; index < words.count; index++)
    {
        NSString* string = [words objectAtIndex:index];
        
        NSArray* array = [string componentsSeparatedByString:AttributeSeparatorText];
        if (array.count > 1)
        {
            NSString* content = [array objectAtIndex:1];
            
            NSArray* array2 = [content componentsSeparatedByString:AttributeSeparatorImage];
            if (array2.count > 2)
            {
                float width = [[array2 objectAtIndex:1] floatValue];
                float height = [[array2 objectAtIndex:2] floatValue];
                
                NSLog(@"----- %f, %f", width, height);
                
                if (height > maxHeight)
                {
                    maxHeight = height;
                }
            }
        }
    }
    
    return maxHeight;
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
    
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:TextFontSize]}];
    CGFloat baseLine = (_maxHeightOfLine - ceilf(size.height))/2;
    
    NSDictionary * attributesNormal = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont systemFontOfSize:TextFontSize], NSFontAttributeName,
                                       [NSNumber numberWithFloat:baseLine], NSBaselineOffsetAttributeName,
                                       nil];
    NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributesNormal];
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
    NSArray* array = [content componentsSeparatedByString:AttributeSeparatorImage];
    NSString* fileName = [array objectAtIndex:0];
    float width = [[array objectAtIndex:1] floatValue];
    float height = [[array objectAtIndex:2] floatValue];
    
    NSString* urlString = [NSString stringWithFormat:@"http://dev.image.efei.org/public/download/%@.png", fileName];
    NSURL* url = [NSURL URLWithString:urlString];
    NSInteger index = _attributedString.length;
    
    SDWebImageManager* manager = [SDWebImageManager sharedManager];
    
    UIImage* image = [UIImage imageNamed:@"icon_question_image_placeholder.png"];
    UIImage* cachedImage = [manager.imageCache imageFromMemoryCacheForKey:fileName];
    if (cachedImage == nil)
    {
        [manager downloadImageWithURL:url options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            NSLog(@"donwload success %d", finished);
            [manager.imageCache storeImage:image forKey:fileName];
            
            if (index < _attributedString.length)
            {
                float scale = [UIScreen mainScreen].scale;
                UIImage* resizedImage = [UIImage imageWithImage:image sacleToSize:CGSizeMake(width*scale, height*scale)];
                NSAttributedString* realStr = [self attributedStringWithImage:resizedImage];
                [_attributedString replaceCharactersInRange:NSMakeRange(index, 1) withAttributedString:realStr];
                
                self.attributedText = _attributedString;
                
            }
        }];
    }
    else
    {
        image = cachedImage;
    }
    
    float scale = [UIScreen mainScreen].scale;
    UIImage* resizedImage = [UIImage imageWithImage:image sacleToSize:CGSizeMake(width*scale, height*scale)];
    return [self attributedStringWithImage:resizedImage];
    
//
//    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
//    textAttachment.image = [UIImage imageWithImage:image sacleToSize:CGSizeMake(width, height)];
//    
//    
//    
//    NSLog(@"filename: %@", urlString);
//    SDWebImageManager* manager = [SDWebImageManager sharedManager];
//    [manager downloadImageWithURL:url options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        
//        NSLog(@"donwload success %d", finished);
//        
//        textAttachment.image = image;
//        
//    }];
    
//    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
//    return attrStringWithImage;
}


- (NSAttributedString*) attributedStringWithImage:(UIImage*)image
{
    float scale = [UIScreen mainScreen].scale;
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;
    textAttachment.bounds = CGRectMake(0, 0, image.size.width/scale, image.size.height/scale);
    
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


