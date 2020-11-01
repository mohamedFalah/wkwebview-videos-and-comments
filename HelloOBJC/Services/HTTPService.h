//
//  HTTPService.h
//  HelloOBJC
//
//  Created by Mohammed Alshulah on 29/10/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^onComplete)(NSArray * _Nullable dataArray, NSString *_Nullable errorMessage);
@interface HTTPService : NSObject
+ (id)instance;
- (void)getTutorials:(nullable onComplete)completionHandler;
- (void)getComments:(nullable onComplete)completionHandler;
@end

NS_ASSUME_NONNULL_END
