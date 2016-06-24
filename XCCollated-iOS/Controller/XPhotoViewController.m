//
//  XPhootoViewController.m
//  XCCollated-iOS
//
//  Created by Chaos on 16/6/22.
//  Copyright © 2016年 Chaos. All rights reserved.
//

#import "XPhotoViewController.h"
#import "XPhotoCollectionViewCell.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "UIImageView+WebCache.h"
#import "VBFPopFlatButton.h"
#import "XphotoRequest.h"
#import "Xphoto.h"

#define CELL_IDENTIFIER @"XPhotoCell"

@interface XPhotoViewController ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
CHTCollectionViewDelegateWaterfallLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (strong,nonatomic) UILabel *lblType;

@property (nonatomic, strong) Xphoto *photoData;
@end

@implementation XPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setViewUIKit];
    [self getDataWith:TypeTravel Limit:@"40"];
}


- (void)setViewUIKit
{
    VBFPopFlatButton *right = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(0, 0, 15, 15)
                                                         buttonType:buttonUpTriangleType
                                                        buttonStyle:buttonPlainStyle
                                              animateToInitialState:YES];
    right.lineThickness = 2;
    [right addTarget:self  action:@selector(navRightButtonPressed:)
                     forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[[self barItemWithCustomView:right],[self barItemWithCustomView:self.lblType]];
    
    
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    layout.headerHeight = 0;
    layout.footerHeight = 0;
    layout.columnCount = 3;
    layout.minimumColumnSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    [_collectionView setCollectionViewLayout:layout];
    
//    [_collectionView registerClass:[XPhotoCollectionViewCell class]
//        forCellWithReuseIdentifier:CELL_IDENTIFIER];
}

- (UIBarButtonItem *)barItemWithCustomView:(id)custom{
    return [[UIBarButtonItem alloc]initWithCustomView:(UIView *)custom];
}

- (UILabel *)lblType
{
    if (!_lblType) {
        _lblType = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        _lblType.textColor = [UIColor whiteColor];
        _lblType.textAlignment = 2;
        _lblType.font = [UIFont systemFontOfSize:12];
        _lblType.text = @"最新";
    }
    return _lblType;
}

- (void)navRightButtonPressed:(VBFPopFlatButton *)sender
{
    if (sender.selected) {
        [sender animateToType:buttonUpTriangleType];
    }else{
       [sender animateToType:buttonDownTriangleType];
    }
    sender.selected = !sender.selected;
    [_lblType setText:@"种类"];
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_photoData.pins count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XPhotoCollectionViewCell *cell =
    (XPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    
    [cell.img sd_setImageWithURL:[self getImgUrlWith:indexPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSString *str = [_photoData.pins[indexPath.item] raw_text];
        if (str && ![str isEqualToString:@""]) {
            [cell.text setText:str];
            cell.text.hidden = NO;
        }
    }];
    
    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *reusableView = nil;
//    
//    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
//        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                          withReuseIdentifier:HEADER_IDENTIFIER
//                                                                 forIndexPath:indexPath];
//    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
//        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                          withReuseIdentifier:FOOTER_IDENTIFIER
//                                                                 forIndexPath:indexPath];
//    }
//    
//    return reusableView;
//}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"___%@",indexPath);
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self getImgSizeWith:indexPath];
    //    return CGSizeMake(400, 550);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




#pragma mark - data -

- (void) getDataWith:(Type)type Limit:(NSString *)limit
{
    [_waiting setHidden:NO];
    [_waiting startAnimating];
    [XphotoRequest getDataRequestWith:type limit:limit
                           Successful:^(id data) {
                               if (data) {
                                   _photoData = data;
                                   [_collectionView reloadData];
                                   [_waiting setHidden:YES];
                               }
                           }
                                 fail:^(NSError *error) {
                                     NSLog(@"error_%@",error.domain);
                                     [_waiting setHidden:YES];
                                 }];
}

- (void)dealWithData:(Xphoto*)data
{
    
}


- (CGSize)getImgSizeWith:(NSIndexPath *)indexPath
{
    XphotoFile *imgFile = [_photoData.pins[indexPath.item] file];
    
    return CGSizeMake([imgFile.width floatValue], [imgFile.height floatValue]);

}

- (NSURL *)getImgUrlWith:(NSIndexPath *)indexPath
{
    XphotoFile *imgFile = [_photoData.pins[indexPath.item] file];
    NSString *url = @"http://img.hb.aicdn.com/";
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,imgFile.key]];
}

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




@end
