//
//  TagCollectionViewCell.h
//  EFei
//
//  Created by Xiangzhen Kong on 12/13/14.
//
//

#import <UIKit/UIKit.h>

@interface TagCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel* contentLabel;

+ (CGSize) cellSizeWithString:(NSString*)string;

@end
