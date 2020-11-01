//
//  VideoCell.h
//  HelloOBJC
//
//  Created by Mohammed Alshulah on 30/10/2020.
//

#import <UIKit/UIKit.h>
@class Video;

NS_ASSUME_NONNULL_BEGIN

@interface VideoCell : UITableViewCell
- (void) configureCell:(nonnull Video*)video;
@end

NS_ASSUME_NONNULL_END
