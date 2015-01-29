//
//  ExportNotesController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/28/15.
//
//

#import "ExportNotesController.h"
#import "FileDownloader.h"
#import "EFei.h"

@interface ExportNotesController()
{
    FileDownloader* _downloader;
}

@property (nonatomic, assign) BOOL downloading;

@end

@implementation ExportNotesController

+ (ExportNotesController*) instance
{
    static ExportNotesController* _instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[ExportNotesController alloc] init];
    });
    
    return _instance;
}

- (void) startDonwloadWithBlock:(ExportNotesControllerDoneBlock)block
{
    if (_downloading || self.pendingTaskUrl.length == 0)
    {
        return;
    }
    
    _downloading = YES;
    
    __weak ExportNotesController* weakSelf = self;
    
    NSString* filePath = [NSTemporaryDirectory() stringByAppendingString:[self.pendingTaskUrl lastPathComponent]];
    _downloader = [[FileDownloader alloc] initWithUrl:self.pendingTaskUrl filePath:filePath];
    _downloader.successBlock = ^(){
        
        [[EFei instance] saveNotebookExportFile:filePath];
        
        weakSelf.downloading = NO;
        if (block != nil)
        {
            block(YES);
        }
        
    };
    
    _downloader.failedBlock = ^(){
        
        weakSelf.downloading = NO;
        
        if (block != nil)
        {
            block(NO);
        }
        
    };
    
    [_downloader startDownload];
}

@end
