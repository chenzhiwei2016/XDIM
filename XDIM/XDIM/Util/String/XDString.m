//
//  XDString.m
//  XDIM
//
//  Created by 小豆 on 2020/11/18.
//

#import "XDString.h"

@implementation XDString
/**
 *判断字符串是否为非空
 *@param string destination string
 *@return YES or NO
 */
+(BOOL)checkIsNotEmptyString:(NSString *)string {
    BOOL isNotEmpty = NO;
    if (string == nil ||
        string == NULL ||
        [string isKindOfClass:[NSNull class]] ||
        [string isEqualToString:@"nil"] ||
        [string isEqualToString:@"(nil)"] ||
        [string isEqualToString:@"null"] ||
        [string isEqualToString:@"(null)"] ||
        [string isEqualToString:@""]) {
        isNotEmpty = NO;
    }else {
        isNotEmpty = YES;
    }
    return isNotEmpty;
}

/**
 *处理空字符串
 *@param string destination string
 *@return 处理过的字符串
 */
+(NSString *)dealEmptyString:(NSString *)string {
    NSString *aString = @"";
    if (string == nil ||
        string == NULL ||
        [string isKindOfClass:[NSNull class]] ||
        [string isEqualToString:@"nil"] ||
        [string isEqualToString:@"(nil)"] ||
        [string isEqualToString:@"null"] ||
        [string isEqualToString:@"(null)"]) {
        aString = @"";
    }else {
        aString = string;
    }
    return aString;
}
@end
