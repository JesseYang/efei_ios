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
@property (nonatomic, strong) UIButton* deleteButton;

+ (CGSize) cellSizeWithString:(NSString*)string;

@end
