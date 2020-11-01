//
//  commentCell.h
//  HelloOBJC
//
//  Created by Mohammed Alshulah on 31/10/2020.
//

#import <UIKit/UIKit.h>
@class Comment;
NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell
- (void) configureCell: (nonnull Comment*)comment;
@end

NS_ASSUME_NONNULL_END
