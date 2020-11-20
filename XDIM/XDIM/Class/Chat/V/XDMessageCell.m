//
//  XDMessageCell.m
//  XDIM
//
//  Created by 小豆 on 2020/11/19.
//

#import "XDMessageCell.h"
#import "XDBubbleView.h"

@implementation XDMessageCell

@end

@interface XDReceiveCell ()
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) XDBubbleView * bubbleView;
@property (nonatomic, strong) UILabel * messageLabel;
@end
@implementation XDReceiveCell
+(instancetype)cellWithtableView:(UITableView *)tableview
{
    static NSString *ID = @"XDReceiveCell";
    XDReceiveCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[XDReceiveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

//重写布局
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.bubbleView = [[XDBubbleView alloc] init];
    self.bubbleView.bubbleColor = [XDColor GetRandomColor];
    [self.contentView addSubview:self.bubbleView];
    [self.bubbleView drawBubbleWithSingleHeight:50 isSendMessage:NO];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bubbleView.frame = CGRectMake(10, 5, 200, 50);
}
@end


@interface XDSendCell ()
@property (nonatomic, strong) XDBubbleView * bubbleView;
@end
@implementation XDSendCell
+(instancetype)cellWithtableView:(UITableView *)tableview
{
    static NSString *ID = @"XDSendCell";
    XDSendCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[XDSendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

//重写布局
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.bubbleView = [[XDBubbleView alloc] init];
    self.bubbleView.bubbleColor = [XDColor GetRandomColor];
    [self.contentView addSubview:self.bubbleView];
    [self.bubbleView drawBubbleWithSingleHeight:50 isSendMessage:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bubbleView.frame = CGRectMake(10, 5, 200, 50);
    
}

@end


@implementation XDMessageFrame



@end
