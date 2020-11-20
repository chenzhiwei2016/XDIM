//
//  XDMessageModel.h
//  XDIM
//
//  Created by 小豆 on 2020/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDMessageModel : NSObject
@property (nonatomic,copy) NSString *userIcon;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *messageTest;
@property (nonatomic,copy) NSString *messageEmoji;
@property (nonatomic,copy) NSString *messagePic;
@property (nonatomic,copy) NSString *messageVedio;
@property (nonatomic,copy) NSString *buildTime;
@end

NS_ASSUME_NONNULL_END
