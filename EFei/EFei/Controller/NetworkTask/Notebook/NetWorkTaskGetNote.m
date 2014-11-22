//
//  NetWorkTaskGetNote.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/22/14.
//
//

#import "NetWorkTaskGetNote.h"
#import "EFei.h"
#import "TaskManager.h"

static NSString* kResponseNotesKey        = @"notes";

//@property (nonatomic, copy) NSString* questionId;
//@property (nonatomic, assign) SubjectType subjectType;
//@property (nonatomic, assign) QuestionType questionType;
//@property (nonatomic, strong) NSArray* contents;
//@property (nonatomic, strong) NSArray* items;
//@property (nonatomic, assign) NSInteger answer;
//@property (nonatomic, strong) NSArray* answerContents;
//@property (nonatomic, strong) NSArray* tags;
//@property (nonatomic, assign) NSInteger noteId;
//@property (nonatomic, assign) NSInteger updateTime;
//@property (nonatomic, copy) NSString* summary;
//@property (nonatomic, strong) NSArray* topics;
//@property (nonatomic, copy) NSString* tag;

@implementation NetWorkTaskGetNote

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeGetNote];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeGetNote;
        self.httpMethod = HttpMethodGet;
        self.path = @"student/notes";
    }
    return self;
}


- (void) prepareParameter
{
    Note* note = (Note*)self.data;
    self.path = [NSString stringWithFormat:@"%@/%ld", self.path, note.noteId];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    Note* note = (Note*)self.data;
    
    
    return YES;
}

@end
