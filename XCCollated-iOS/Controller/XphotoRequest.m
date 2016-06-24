//
//  XphotoRequest.m
//  XCCollated-iOS
//
//  Created by Chaos on 16/6/22.
//  Copyright © 2016年 Chaos. All rights reserved.
//

#import "XphotoRequest.h"
#import "XCNetworking.h"
#import "Xphoto.h"
@implementation XphotoRequest

+(void)getDataRequestWith:(Type)type limit:(NSString *)limit Successful:(void (^)(id))success fail:(void (^)(NSError *))fail
{
    [XCNetworking XC_GET_JSONDataWithUrl:[self urlWith:type]
                                  Params:@{@"limit":limit}
                                 success:^(id json) {
                                     NSError *error;
                                     Xphoto *photo = [MTLJSONAdapter modelOfClass:[Xphoto class]
                                                                     fromJSONDictionary:json
                                                                                  error:&error];
                                     if (photo) {
                                         success(photo);
                                     }else{
                                         fail(error);
                                     }
                                 }
                                    fail:^(NSError *error) {
                                        fail(error);
                                    }];
    
}

+ (NSString *)urlWith:(Type)type
{
    NSString * uu;
    switch (type) {
        case TypeAll:
            uu = @"https://api.huaban.com/all";
            break;
        case TypeIllustration:
            uu = @"https://api.huaban.com/favorite/illustration";
            break;
        case TypeUIUX:
            uu = @"https://api.huaban.com/favorite/web_app_icon";
            break;
        case TypeDesign:
            uu = @"https://api.huaban.com/favorite/design";
            break;
        case TypeHome:
            uu = @"https://api.huaban.com/favorite/home";
            break;
        case TypeApparel:
            uu = @"https://api.huaban.com/favorite/apparel";
            break;
        case TypeMen:
            uu = @"https://api.huaban.com/favorite/men";
            break;
        case TypeWedding:
            uu = @"https://api.huaban.com/favorite/wedding_events";
            break;
        case TypeIndustrial:
            uu = @"https://api.huaban.com/favorite/industrial_design";
            break;
        case TypePhotography:
            uu = @"https://api.huaban.com/favorite/photography";
            break;
        case TypeModeling:
            uu = @"https://api.huaban.com/favorite/modeling_hair";
            break;
        case TypeFood:
            uu = @"https://api.huaban.com/favorite/food_drink";
            break;
        case TypeTravel:
            uu = @"https://api.huaban.com/favorite/travel_places";
            break;
        case TypeDIY:
            uu = @"https://api.huaban.com/favorite/diy_crafts";
            break;
        case TypeFitness:
            uu = @"https://api.huaban.com/favorite/fitness";
            break;
        case TypeKids:
            uu = @"https://api.huaban.com/favorite/kids";
            break;
        case TypePets:
            uu = @"https://api.huaban.com/favorite/pets";
            break;
        case TypeQuotes:
            uu = @"https://api.huaban.com/favorite/quotes";
            break;
        case TypePeople:
            uu = @"https://api.huaban.com/favorite/people";
            break;
        case TypeBeauty:
            uu = @"https://api.huaban.com/favorite/beauty";
            break;
        case TypeDesire:
            uu = @"https://api.huaban.com/favorite/desire";
            break;
        case TypeGeek:
            uu = @"https://api.huaban.com/favorite/geek";
            break;
        case TypeAnime:
            uu = @"https://api.huaban.com/favorite/anime";
            break;
        case TypeArchitecture:
            uu = @"https://api.huaban.com/favorite/architecture";
            break;
        case TypeArt:
            uu = @"https://api.huaban.com/favorite/art";
            break;
        case TypeData:
            uu = @"https://api.huaban.com/favorite/data_presentation";
            break;
        case TypeGames:
            uu = @"https://api.huaban.com/favorite/games";
            break;
        case TypeCars:
            uu = @"https://api.huaban.com/favorite/cars_motorcycles";
            break;
        case TypeMovieBooks:
            uu = @"https://api.huaban.com/favorite/film_music_books";
            break;
        case TypeTips:
            uu = @"https://api.huaban.com/favorite/tips";
            break;
        case TypeEducation:
            uu = @"https://api.huaban.com/favorite/education";
            break;
        case TypeSports:
            uu = @"https://api.huaban.com/favorite/sports";
            break;
        case TypeFunny:
            uu = @"https://api.huaban.com/favorite/funny";
            break;
        default:
            uu = @"https://api.huaban.com/all";
            break;
    }
    return uu;
}


+(NSString *)nameWith:(Type)type
{
    NSString * uu;
    switch (type) {
        case TypeAll:
            uu = @"最新";
            break;
        case TypeIllustration:
            uu = @"插画、漫画";
            break;
        case TypeUIUX:
            uu = @"UI、UX";
            break;
        case TypeDesign:
            uu = @"平面";
            break;
        case TypeHome:
            uu = @"家居、家装";
            break;
        case TypeApparel:
            uu = @"女装、搭配";
            break;
        case TypeMen:
            uu = @"男士、风尚";
            break;
        case TypeWedding:
            uu = @"婚礼";
            break;
        case TypeIndustrial:
            uu = @"工业设计";
            break;
        case TypePhotography:
            uu = @"摄影";
            break;
        case TypeModeling:
            uu = @"造型、美妆";
            break;
        case TypeFood:
            uu = @"美食";
            break;
        case TypeTravel:
            uu = @"旅行";
            break;
        case TypeDIY:
            uu = @"手工、布艺";
            break;
        case TypeFitness:
            uu = @"健身、舞蹈";
            break;
        case TypeKids:
            uu = @"儿童 ";
            break;
        case TypePets:
            uu = @"宠物";
            break;
        case TypeQuotes:
            uu = @"美图";
            break;
        case TypePeople:
            uu = @"明星";
            break;
        case TypeBeauty:
            uu = @"美女";
            break;
        case TypeDesire:
            uu = @"礼物";
            break;
        case TypeGeek:
            uu = @"极客";
            break;
        case TypeAnime:
            uu = @"动漫";
            break;
        case TypeArchitecture:
            uu = @"建筑设计";
            break;
        case TypeArt:
            uu = @"人文艺术";
            break;
        case TypeData:
            uu = @"数据图";
            break;
        case TypeGames:
            uu = @"游戏";
            break;
        case TypeCars:
            uu = @"汽车、摩托";
            break;
        case TypeMovieBooks:
            uu = @"电影、图书";
            break;
        case TypeTips:
            uu = @"生活百科";
            break;
        case TypeEducation:
            uu = @"教育";
            break;
        case TypeSports:
            uu = @"运动";
            break;
        case TypeFunny:
            uu = @"搞笑";
            break;
        default:
            uu = @"最新";
            break;
    }
    return uu;
}
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