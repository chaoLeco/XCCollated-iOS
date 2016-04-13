//
//  OrderPickerView.m
//  newruishihui
//
//  Created by Chaos on 16/4/11.
//  Copyright © 2016年 iUXLabs. All rights reserved.
//

#import "XCPickerView.h"
#import "Masonry.h"
@interface XCPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic ,copy) pickerViewBlock block;

@property(nonatomic ,strong) NSDate *minDate;
@property(nonatomic ,strong) NSDate *maxDate;

@property(nonatomic ,strong) NSArray *data;

@property(nonatomic ,strong) UIView *backView;

@property(nonatomic ,strong) NSMutableArray *blockStrs;
@property(nonatomic ,strong) NSString *blockStr;
@end
@implementation XCPickerView


- (void)drawRect:(CGRect)rect {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [self moveAnimate:CGRectGetHeight(Bounds) - 195/2];
    }];
}

- (void)moveAnimate:(CGFloat)y
{
    NSLog(@">>>%f...",y);
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    moveAnimation.fromValue = @(_backView.center.y);
    moveAnimation.toValue = @(y);
    moveAnimation.autoreverses = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.repeatCount = 0;
    moveAnimation.duration = 0.3;
    [_backView.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
    [_backView.layer setPosition:CGPointMake(CGRectGetWidth(Bounds)/2,y)];
}

-(instancetype)initWithDefaultPickerView
{
    self = [super init];
    if (self) {
        [self setUIKit];
        [self setDefaultPickerView];
    }
    return self;
}

-(instancetype)initWithDatePickerView
{
    self = [super init];
    if (self) {
        self.alpha = 0.1;
        [self setUIKit];
        [self setDatePickerView];
    }
    return self;
}

-(void)setUIKit
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.58];
    _backView = [UIView new];
    _backView.backgroundColor = RGB(241, 241, 241);
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(195);
    }];
    
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_backView).offset(-15);
        make.top.mas_equalTo(_backView);
    }];
    
    UIButton *leftBtn = [[UIButton alloc]init];
    [leftBtn setTitle:@"确定" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backView).offset(15);
        make.top.mas_equalTo(_backView);
    }];
}

-(void)rightBtnAction
{
    [self moveAnimate:CGRectGetHeight(Bounds) + 200/2];
    [self performSelector:@selector(alphaAnimate) withObject:nil afterDelay:0.3];
    if (_block) {
        _block(nil);
    }
}

-(void)leftBtnAction
{
    [self moveAnimate:CGRectGetHeight(Bounds) + 200/2];
    [self performSelector:@selector(alphaAnimate) withObject:nil afterDelay:0.3];
    if (_block) {
        _block(_blockStr);
    }
}

-(void)alphaAnimate
{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0.1;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - DatePickerView -

-(void)setDatePickerView
{
    if (_backView) {
        UIDatePicker *datePicker = [UIDatePicker new];
        datePicker.backgroundColor = [UIColor whiteColor];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        datePicker.minimumDate = [self getMinDate];
        datePicker.maximumDate = [self getMaxDate];
        [_backView addSubview:datePicker];
        [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(_backView);
            make.height.mas_equalTo(160);
        }];
        [datePicker setDate:_minDate animated:YES];
        [self dateChanged:datePicker];
    }
}

-(NSDate *)getMaxDate
{
    if (!_maxDate) {
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        //设置时间
        [offsetComponents setYear:1];
        [offsetComponents setMonth:0];
        [offsetComponents setDay:0];
        [offsetComponents setHour:0];
        [offsetComponents setMinute:0];
        [offsetComponents setSecond:0];
        //设置最大值时间
        _maxDate = [gregorian dateByAddingComponents:offsetComponents toDate:_minDate options:0];
    }
    return _maxDate;
}

-(NSDate *)getMinDate
{
    if (!_minDate) {
        _minDate = [NSDate date];
    }
    return _minDate;
}

-(void)dateChanged:(id)picker
{
    if ([picker isKindOfClass:[UIDatePicker class]]) {
        UIDatePicker *dataPicker = (UIDatePicker *)picker;
        NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
        [pickerFormatter setDateFormat:@"yyyy年MM月dd日"];
        _blockStr = [pickerFormatter stringFromDate:dataPicker.date];
        if (_block) {
            _block(_blockStr);
        }
    }
}
#pragma mark - DefaultPickerView -

-(void)setData:(NSArray *)data
{
    _data = data;
    
    if ([[_data firstObject] isKindOfClass:[NSArray class]]) {
        _blockStrs = [NSMutableArray array];
        for (NSArray *rows in data) {
            [_blockStrs addObject:[rows firstObject]];
        }
        _blockStr = @"";
        for (NSString *itme in _blockStrs) {
            _blockStr = [NSString stringWithFormat:@"%@%@",_blockStr,itme];
        }
    }
}
-(void)setDefaultPickerView
{
    if (_backView) {
        UIPickerView *pickerView = [UIPickerView new];
        pickerView.backgroundColor = [UIColor whiteColor];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [_backView addSubview:pickerView];
        [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(_backView);
            make.height.mas_equalTo(160);
        }];
        [pickerView selectRow:0 inComponent:0 animated:YES];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([[_data firstObject] isKindOfClass:[NSArray class]]) {
        return _data.count;
    }else return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([[_data firstObject] isKindOfClass:[NSArray class]]) {
        NSArray *rows = _data[component];

        return rows.count;
    }else return _data.count;
}

- ( NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([[_data firstObject] isKindOfClass:[NSArray class]]) {
        NSArray *rows = _data[component];
        return rows[row];
    }else return _data[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([[_data firstObject] isKindOfClass:[NSArray class]]) {
        NSArray *rows = _data[component];
        [_blockStrs removeObjectAtIndex:component];
        [_blockStrs insertObject:rows[row] atIndex:component];
        _blockStr = @"";
        for (NSString *itme in _blockStrs) {
            _blockStr = [NSString stringWithFormat:@"%@%@",_blockStr,itme];
        }
    }else {
        _blockStr = _data[row];
    }
    if (_block) {
        _block(_blockStr);
    }
}
#pragma mark - showView -

+(void)showViewStyleDefaultWithData:(NSArray *)data Block:(pickerViewBlock)block
{
    XCPickerView *_self = [[XCPickerView alloc]initWithDefaultPickerView];
    _self.block = block;
    _self.data = data;
    [KeyWindow addSubview:_self];
    [_self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(KeyWindow);
    }];
}

+(void)showViewStyleDateWithMinDate:(NSDate *)minDate MaxDate:(NSDate *)maxDate Block:(pickerViewBlock)block
{
    XCPickerView *_self = [[XCPickerView alloc]initWithDatePickerView];
    _self.block = block;
    _self.minDate = minDate;
    _self.maxDate = maxDate;
    [KeyWindow addSubview:_self];
    [_self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(KeyWindow);
    }];
}
@end

