//
//  XCPicStretchViewController.m
//  XCCollated-iOS
//
//  Created by Chaos on 16/5/4.
//  Copyright © 2016年 Chaos. All rights reserved.
//

#import "XCPicStretchViewController.h"
@interface XCPicStretchViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
@implementation XCPicStretchViewController
#pragma mark - table -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;//cell数量
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *const identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"下拉图片放大";
    return cell;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    CGFloat scale = 1.0;
    // 放大
    if (offsetY < 0) {
        // 允许下拉放大的最大距离为300
        // 1.5是放大的最大倍数，当达到最大时，大小为：1.5 * 70 = 105
        // 这个值可以自由调整
        scale = MIN(2.0, 1 - offsetY / 500);
    } else if (offsetY > 0) { // 缩小
        // 允许向上超过导航条缩小的最大距离为300
        // 为了防止缩小过度，给一个最小值为0.45，其中0.45 = 31.5 / 70.0，表示
        // 头像最小是31.5像素
        scale = MAX(0.45, 1 - offsetY / 500);
    }
    
    self.imgView.transform = CGAffineTransformMakeScale(scale, scale);
}

@end
