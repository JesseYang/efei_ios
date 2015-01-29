//
//  FileDownloader.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/28/15.
//
//

#import "FileDownloader.h"

@interface FileDownloader()<NSURLConnectionDelegate>
{
    NSString* _url;
    NSString* _filePath;
    NSMutableData* _data;
}

@end

@implementation FileDownloader

- (id) initWithUrl:(NSString*)url filePath:(NSString*)path
{
    self = [super init];
    if (self)
    {
        _filePath = [path copy];
        _url = [url copy];
    }
    
    return self;
}

- (void) startDownload
{
    NSURL *url = [NSURL URLWithString:_url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:30];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request
                                                                 delegate:self
                                                         startImmediately:NO];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _data = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_data writeToFile:_filePath atomically:YES];
    
    if (self.successBlock != nil)
    {
        self.successBlock();
    }
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Donwload failed  %@", error);
    if (self.failedBlock != nil)
    {
        self.failedBlock();
    }
}

@end
