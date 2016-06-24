//
//  RsRequestBase.m
//  newruishiclub
//
//  Created by Chaos on 15/11/23.
//  Copyright © 2015年 iUXLabs. All rights reserved.
//

#import "XCRequestBase.h"
#import "XCModleBase.h"

@implementation XCRequestBase
{
    NSDictionary *_reqDic;
}

- (id)initWithReqDic:(NSDictionary *)reqDic{
    self = [super init];
    if (self) {
        _reqDic = reqDic;
           }
    return self;
}

- (id)requestArgument {
    
    return _reqDic;
}

@end
