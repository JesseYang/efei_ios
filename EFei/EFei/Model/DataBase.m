//
//  DataBase.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "DataBase.h"
#import "EFei.h"

#define DataBaseRootFolder @"EFei"
#define DataBaseNotebookFolder @"notebook"
#define DataBaseSubjectFolder @"subject"

@interface DataBase()
{
    NSString* _rootPath;
    NSString* _nootbookPath;
    NSString* _subjectPath;
}

- (void) initDataBase;

@end

@implementation DataBase

- (id) init
{
    self = [super init];
    if (self)
    {
        [self initDataBase];
    }
    
    return self;
}

- (void) initDataBase
{
    // Create root folder
    _rootPath = [NSTemporaryDirectory() stringByAppendingPathComponent:DataBaseRootFolder];
    
    NSError * error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:_rootPath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error != nil)
    {
        NSLog(@"error creating directory: %@", error);
    }
    
    // Create notebook foler
    _nootbookPath = [_rootPath stringByAppendingPathComponent:DataBaseNotebookFolder];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:_nootbookPath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error != nil)
    {
        NSLog(@"error creating directory: %@", error);
    }
    
    // Create subject folder
    _subjectPath = [_rootPath stringByAppendingPathComponent:DataBaseSubjectFolder];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:_subjectPath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error != nil)
    {
        NSLog(@"error creating directory: %@", error);
    }
}



- (void) loadSubject:(Subject*)subject
{
    NSString* fileName = [NSString stringWithFormat:@"%@.txt", subject.name];
    NSString* filePath = [_subjectPath stringByAppendingString:fileName];
    
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (!exist)
    {
        return;
    }
    
    NSError * error = nil;
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSString* fileContents = [NSString stringWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
    NSArray *lines = [fileContents componentsSeparatedByCharactersInSet:newlineCharSet];
    
    for (NSString* l in lines)
    {
        NSArray* t = [l componentsSeparatedByString:@","];
        if (t.count == 2)
        {
            Topic* topic = [[Topic alloc] init];
            topic.name = [t objectAtIndex:0];
            topic.quickName = [t objectAtIndex:1];
            [subject addTopic:topic];
        }
    }
    
    NSDictionary* attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
    if (attrs != nil)
    {
        NSDate *date = (NSDate*)[attrs objectForKey: NSFileCreationDate];
        NSLog(@"Date Created: %@", [date description]);
        NSTimeInterval timeInterval = [date timeIntervalSinceNow];
        if (timeInterval < -604800)
        {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        }
    }
}

- (void) saveSubject:(Subject*)subject
{
    NSString* fileName = [NSString stringWithFormat:@"%@.txt", subject.name];
    NSString* filePath = [_subjectPath stringByAppendingString:fileName];
    
    NSError * error = nil;
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (exist)
    {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    }
    
    [[NSFileManager defaultManager] createDirectoryAtPath:_subjectPath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error == nil)
    {
        NSMutableString* string = [[NSMutableString alloc] init];
        for (Topic* topic in subject.topics)
        {
            [string appendFormat:@"%@,%@\n", topic.name, topic.quickName];
        }
        
        [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    
}

@end
