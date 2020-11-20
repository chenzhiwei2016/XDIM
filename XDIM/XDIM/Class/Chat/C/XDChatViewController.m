//
//  XDChatViewController.m
//  XDIM
//
//  Created by 小豆 on 2020/11/18.
//

#import "XDChatViewController.h"

#import "XDMessageView.h"

@interface XDChatViewController ()
@property (nonatomic, strong) XDMessageView * messageView;
@end

@implementation XDChatViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [XDColor GetColor:@"#F0F0F0"];
    
    [self.view addSubview:self.messageView];
}

/**
 * 消息界面
 */
- (XDMessageView *)messageView {
    if (!_messageView) {
        _messageView = [[XDMessageView alloc] init];
        _messageView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - TAB_BAR_HEIGHT);
    }
    return _messageView;
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
