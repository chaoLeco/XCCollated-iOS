//
//  Xphoto.m
//  XCCollated-iOS
//
//  Created by Chaos on 16/6/22.
//  Copyright © 2016年 Chaos. All rights reserved.
//

#import "Xphoto.h"

@implementation Xphoto

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"pins":@"pins"
             };
}

+(NSValueTransformer *) pinsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[XphotoDateil class]];
}
@end


@implementation XphotoDateil

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"pin_id":@"pin_id",
             @"file":@"file",
             @"source":@"source",
             @"link":@"link",
             @"raw_text":@"raw_text"
             };
}

+(NSValueTransformer *) fileJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[XphotoFile class]];
}
@end


@implementation XphotoFile

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"farm": @"farm",
             @"bucket": @"bucket",
             @"key": @"key",
             @"type": @"type",
             @"height": @"height",
             @"width": @"width",
             @"frames": @"frames"
             };
}

@end