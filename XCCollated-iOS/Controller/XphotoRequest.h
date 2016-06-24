//
//  XphotoRequest.h
//  XCCollated-iOS
//
//  Created by Chaos on 16/6/22.
//  Copyright © 2016年 Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Type) {
    TypeAll,
    TypeIllustration,
    TypeUIUX,//web_app_icon?limit=40
    TypeDesign,
    TypeHome,
    TypeApparel,
    TypeMen,
    TypeWedding,
    TypeIndustrial,
    TypePhotography,
    TypeModeling,
    TypeFood,
    TypeTravel,
    TypeDIY,
    TypeFitness,
    TypeKids,
    TypePets,
    TypeQuotes,
    TypePeople,
    TypeBeauty,
    TypeDesire,
    TypeGeek,
    TypeAnime,
    TypeArchitecture,
    TypeArt,
    TypeData,
    TypeGames,
    TypeCars,
    TypeMovieBooks,
    TypeTips,
    TypeEducation,
    TypeSports,
    TypeFunny,
    
};

@interface XphotoRequest : NSObject

+(void) getDataRequestWith:(Type)type
                     limit:(NSString *)limit
                Successful:(void(^)(id data))success
                      fail:(void (^)(NSError *error))fail;


+(NSString *)nameWith:(Type)type;
@end

//花瓣  接口抓取
//最新      https://api.huaban.com/all?limit=40
//插画、漫画 https://api.huaban.com/favorite/illustration?limit=40
//UI、UX   https://api.huaban.com/favorite/web_app_icon?limit=40
//平面      https://api.huaban.com/favorite/design?limit=40
//家居、家装 https://api.huaban.com/favorite/home?limit=40
//女装、搭配 https://api.huaban.com/favorite/apparel?limit=40
//男士、风尚 https://api.huaban.com/favorite/men?limit=40
//婚礼      https://api.huaban.com/favorite/wedding_events?limit=40
//工业设计   https://api.huaban.com/favorite/industrial_design?limit=40
//摄影      https://api.huaban.com/favorite/photography?limit=40
//造型、美妆 https://api.huaban.com/favorite/modeling_hair?limit=40
//美食      https://api.huaban.com/favorite/food_drink?limit=40
//旅行      https://api.huaban.com/favorite/travel_places?limit=40
//手工、布艺 https://api.huaban.com/favorite/diy_crafts?limit=40
//健身、舞蹈 https://api.huaban.com/favorite/fitness?limit=40
//儿童      https://api.huaban.com/favorite/kids?limit=40
//宠物      https://api.huaban.com/favorite/pets?limit=40
//美图      https://api.huaban.com/favorite/quotes?limit=40
//明星      https://api.huaban.com/favorite/people?limit=40
//美女      https://api.huaban.com/favorite/beauty?limit=40
//礼物      https://api.huaban.com/favorite/desire?limit=40
//极客      https://api.huaban.com/favorite/geek?limit=40
//动漫      https://api.huaban.com/favorite/anime?limit=40
//建筑设计   https://api.huaban.com/favorite/architecture?limit=40
//人文艺术   https://api.huaban.com/favorite/art?limit=40
//数据图    https://api.huaban.com/favorite/data_presentation?limit=40
//游戏      https://api.huaban.com/favorite/games?limit=40
//汽车、摩托 https://api.huaban.com/favorite/cars_motorcycles?limit=40
//电影、图书 https://api.huaban.com/favorite/film_music_books?limit=40
//生活百科   https://api.huaban.com/favorite/tips?limit=40
//教育      https://api.huaban.com/favorite/education?limit=40
//运动      https://api.huaban.com/favorite/sports?limit=40
//搞笑      https://api.huaban.com/favorite/funny?limit=40
