//
//  WebViewController.m
//  HelloOBJC
//
//  Created by Mohammed Alshulah on 30/10/2020.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "Video.h"
#import "CommentsViewController.h"

@interface WebViewController ()
@property (strong, nonatomic) IBOutlet WKWebView *iframe;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *videoDescription;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *css = @".container { position: relative; width: 100%; height: 0; padding-bottom: 56.25%; } .video { position: absolute; top: 0; left: 0; width: 100%; height: 100%;}";
    
    NSString *js = [NSString stringWithFormat:
                   @"var styleNode = document.createElement('style');\n"
                    "styleNode.type = \"text/css\";\n"
                    "var styleText = document.createTextNode('%@');\n"
                    "styleNode.appendChild(styleText);\n"
                    "document.getElementsByTagName('head')[0].appendChild(styleNode);\n",css];
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addUserScript:script];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    self.iframe = [[WKWebView alloc] initWithFrame:[[self iframe] bounds] configuration:configuration];
    [self.iframe loadHTMLString:_video.iframe baseURL:nil];
    [self.view addSubview:self.iframe];
    self.videoTitle.text = _video.videoTitle;
    self.videoDescription.text = _video.videoDescription;
}
- (IBAction)DoneClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)commentsClicked:(id)sender {
    [self performSegueWithIdentifier:@"showComments" sender:nil];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
