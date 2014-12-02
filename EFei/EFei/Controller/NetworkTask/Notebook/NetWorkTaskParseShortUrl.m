//
//  NetWorkTaskParseShortUrl.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/22/14.
//
//

#import "NetWorkTaskParseShortUrl.h"
#import "EFei.h"
#import "TaskManager.h"
#import "GetQuestionController.h"

static NSString* kRequestShortUrlKey        = @"short_url";

static NSString* kResponseQuestionIdKey        = @"question_id";


@implementation NetWorkTaskParseShortUrl

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeParseShortUrl];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeParseShortUrl;
        self.httpMethod = HttpMethodGet;
        self.path = @"~";
    }
    return self;
}


- (void) prepareParameter
{
    GetQuestionController* controller = (GetQuestionController*)self.data;
    self.path = [NSString stringWithFormat:@"~%@", controller.shortUrl];
    
    //QR code changed, will be a string like http://dev.efei.org/~vON7R.
    self.path = controller.shortUrl.lastPathComponent;
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    GetQuestionController* controller = (GetQuestionController*)self.data;
    NSString* question = [dict objectForKey:kResponseQuestionIdKey];
    controller.questionId = [question copy];
    
    return YES;
}

@end

