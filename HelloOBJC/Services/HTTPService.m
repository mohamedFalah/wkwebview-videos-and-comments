//
//  HTTPService.m
//  HelloOBJC
//
//  Created by Mohammed Alshulah on 29/10/2020.
//

#import "HTTPService.h"
#define URL_BASE "http://localhost:6069"
#define URL_TUTORIALS "/tutorials"
#define URL_COMMENTS "/comments"

@implementation HTTPService

+ (id)instance {
    static HTTPService *sharedInstance = nil;
    
    @synchronized (self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc]init];
        }
    }
    
    return sharedInstance;
}


- (void)getTutorials:(nullable onComplete)completionHandler {
    
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%s%s", URL_BASE, URL_TUTORIALS]];
    
    NSLog(@"url : %s%s", URL_BASE, URL_TUTORIALS);
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) {
            NSError *error;
            
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (error == nil) {
                completionHandler(json, nil);
            } else {
                completionHandler(nil, @"data is not here, try later!");
            }
        } else {
            NSLog(@"Network error: %@", error.debugDescription);
            completionHandler(nil, @"problem Connecting to api");
        }
        
        
    }] resume];
}

-(void) getComments:(onComplete)completionHandler {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s", URL_BASE, URL_COMMENTS]];
    
    NSURLSession *session =[NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil ) {
            NSError *error;
            
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if(error == nil) {
                completionHandler(json, nil);
            } else {
                completionHandler(nil, @"no data");
            }
        } else {
            completionHandler(nil, @"error connecting the api");
        }
        
    }] resume];
    
    
}

@end
