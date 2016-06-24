//
//  Xphoto.h
//  XCCollated-iOS
//
//  Created by Chaos on 16/6/22.
//  Copyright © 2016年 Chaos. All rights reserved.
//

#import "XCModleBase.h"

@interface XphotoFile : MTLModel<MTLJSONSerializing>

@property (nonatomic, retain) NSString *farm;
@property (nonatomic, retain) NSString *bucket;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) id height;
@property (nonatomic, retain) id width;
@property (nonatomic, retain) id frames;
@end




@interface XphotoDateil : MTLModel<MTLJSONSerializing>

@property (nonatomic, retain) NSNumber *pin_id;
@property (nonatomic, retain) XphotoFile *file;
@property (nonatomic, retain) NSString  *source;
@property (nonatomic, retain) NSString  *link;
@property (nonatomic, retain) NSString *raw_text;


@end

@interface Xphoto : MTLModel<MTLJSONSerializing>
@property (nonatomic, retain) id pins;
@end

/*
 pins[
    {
    "pin_id": 759505321,
    "user_id": 18666468,
    "board_id": 30303039,
    "file_id": 92696470,
    "file": {
        "farm": "farm1",
        "bucket": "hbimg",
        "key": "457366233f6a413e8d51d759213ba1b8319bc6f137c6-jZHqF5",
        "type": "image/jpeg",
        "height": "614",
        "frames": "1",
        "width": "500"
        },
    "media_type": 0,
    "source": "item.taobao.com",
    "link": "https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-13279432226.20.Jgw7bC&id=533925060778&_t=1466176141984",
    "raw_text": "啥都噶及撒大大机读卡",
    "text_meta": {},
    "via": 755092445,
    "via_user_id": 18666468,
    "original": 755092445,
    "created_at": 1466575756,
    "like_count": 0,
    "comment_count": 0,
    "repin_count": 0,
    "is_private": 0,
    "orig_source": null,
    "user": {
        "user_id": 18666468,
        "username": "chengelod",
        "urlname": "biwci28cbd",
        "created_at": 1461058403,
            "avatar": {
            "id": 98590994,
            "farm": "farm1",
            "bucket": "hbimg",
            "key": "938bbd25f37850ef9712fb16fa92550cb4328a275495-fKv633",
            "type": "image/jpeg",
            "height": "200",
            "frames": "1",
            "width": "200"
                }
        },
    "board": {
        "board_id": 30303039,
        "user_id": 18666468,
        "title": "HIO",
        "description": "",
        "category_id": "home",
        "seq": 2,
        "pin_count": 4790,
        "follow_count": 2,
        "like_count": 0,
        "created_at": 1466166849,
        "updated_at": 1466575756,
        "deleting": 0,
        "is_private": 0,
        "extra": null
        },
    "via_user": {
        "user_id": 18666468,
        "username": "chengelod",
        "urlname": "biwci28cbd",
        "created_at": 1461058403,
        "avatar": {
            "id": 98590994,
            "farm": "farm1",
            "bucket": "hbimg",
            "key": "938bbd25f37850ef9712fb16fa92550cb4328a275495-fKv633",
            "type": "image/jpeg",
            "height": "200",
            "frames": "1",
            "width": "200"
            }
        }
    },
    {
 
 
 
 
 
    }
 
 
 
 
 
 ]
 
 */
