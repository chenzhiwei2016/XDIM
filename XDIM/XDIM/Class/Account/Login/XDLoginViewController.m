//
//  XDLoginViewController.m
//  XDIM
//
//  Created by 小豆 on 2020/11/20.
//

#import "XDLoginViewController.h"

@interface XDLoginViewController ()
@property (nonatomic, strong) UILabel * logoLabel;

@property (nonatomic, strong) UITextField * userNameTF;

@property (nonatomic, strong) UITextField * pwdTF;

@property (nonatomic, strong) UIButton * loginBtn;


@end

@implementation XDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.view addSubview:self.logoLabel];
    [self.view addSubview:self.loginBtn];
}

- (UILabel *)logoLabel {
    if (!_logoLabel) {
        _logoLabel = [[UILabel alloc] init];
        _logoLabel.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + GETHEIGHT(100), SCREENWIDTH, GETHEIGHT(100));
        _logoLabel.text = @"HELLO WORLD";
        _logoLabel.textAlignment = NSTextAlignmentCenter;
        _logoLabel.font = [UIFont systemFontOfSize:20];
        _logoLabel.textColor = [UIColor whiteColor];
    }
    return _logoLabel;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake((SCREENWIDTH - GETWIDTH(300))/2.f, self.logoLabel.bottom + GETHEIGHT(20), GETWIDTH(300), GETHEIGHT(80));
        [_loginBtn setTitle:@"进入" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [UIColor cyanColor];
        _loginBtn.layer.cornerRadius = 5.f;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginBtn;
}

- (void)loginClick {
    [XDCalendarUtil saveToCalendar];
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
