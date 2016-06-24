//
//  RsRequestBase.h
//  newruishiclub
//
//  Created by Chaos on 15/11/23.
//  Copyright © 2015年 iUXLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKRequest.h"
@interface XCRequestBase : YTKRequest

typedef void (^successRequestBlock)(id data );
typedef void (^failureRequestBlock)(NSError *error);


@property(nonatomic,strong) successRequestBlock rsSuccessBlock;
@property(nonatomic,strong) failureRequestBlock rsFailureBlock;

- (id)initWithReqDic:(NSDictionary *)reqDic;

@end
