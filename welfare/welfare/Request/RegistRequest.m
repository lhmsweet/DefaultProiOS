//
//  RegistRequest.m
//  welfare
//
//  Created by hazama on 16/9/22.
//  Copyright © 2016年 hazama. All rights reserved.
//

#import "RegistRequest.h"

#define RegistUrl @"/Regist.php"

@interface RegistRequest()

@end

@implementation RegistRequest

- (void)registActionWithUserName:(NSString *)name pwd:(NSString *)pwd {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *param = @{@"name":name,@"pwd":pwd};
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseUrl,RegistUrl];
    [manager POST:urlString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"code"] integerValue] == 200 && [[dic objectForKey:@"status"] integerValue] == 1) {
            if (self.didSucceedBlock) {
                self.didSucceedBlock(dic);
            }
            
        } else {
            if (self.didFailBlock) {
                self.didFailBlock(dic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dic = @{@"message":error.description};
        if (self.didFailBlock) {
            self.didFailBlock(dic);
        }
    }];
}

@end
