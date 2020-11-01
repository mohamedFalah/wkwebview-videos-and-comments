//
//  ViewController.m
//  HelloOBJC
//
//  Created by Mohammed Alshulah on 25/10/2020.
//

#import "ViewController.h"
#import "HTTPService.h"
#import "Video.h"
#import "VideoCell.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *videosTable;
@property (nonatomic, strong) NSArray *videoList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.videosTable.dataSource = self;
    self.videosTable.delegate = self;
    
    self.videoList = [[NSArray alloc]init];

    
    [[HTTPService instance]getTutorials:^(NSArray * _Nullable dataArray, NSString * _Nullable errorMessage) {
        if (dataArray) {
            NSLog(@"data: %@", dataArray);
            NSMutableArray *data = [[NSMutableArray alloc]init];
            
            for( NSDictionary *videoData in dataArray) {
                Video *video = [[Video alloc]init];
                
                video.videoTitle = [videoData objectForKey:@"title"];
                video.videoDescription = [videoData objectForKey:@"description"];
                video.thumbnailUrl = [videoData objectForKey:@"thumbnail"];
                video.iframe = [videoData objectForKey:@"iframe"];
                
                [data addObject:video];
            }
            
            self.videoList = data;
            [self updateVideoTable];
        } else {
            NSLog(@"error: %@", errorMessage);
        }
    }];
}


- (void) updateVideoTable {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.videosTable reloadData];
    });
}



- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Video *video = [self.videoList objectAtIndex:indexPath.row];
    
    VideoCell *videoCell = (VideoCell*)cell;
    
    [videoCell configureCell:video];
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    VideoCell *cell = (VideoCell*)[_videosTable dequeueReusableCellWithIdentifier:@"videoCell"];
    
    if(!cell) {
        cell = [[VideoCell alloc]init];
        
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoList.count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}






@end
