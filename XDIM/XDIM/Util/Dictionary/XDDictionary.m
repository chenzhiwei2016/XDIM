//
//  XDDictionary.m
//  XDIM
//
//  Created by 小豆 on 2020/11/18.
//

#import "XDDictionary.h"

@implementation XDDictionary
/**
 * 获取字典的json字符串
 */
+ (NSString*)getDicDescription:(NSDictionary *)dic {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted  error:&error];
    NSString *jsonString;
    if (error) {
        jsonString = [NSString stringWithFormat:@"%@",dic];
    }else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
@end
