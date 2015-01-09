//
//  Teacher.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import <Foundation/Foundation.h>

@interface Teacher : NSObject

@property (nonatomic, assign) NSInteger teacherId;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* subject;
@property (nonatomic, copy) NSString* school;
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, copy) NSString* avatar;

- (id) initWithId:(NSInteger)teacherId
             name:(NSString*)name
          subject:(NSString*)subject
           school:(NSString*)school
      description:(NSString*)desc
           avatar:(NSString*)avatar;

@end

