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
    _dataSource = @[@"pickerView整理",@"tableView 没有数据"];
    _detailSource = @[@"包括 datepickerView 和普通的pickerView。",@"给别人的内容加了一层tableView的外壳"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"viewContentCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.detailTextLabel.text = _detailSource[indexPath.row];
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
        default:
            break;
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}
@end
