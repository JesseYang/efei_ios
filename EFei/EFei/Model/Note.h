//
//  Note.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "Question.h"

@interface Note : Question

@property (nonatomic, copy) NSString* summary;
@property (nonatomic, strong) NSArray* topics;
@property (nonatomic, copy) NSString* tag;

@end
