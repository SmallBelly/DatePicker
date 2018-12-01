//
//  DatePickerView.h
//  DateView
//
//  Created by Can on 2018/7/27.
//  Copyright © 2018年 hwd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    YEAR_DAY,     // 年月日
    HOUR_SECONDS, // 时分秒
    YEAR_MINUTE,  // 年月日时分
    YEAR_SECONDS, // 年月日时分秒
} DateInterval;

@protocol DatePickerViewDelegate <NSObject>

/*保存按钮代理方法
 *timer 选择的数据
 */
- (void)datePickerViewSaveDelegate:(NSString *)timer;

/*取消按钮代理方法
 */
- (void)datePickerViewCancelDelegate;

@end

@interface DatePickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong, nonatomic) UIPickerView *pickerView; // 选择器
@property (strong, nonatomic) UIView *toolView;         // 工具条
@property (strong, nonatomic) UILabel *titleLable;      // 标题

@property (strong, nonatomic) NSMutableArray *dataArray;   // 数据源
@property (strong, nonatomic) NSMutableArray *yearArray;   // 年数组
@property (strong, nonatomic) NSMutableArray *monthArray;  // 月数组
@property (strong, nonatomic) NSMutableArray *dayArray;    // 日数组
@property (strong, nonatomic) NSMutableArray *hourArray;   // 时数组
@property (strong, nonatomic) NSMutableArray *minuteArray; // 分数组
@property (strong, nonatomic) NSMutableArray *secondArray; // 秒数组
@property (strong, nonatomic) NSArray *timeArray;          // 当前时间数组

@property (copy, nonatomic) NSString *year;         // 选中年
@property (copy, nonatomic) NSString *month;        // 选中月
@property (copy, nonatomic) NSString *day;          // 选中日
@property (copy, nonatomic) NSString *hour;         // 选中时
@property (copy, nonatomic) NSString *minute;       // 选中分
@property (copy, nonatomic) NSString *second;       // 选中秒
@property (copy, nonatomic) NSString *selectString; // 选中的时间

@property (assign, nonatomic) DateInterval dateInterval; // 选中的时间

@property (weak, nonatomic) id <DatePickerViewDelegate> delegate;

/*创建类输入框
 *frame         位置信息
 *dateInterval  时间区间
 *return        self
 */
- (instancetype)initWithFrame:(CGRect)frame dateInterval:(DateInterval)dateInterval;

@end
