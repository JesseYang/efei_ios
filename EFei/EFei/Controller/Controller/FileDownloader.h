//
//  FileDownloader.h
//  EFei
//
//  Created by Xiangzhen Kong on 1/28/15.
//
//

#import <Foundation/Foundation.h>

typedef void (^FileDownloaderSuccessBlock)();
typedef void (^FileDownloaderFailedBlock)();

@interface FileDownloader : NSObject

@property (nonatomic, copy) FileDownloaderSuccessBlock successBlock;
@property (nonatomic, copy) FileDownloaderFailedBlock failedBlock;

- (id) initWithUrl:(NSString*)url filePath:(NSString*)path;
- (void) startDownload;

@end
