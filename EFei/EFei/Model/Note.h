//
//  Note.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "Question.h"

@interface Note : Question

@property (nonatomic, copy) NSString* noteId;
@property (nonatomic, copy) NSString* createTime;
@property (nonatomic, copy) NSString* lastUpdateTime;
@property (nonatomic, assign) NSInteger updateTime;
@property (nonatomic, assign) BOOL updated;
@property (nonatomic, copy) NSString* summary;
@property (nonatomic, strong) NSArray* topics;
@property (nonatomic, copy) NSString* topicString;
@property (nonatomic, copy) NSString* tag;

- (id) initWithQuestion:(Question*)question;
- (id) initWithNoteId:(NSString*)noteId updateTime:(NSInteger)updateTime;

@end
