//
//  XCTableViewController.m
//  XCCollated-iOS
//
//  Created by Chaos on 16/4/14.
//  Copyright © 2016年 Chaos. All rights reserved.
//

#import "XCTableViewController.h"

@implementation XCTableViewController


-(void)viewDidLoad
{
    [_tableView setDelegate];
    _tableView.XCTitle = [[NSAttributedString alloc] initWithString:@"TableView无数据"
                                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],            NSForegroundColorAttributeName:RGB(147, 147, 147)}];
    _tableView.XCImage = [UIImage imageNamed:@"ownerAuth_page3_img"];
}
@end
