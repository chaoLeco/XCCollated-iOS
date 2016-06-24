//
//  XCPickerViewController.m
//  XCCollated-iOS
//
//  Created by Chaos on 16/4/13.
//  Copyright © 2016年 Chaos. All rights reserved.
//

#import "XCPickerViewController.h"
#import "XCPickerView.h"

@interface XCPickerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbltext;

@end

@implementation XCPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickerAction1:(id)sender {
    [XCPickerView showViewStyleDefaultWithData:@[@[@"1",@"11",@"111"],@[@"2",@"22",@"222"],@[@"3",@"33",@"333"]] Block:^(id data) {
        _lbltext.text = data;
    }];
}

- (IBAction)pickerAction2:(id)sender {
    [XCPickerView showViewStyleDateWithMinDate:nil MaxDate:nil Block:^(id data) {
        _lbltext.text = data;

    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
