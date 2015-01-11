//
//  QuestionView.h
//  EFei
//
//  Created by Xiangzhen Kong on 12/9/14.
//
//

#import <UIKit/UIKit.h>

@class Question;

@class QuestionView;

@protocol QuestionViewDelegate <NSObject>

- (void) questionView:(QuestionView*)question showHideAnswer:(BOOL)show withHeightChange:(float)delta;

@end

@interface QuestionView : UIView

@property (nonatomic, strong) Question* question;
@property (nonatomic, weak) id<QuestionViewDelegate> delegate;

@property (nonatomic, assign) float viewHeight;

@end
