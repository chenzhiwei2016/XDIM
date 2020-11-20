//
//  XDMessageCell.h
//  XDIM
//
//  Created by 小豆 on 2020/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDMessageCell : UITableViewCell

@end

@interface XDReceiveCell : XDMessageCell
+(instancetype)cellWithtableView:(UITableView *)tableview;
@end

@interface XDSendCell : XDMessageCell
+(instancetype)cellWithtableView:(UITableView *)tableview;
@end

@interface XDMessageFrame : NSObject

@end

NS_ASSUME_NONNULL_END
