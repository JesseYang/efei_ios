//
//  NoteViewTapGestureRecognizer.h
//  EFei
//
//  Created by Xiangzhen Kong on 12/2/14.
//
//

#import <UIKit/UIKit.h>

@interface NoteViewTapGestureRecognizer : UITapGestureRecognizer

@property (nonatomic, assign) NSRange range;
@property (nonatomic, strong) NSTextAttachment* textAttachment;

@end
