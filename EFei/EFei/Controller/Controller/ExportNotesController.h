//
//  ExportNotesController.h
//  EFei
//
//  Created by Xiangzhen Kong on 1/28/15.
//
//

#import <Foundation/Foundation.h>

typedef void (^ExportNotesControllerDoneBlock)(BOOL success);

@interface ExportNotesController : NSObject

@property (nonatomic, copy) NSString* pendingTaskUrl;
@property (nonatomic, copy) NSString* filePath;

+ (ExportNotesController*) instance;

- (void) startDonwloadWithBlock:(ExportNotesControllerDoneBlock)block;

@end
