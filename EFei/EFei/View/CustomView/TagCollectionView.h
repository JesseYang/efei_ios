//
//  TagCollectionView.h
//  EFei
//
//  Created by Xiangzhen Kong on 12/13/14.
//
//

#import <UIKit/UIKit.h>

@interface TagCollectionViewFlowLayout : UICollectionViewFlowLayout

@end

@interface TagCollectionView : UICollectionView

@property (nonatomic, strong) NSArray* titles;

- (void) addTitle:(NSString*)title;

@end
