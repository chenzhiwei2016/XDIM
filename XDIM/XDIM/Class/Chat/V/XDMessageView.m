//
//  XDMessageView.m
//  XDIM
//
//  Created by 小豆 on 2020/11/19.
//

#import "XDMessageView.h"
#import "XDMessageCell.h"

@interface XDMessageView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * messageTable;
@end

@implementation XDMessageView

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.messageTable];
    
}

/**
 * 消息Table
 */
- (UITableView *)messageTable {
    if (!_messageTable) {
        _messageTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _messageTable.backgroundColor = [UIColor clearColor];
        _messageTable.delegate = self;
        _messageTable.dataSource = self;
        _messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _messageTable;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XDReceiveCell *cell = [XDReceiveCell cellWithtableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)scrollViewToBottom:(BOOL)animated {
    if (self.messageTable.contentSize.height > self.messageTable.frame.size.height) {
        CGPoint offset = CGPointMake(0, self.messageTable.contentSize.height -self.messageTable.frame.size.height);
        [self.messageTable setContentOffset:offset animated:animated];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.messageTable.frame = self.bounds;
    [self scrollViewToBottom:NO];
}

@end
