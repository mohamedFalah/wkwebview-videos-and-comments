//
//  CommentsViewController.m
//  HelloOBJC
//
//  Created by Mohammed Alshulah on 31/10/2020.
//

#import "CommentsViewController.h"
#import "CommentCell.h"
#import "Comment.h"
#import "HTTPService.h"

@interface CommentsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *commentsTable;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (nonatomic, strong) NSArray *comments;
@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.commentsTable.dataSource = self;
    self.commentsTable.delegate = self;
    
    self.comments = [[NSArray alloc]init];
    
    [self getComments];
    
    
    
}

-(void) updateCommentsTable {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.commentsTable reloadData];
    });

    
}

- (void) getComments {
    [[HTTPService instance]getComments:^(NSArray * _Nullable dataArray, NSString * _Nullable errorMessage) {
        
        if (dataArray) {
            NSLog(@"data: %@", dataArray.debugDescription);
            NSMutableArray *data = [[NSMutableArray alloc]init];
            
            for(NSDictionary *commentData in dataArray) {
                
                Comment *comment = [[Comment alloc]init];
                
                comment.username = [commentData objectForKey:@"username"];
                comment.comment = [commentData objectForKey:@"comment"];
                
                [data addObject:comment];
                NSLog(@"comment object: %@ %@", comment.username, comment.comment);
            }
        
            self.comments = data;
            [self updateCommentsTable];
            
        } else {
            NSLog(@"error: %@", errorMessage);
        }
        
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Comment *comment = [self.comments objectAtIndex:indexPath.row];
    
    CommentCell *commentCell = (CommentCell*)cell;
    
    [commentCell configureCell:comment];
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CommentCell *cell = (CommentCell*) [_commentsTable dequeueReusableCellWithIdentifier:@"commentCell"];
    
    if (!cell) {
        cell = [[CommentCell alloc]init];
    }
    
    return cell;
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (IBAction)sendClicked:(id)sender {
    
    if (self.commentTextField) {
        
        NSDictionary *comment = @{@"username": @"Username is here", @"comment": _commentTextField.text};
        
        NSError *error;
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURL *url = [NSURL URLWithString:@"http://localhost:6069/comment"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [request setHTTPMethod:@"POST"];
        
        NSData *postData = [NSJSONSerialization dataWithJSONObject:comment options:0 error:&error];
        
        [request setHTTPBody:postData];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(error) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *errorAlert =  [UIAlertController alertControllerWithTitle:@"Error" message:@"Error posting the comment" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        NSLog(@"noticed");
                    }];
                    
                    [errorAlert addAction:action];
                    [self presentViewController:errorAlert animated:YES completion:nil];
                    
                    self.commentTextField.text = @"";
                });
            
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *successAlert =  [UIAlertController alertControllerWithTitle:@"Success" message:@"your comment posted" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"noticed");
                }];
                
                [successAlert addAction:action];
                [self presentViewController:successAlert animated:YES completion:nil];
                self.commentTextField.text = @"";
                });
               
                [self getComments];
            }
            
        }];
        
        [task resume];
        
        
    }
    
    
}
- (IBAction)backClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




@end
