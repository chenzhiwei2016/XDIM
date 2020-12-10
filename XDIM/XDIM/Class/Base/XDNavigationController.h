//
//  XDNavigationController.h
//  XDIM
//
//  Created by 小豆 on 2020/12/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDNavigationController : UINavigationController
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
