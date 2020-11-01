//
//  Video.h
//  HelloOBJC
//
//  Created by Mohammed Alshulah on 30/10/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Video : NSObject

@property (nonatomic, strong) NSString *videoTitle;
@property (nonatomic, strong) NSString *videoDescription;
@property (nonatomic, strong) NSString *iframe;
@property (nonatomic, strong) NSString *thumbnailUrl;



@end

NS_ASSUME_NONNULL_END
