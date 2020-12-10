//
//  XDNavigationController.m
//  XDIM
//
//  Created by 小豆 on 2020/12/2.
//

#import "XDNavigationController.h"

@interface XDNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation XDNavigationController

+ (void)initialize {
    //appearance方法返回一个导航栏的外观对象
    //修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    //设置导航栏背景颜色
    [navigationBar setBarTintColor:[UIColor whiteColor]];
    navigationBar.backgroundColor = [UIColor whiteColor];
    //设置标题栏颜色
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:20]};
    [navigationBar setTintColor:[UIColor blackColor]];
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)viewDidLoad
{
    __weak XDNavigationController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

//重写push后返回按钮的文字,文字可以为空字符串.
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //全部修改返回按钮,但是会失去右滑返回的手势
    if (viewController.navigationItem.leftBarButtonItem ==nil && self.viewControllers.count >=1) {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
        //重写了leftbarItem之后,需要添加如下方法才能重新启用右滑返回
        if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
           {
               self.interactivePopGestureRecognizer.enabled = NO;
           }
    }
    // 首页不需要隐藏tabbar
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];

}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToRootViewControllerAnimated:animated];
    
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
    
}

-(UIBarButtonItem *)creatBackButton {
    return [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"Left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    
}
-(void)popSelf {
    [self popViewControllerAnimated:YES];
}
#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( gestureRecognizer == self.interactivePopGestureRecognizer )
    {
      //  禁用根目录的侧滑手势
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] )
        {
//            NSLog(@"禁用根目录的侧滑手势");
            return NO;
        }
    }
    return YES;
}

@end
