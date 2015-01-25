//
//  Settings.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "Settings.h"

@implementation NotebookExportSetting

- (id) init
{
    self = [super init];
    if (self)
    {
        self.fileType = @"word";
        self.hasNote = NO;
        self.hasAnswer = NO;
        self.email = @"";
        self.destination = ExportDestinationNone;
    }
    
    return self;
}

@end

@implementation Settings

- (id) init
{
    self = [super init];
    if (self)
    {
        self.exportSetting = [[NotebookExportSetting alloc] init];
    }
    
    return self;
}

@end
