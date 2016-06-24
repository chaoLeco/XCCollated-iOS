//
//  iTourNetworking.m
//  itour
//
//  Created by Chaos on 16/5/26.
//  Copyright © 2016年 Chaos. All rights reserved.
//

#import "XCNetworking.h"
#import "SSKeychain.h"


@implementation XCNetworking

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
//+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
//    if (jsonString == nil) {
//        return nil;
//    }
//    
//    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
//    if(err) {
//        NSLog(@"json解析失败：%@",err);
//        return nil;
//    }
//    return dic;
//}

+ (NSString *)UUID {

    NSString *UUID = [SSKeychain passwordForService:@"XCCollatedAPPUUID" account:@"Leco.Chao.XCCollated-iOS.group"];
    
    if (UUID.length == 0) {
        NSError *error;
        UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        BOOL success = [SSKeychain setPassword:UUID forService:@"XCCollatedAPPUUID"  account:@"Leco.Chao.XCCollated-iOS.group" error:&error];
        if (!success || error) {
            NSLog(@"UUID 存入 Keychain 失败");
        }
    }
    return UUID;
}

#pragma mark - 检测网络状态
+ (void)netWorkingStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    //如果要检测网络状态变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //监测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"netWorkingStatus %ld", (long)status);
        if (status == AFNetworkReachabilityStatusReachableViaWWAN||
            status ==  AFNetworkReachabilityStatusReachableViaWiFi) {

        }else{
            
        }
        
    }];
    
}

+ (void)XC_GET_JSONDataWithUrl:(NSString *)urlStr
                           Params:(NSDictionary*)params
                          success:(void (^)(id json))success
                             fail:(void (^)(NSError *error))fail
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求格式
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSString *url = [NSString stringWithFormat:@"%@",urlStr];
    NSLog(@"GET_param == %@", params);
    
    [manager GET:url parameters:params
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)XC_Post_JSONWithUrl:(NSString *)urlStr
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(id json))success
                          fail:(void (^)(NSError *error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求格式
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSString *url = [NSString stringWithFormat:@"%@",urlStr];
    NSLog(@"Post_param == %@", parameters);
    [manager POST:url parameters:parameters
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    
}

+ (void)XC_Post_UploadWithUrl:(NSString *)urlStr
                          Params:(NSDictionary*)params
                        Data_arr:(NSArray*)data_arr
                         success:(void (^)(id responseObject))success
                            fail:(void (^)(NSError *error))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    //设置请求格式
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    // 设置超时时间
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 5.f;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < data_arr.count; i++) {
            NSDictionary *picDic = [data_arr objectAtIndex:i];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setTimeZone:[NSTimeZone systemTimeZone]];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString* dateString = [formatter stringFromDate:[NSDate date]];
            dateString = [NSString stringWithFormat:@"%@_%lu.png",dateString,data_arr.count + 1];
            NSData* data = [NSData data];
            data = [picDic objectForKey:@"picData"];
            NSString  *path = NSHomeDirectory();
            NSLog(@"path:%@",path);
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString* documentsDirectory = [paths objectAtIndex:0];
            NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:dateString];
            
            [data writeToFile:fullPathToFile atomically:NO];
            //            NSString* name = [picDic objectForKey:@"picKey"]; 原来是这样写的
            //            [formData appendPartWithFileData:data name:name fileName:dateString mimeType:@"image/png"];
            [formData appendPartWithFileData:data name:@"avatar" fileName:@"photo.png" mimeType:@"image/png"];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

// 下载进度progress 暂时用不了
+(void)XC_Down_UploadWithUrl:(NSString *)url
                       FileName:(NSString *)fileName
                       Progress:(void (^)(CGFloat Progress))progress
                        success:(void (^)(id filePath))success
                           fail:(void (^)(NSError *error))fail
{
    
//    AFNetworking 3.0后可以使用
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
//                                                                     progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"___%lli__%lli",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
//    }
//                                                                  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//    }
//                                                            completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        NSLog(@"File downloaded to: %@", filePath);
//    }];
//    [downloadTask resume];
    
    
    //    {
    
    //处理下载进度
    //                                       if (progress) {
    //
    //                                           CGFloat _progress = (float)downloadProgress.completedUnitCount/(float)downloadProgress.totalUnitCount;
    //                                           NSLog(@"_progress %f",_progress);
    //                                           progress(_progress);
    //                                       }
    //    }
    
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    //默认传输的数据类型是二进制
//    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDownloadTask *downloadTask = [sessionManager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]
                                                                            progress:nil

                                destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                    //沙盒的Documents路径
                                    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                                    return [documentsDirectoryURL URLByAppendingPathComponent:@"HTML5.zip"];

    }
                          completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                              if (!error) {
                                  NSLog(@"download %@ path:%@",fileName,filePath);
                                  if (success) {
                                      success(filePath);
                                  }
                              }else{
                                  if (fail) {
                                      fail(error);
                                  }
                              }
        
    }];
    [downloadTask resume];
}
@end
