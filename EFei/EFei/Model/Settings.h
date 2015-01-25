//
//  Settings.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ExportDestinationNone,
    ExportDestinationDownload,
    ExportDestinationEmail,
} ExportDestination;

@interface NotebookExportSetting : NSObject

@property (nonatomic, copy) NSString*  fileType;
@property (nonatomic, assign) BOOL     hasAnswer;
@property (nonatomic, assign) BOOL     hasNote;
@property (nonatomic, assign) ExportDestination  destination;
@property (nonatomic, copy) NSString*  email;

@end

@interface Settings : NSObject

@property (nonatomic, strong) NotebookExportSetting* exportSetting;

@end
