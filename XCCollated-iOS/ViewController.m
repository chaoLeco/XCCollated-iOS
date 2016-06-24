//
//  ViewController.m
//  XCCollated-iOS
//
//  Created by Chaos on 16/4/13.
//  Copyright © 2016年 Chaos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic ,strong) NSArray *dataSource;
@property(nonatomic ,strong) NSArray *detailSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"pickerView整理",@"tableView 没有数据",@"图片的拉伸",@"瀑布流照片展示"];
    }
    return _dataSource;
}

-(NSArray *)detailSource
{
    if (!_detailSource) {
        _detailSource = @[@"包括 datepickerView 和普通的pickerView。",
                         @"给别人的内容加了一层tableView的外壳",
                         @"跟随ScrollView的滑动缩放图片",
                         @"图片来源于“花瓣”，使用layoutSDK"];
    }
    return _detailSource;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"viewContentCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.detailTextLabel.text = self.detailSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"pickerViewSbSegue" sender:indexPath];
            break;
        case 1:
            [self performSegueWithIdentifier:@"TableViewSbSegue" sender:indexPath];
            break;
        case 2:
            [self performSegueWithIdentifier:@"picStrectchSegue" sender:indexPath];
            break;
        case 3:
            [self performSegueWithIdentifier:@"photoViewSbSegue" sender:indexPath];
            break;
        default:
            break;
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}
@end
