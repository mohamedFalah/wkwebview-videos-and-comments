//
//  commentCell.m
//  HelloOBJC
//
//  Created by Mohammed Alshulah on 31/10/2020.
//

#import "CommentCell.h"
#import "Comment.h"
@interface CommentCell()
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIView *commentContainer;


@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.commentContainer.layer.cornerRadius = 10;
    self.commentContainer.layer.shadowColor = [UIColor colorWithRed:135/255 green:206/255 blue:250/255 alpha:0.4].CGColor;
    self.commentContainer.layer.shadowRadius = 10;
    self.commentContainer.layer.shadowOpacity = 0.3;
    self.commentContainer.layer.shadowOffset = CGSizeMake(0, 10);
}

- (void) configureCell:(nonnull Comment*)comment {
    
    self.username.text = comment.username;
    self.comment.text = comment.comment;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
