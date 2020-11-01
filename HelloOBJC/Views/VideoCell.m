//
//  VideoCell.m
//  HelloOBJC
//
//  Created by Mohammed Alshulah on 30/10/2020.
//

#import "VideoCell.h"
#import "Video.h"

@interface VideoCell()
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *videoDescription;
@property (weak, nonatomic) IBOutlet UIView *videoContainer;

@end

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5.0;
    self.layer.shadowColor = [UIColor colorWithRed:157/255 green:157/255 blue:157/255 alpha:0.5].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 5;
    self.layer.shadowOffset = CGSizeMake(0.0, 10);
    
}

- (void) configureCell:(nonnull Video*)video {
    
    self.videoTitle.text = video.videoTitle;
    self.videoDescription.text = video.videoDescription;
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:video.thumbnailUrl]]];
    
    self.thumbnail.image = image;
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
