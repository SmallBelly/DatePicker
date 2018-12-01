//
//  ViewController.m
//  DateView
//
//  Created by Can on 2018/7/27.
//  Copyright © 2018年 hwd. All rights reserved.
//

#import "ViewController.h"
#import "DatePickerView.h"

@interface ViewController ()<DatePickerViewDelegate>

@property (nonatomic, strong) DatePickerView *dataPickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(30, 150, self.view.frame.size.width - 60, 40);
    [button setTitle:@"pickerView" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(creatPickerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)creatPickerView
{
    _dataPickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300) dateInterval:YEAR_SECONDS];
    _dataPickerView.delegate = self;
    [self.view addSubview:_dataPickerView];
}

#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveDelegate:(NSString *)timer {
    NSLog(@"保存点击:%@",timer);
    [_dataPickerView removeFromSuperview];
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelDelegate {
    NSLog(@"取消点击");
    [_dataPickerView removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
