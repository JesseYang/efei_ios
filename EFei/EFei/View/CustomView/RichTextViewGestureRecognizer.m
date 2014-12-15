//
//  NoteViewTapGestureRecognizer.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/2/14.
//
//

#import "RichTextViewGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation RichTextViewGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.state == UIGestureRecognizerStateFailed) return;
    
    UITouch *touch = [touches anyObject];
    UITextView *textView = (UITextView*) self.view;
    NSTextContainer *textContainer = textView.textContainer;
    NSLayoutManager *layoutManager = textView.layoutManager;
    
    CGPoint point = [touch locationInView:textView];
    point.x -= textView.textContainerInset.left;
    point.y -= textView.textContainerInset.top;
    
    NSUInteger characterIndex = [layoutManager characterIndexForPoint:point inTextContainer:textContainer fractionOfDistanceBetweenInsertionPoints:nil];
    
    if (characterIndex >= textView.text.length)
    {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    
    _textAttachment = [textView.attributedText attribute:NSAttachmentAttributeName atIndex:characterIndex effectiveRange:&_range];
    if (_textAttachment)
    {
        return;
    }
    _textAttachment = nil;
}

@end
