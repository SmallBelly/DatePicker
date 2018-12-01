//
//  DatePickerView.m
//  DateView
//
//  Created by Can on 2018/7/27.
//  Copyright © 2018年 hwd. All rights reserved.
//

#import "DatePickerView.h"

#define THColorRGB(rgb)    [UIColor colorWithRed:(rgb)/255.0 green:(rgb)/255.0 blue:(rgb)/255.0 alpha:1.0]

@implementation DatePickerView

// 初始化
- (instancetype)initWithFrame:(CGRect)frame dateInterval:(DateInterval)dateInterval
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.dateInterval = dateInterval;
        
        self.timeArray = [NSArray array];
        
        self.dataArray = [NSMutableArray array];
        
        [self creatData:dateInterval];

        [self creatToolView];
        
        [self creatPickerView];
        
        [self show:dateInterval];
    }
    return self;
}

- (void)creatData:(DateInterval)dateInterval{
    self.yearArray = [NSMutableArray array];
    for (int i = 1970; i < 2099; i ++) {
        [self.yearArray addObject:[NSString stringWithFormat:@"%d年", i]];
    }
    
    self.monthArray = [NSMutableArray array];
    for (int i = 1; i <= 12; i ++) {
        [self.monthArray addObject:[NSString stringWithFormat:@"%d月", i]];
    }
    
    self.dayArray = [NSMutableArray array];
    for (int i = 1; i <= 31; i ++) {
        [self.dayArray addObject:[NSString stringWithFormat:@"%d日", i]];
    }
    
    self.hourArray = [NSMutableArray array];
    for (int i = 0; i < 24; i ++) {
        [self.hourArray addObject:[NSString stringWithFormat:@"%d时", i]];
    }
    
    self.minuteArray = [NSMutableArray array];
    self.secondArray = [NSMutableArray array];
    for (int i = 0; i <= 59; i ++) {
        [self.minuteArray addObject:[NSString stringWithFormat:@"%d分", i]];
        [self.secondArray addObject:[NSString stringWithFormat:@"%d秒", i]];
    }
    
    NSDate *date = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *newDate = [[[dateFormatter stringFromDate:date] stringByReplacingOccurrencesOfString:@"-" withString:@" "] stringByReplacingOccurrencesOfString:@":" withString:@" "];
    
    switch (dateInterval) {
        case YEAR_DAY:
        {
            NSMutableArray *timerArray = [NSMutableArray arrayWithArray:[newDate componentsSeparatedByString:@" "]];
            [timerArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@年", timerArray[0]]];
            [timerArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@月", timerArray[1]]];
            [timerArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@日", timerArray[2]]];
            self.timeArray = timerArray;
            
            [self.dataArray addObject:self.yearArray];
            [self.dataArray addObject:self.monthArray];
            [self.dataArray addObject:self.dayArray];
        }
            break;
            
        case HOUR_SECONDS:
        {
            NSMutableArray *timerArray = [NSMutableArray arrayWithArray:[newDate componentsSeparatedByString:@" "]];
            [timerArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@时", timerArray[0]]];
            [timerArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@分", timerArray[1]]];
            [timerArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@秒", timerArray[2]]];
            self.timeArray = timerArray;

            [self.dataArray addObject:self.hourArray];
            [self.dataArray addObject:self.minuteArray];
            [self.dataArray addObject:self.secondArray];
        }
            
            break;
            
        case YEAR_MINUTE:
        {
            NSMutableArray *timerArray = [NSMutableArray arrayWithArray:[newDate componentsSeparatedByString:@" "]];
            [timerArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@年", timerArray[0]]];
            [timerArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@月", timerArray[1]]];
            [timerArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@日", timerArray[2]]];
            [timerArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%@时", timerArray[3]]];
            [timerArray replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%@分", timerArray[4]]];
            self.timeArray = timerArray;
            
            [self.dataArray addObject:self.yearArray];
            [self.dataArray addObject:self.monthArray];
            [self.dataArray addObject:self.dayArray];
            [self.dataArray addObject:self.hourArray];
            [self.dataArray addObject:self.minuteArray];
        }
            
            break;
            
        case YEAR_SECONDS:
        {
            NSMutableArray *timerArray = [NSMutableArray arrayWithArray:[newDate componentsSeparatedByString:@" "]];
            [timerArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@年", timerArray[0]]];
            [timerArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@月", timerArray[1]]];
            [timerArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@日", timerArray[2]]];
            [timerArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%@时", timerArray[3]]];
            [timerArray replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%@分", timerArray[4]]];
            [timerArray replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%@秒", timerArray[5]]];
            self.timeArray = timerArray;
            
            [self.dataArray addObject:self.yearArray];
            [self.dataArray addObject:self.monthArray];
            [self.dataArray addObject:self.dayArray];
            [self.dataArray addObject:self.hourArray];
            [self.dataArray addObject:self.minuteArray];
            [self.dataArray addObject:self.secondArray];
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 配置界面
/// 配置工具条
- (void)creatToolView {
    
    self.toolView = [[UIView alloc] init];
    self.toolView.frame = CGRectMake(0, 0, self.frame.size.width, 44);
    [self addSubview:self.toolView];
    
    UIButton *saveBtn = [[UIButton alloc] init];
    saveBtn.frame = CGRectMake(self.frame.size.width - 50, 2, 40, 40);
    [saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    [saveBtn setTitleColor:THColorRGB(34) forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:saveBtn];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(10, 2, 40, 40);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:THColorRGB(34) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:cancelBtn];
    
    self.titleLable = [[UILabel alloc] init];
    self.titleLable.frame = CGRectMake(60, 2, self.frame.size.width - 120, 40);
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.textColor = THColorRGB(34);
    self.titleLable.text = @"请选择时间";
    [self.toolView addSubview:self.titleLable];
}

/// 配置UIPickerView
- (void)creatPickerView {
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.toolView.frame), self.frame.size.width, self.frame.size.height - 44)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    [self addSubview:self.pickerView];
}

- (void)show:(DateInterval)dateInterval {
    self.year   = self.timeArray[0];
    self.month  = [NSString stringWithFormat:@"%d月", [self.timeArray[1] intValue]];
    self.day    = [NSString stringWithFormat:@"%d日", [self.timeArray[2] intValue]];
    self.hour   = [NSString stringWithFormat:@"%d时", [self.timeArray[3] intValue]];
    self.minute = [NSString stringWithFormat:@"%d分", [self.timeArray[4] intValue]];
    self.second = [NSString stringWithFormat:@"%d秒", [self.timeArray[5] intValue]];
    
    switch (dateInterval) {
        case YEAR_DAY:
        {
            [self.pickerView selectRow:[self.yearArray indexOfObject:self.year] inComponent:0 animated:YES];
            /// 重新格式化转一下，是因为如果是09月/日/时，数据源是9月/日/时,就会出现崩溃
            [self.pickerView selectRow:[self.monthArray indexOfObject:self.month] inComponent:1 animated:YES];
            [self.pickerView selectRow:[self.dayArray indexOfObject:self.day] inComponent:2 animated:YES];
            
            // 刷新日
            [self refreshDay];
        }
            
            break;
            
        case HOUR_SECONDS:
        {
            [self.pickerView selectRow:[self.hourArray indexOfObject:self.hour] inComponent:0 animated:YES];
            [self.pickerView selectRow:[self.minuteArray indexOfObject:self.minute] inComponent:1 animated:YES];
            [self.pickerView selectRow:[self.secondArray indexOfObject:self.second] inComponent:2 animated:YES];
        }
            
            break;
            
        case YEAR_MINUTE:
        {
            [self.pickerView selectRow:[self.yearArray indexOfObject:self.year] inComponent:0 animated:YES];
            /// 重新格式化转一下，是因为如果是09月/日/时，数据源是9月/日/时,就会出现崩溃
            [self.pickerView selectRow:[self.monthArray indexOfObject:self.month] inComponent:1 animated:YES];
            [self.pickerView selectRow:[self.dayArray indexOfObject:self.day] inComponent:2 animated:YES];
            [self.pickerView selectRow:[self.hourArray indexOfObject:self.hour] inComponent:3 animated:YES];
            [self.pickerView selectRow:[self.minuteArray indexOfObject:self.minute] inComponent:4 animated:YES];
            
            // 刷新日
            [self refreshDay];
        }
            
            break;
            
        case YEAR_SECONDS:
        {
            [self.pickerView selectRow:[self.yearArray indexOfObject:self.year] inComponent:0 animated:YES];
            /// 重新格式化转一下，是因为如果是09月/日/时，数据源是9月/日/时,就会出现崩溃
            [self.pickerView selectRow:[self.monthArray indexOfObject:self.month] inComponent:1 animated:YES];
            [self.pickerView selectRow:[self.dayArray indexOfObject:self.day] inComponent:2 animated:YES];
            [self.pickerView selectRow:[self.hourArray indexOfObject:self.hour] inComponent:3 animated:YES];
            [self.pickerView selectRow:[self.minuteArray indexOfObject:self.minute] inComponent:4 animated:YES];
            [self.pickerView selectRow:[self.secondArray indexOfObject:self.second] inComponent:5 animated:YES];
            
            // 刷新日
            [self refreshDay];
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 点击方法
// 保存按钮点击方法
- (void)saveBtnClick {
    NSLog(@"点击了保存");
    
    NSString *month = self.month.length == 3 ? [NSString stringWithFormat:@"%d", self.month.intValue] : [NSString stringWithFormat:@"0%d", self.month.intValue];
    NSString *day = self.day.length == 3 ? [NSString stringWithFormat:@"%d", self.day.intValue] : [NSString stringWithFormat:@"0%d", self.day.intValue];
    NSString *hour = self.hour.length == 3 ? [NSString stringWithFormat:@"%d", self.hour.intValue] : [NSString stringWithFormat:@"0%d", self.hour.intValue];
    NSString *minute = self.minute.length == 3 ? [NSString stringWithFormat:@"%d", self.minute.intValue] : [NSString stringWithFormat:@"0%d", self.minute.intValue];
    NSString *second = self.second.length == 3 ? [NSString stringWithFormat:@"%d", self.second.intValue] : [NSString stringWithFormat:@"0%d", self.second.intValue];
    
    switch (self.dateInterval) {
        case YEAR_DAY:
        {
            self.selectString = [NSString stringWithFormat:@"%d-%@-%@", [self.year intValue], month, day];
        }
            break;
            
        case HOUR_SECONDS:
        {
            self.selectString = [NSString stringWithFormat:@"%@:%@:%@",hour, minute, second];
        }
            break;
            
        case YEAR_MINUTE:
        {
            self.selectString = [NSString stringWithFormat:@"%d-%@-%@  %@:%@", [self.year intValue], month, day, hour, minute];
        }
            break;
            
        case YEAR_SECONDS:
        {
            self.selectString = [NSString stringWithFormat:@"%d-%@-%@  %@:%@:%@", [self.year intValue], month, day, hour, minute, second];
        }
            break;
            
        default:
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(datePickerViewSaveDelegate:)]) {
        [self.delegate datePickerViewSaveDelegate:self.selectString];
    }
}

// 取消按钮点击方法
- (void)cancelBtnClick {
    NSLog(@"点击了取消");
    if ([self.delegate respondsToSelector:@selector(datePickerViewCancelDelegate)]) {
        [self.delegate datePickerViewCancelDelegate];
    }
}

#pragma mark - UIPickerViewDelegate and UIPickerViewDataSource
// UIPickerView返回多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataArray.count;
}

// UIPickerView返回每组多少条数据
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  [self.dataArray[component] count] * 200;
}

// UIPickerView选择哪一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    switch (self.dateInterval) {
        case YEAR_DAY:
        {
            switch (component) {
                case 0: { // 年
                    NSString *year_integerValue = self.yearArray[row%[self.dataArray[component] count]];
                    self.year = year_integerValue;
                    
                } break;
                case 1: { // 月
                    NSString *month_value = self.monthArray[row%[self.dataArray[component] count]];
                    self.month = month_value;
                    /// 刷新日
                    [self refreshDay];
                    
                } break;
                case 2: { // 日
                    NSString *day_value = self.dayArray[row%[self.dataArray[component] count]];
                    self.day = day_value;
                    
                } break;
                
                default: break;
            }
        }
            break;
            
        case HOUR_SECONDS:
        {
            switch (component) {
                
                case 0: { // 时
                    NSString *hour_value = self.hourArray[row%[self.dataArray[component] count]];
                    self.hour = hour_value;
                    
                } break;
                case 1: { // 分
                    self.minute = self.minuteArray[row%[self.dataArray[component] count]];
                    
                } break;
                case 2: { // 秒
                    self.second = self.secondArray[row%[self.dataArray[component] count]];
                    
                } break;
                default: break;
            }
        }
            break;
            
        case YEAR_MINUTE:
        {
            switch (component) {
                case 0: { // 年
                    NSString *year_integerValue = self.yearArray[row%[self.dataArray[component] count]];
                    self.year = year_integerValue;
                    
                } break;
                case 1: { // 月
                    NSString *month_value = self.monthArray[row%[self.dataArray[component] count]];
                    self.month = month_value;
                    /// 刷新日
                    [self refreshDay];
                    
                } break;
                case 2: { // 日
                    NSString *day_value = self.dayArray[row%[self.dataArray[component] count]];
                    self.day = day_value;
                    
                } break;
                case 3: { // 时
                    NSString *hour_value = self.hourArray[row%[self.dataArray[component] count]];
                    self.hour = hour_value;
                    
                } break;
                case 4: { // 分
                    self.minute = self.minuteArray[row%[self.dataArray[component] count]];
                    
                } break;
        
                default: break;
            }
        }
            break;
            
        case YEAR_SECONDS:
        {
            switch (component) {
                case 0: { // 年
                    NSString *year_integerValue = self.yearArray[row%[self.dataArray[component] count]];
                    self.year = year_integerValue;
                    
                } break;
                case 1: { // 月
                    NSString *month_value = self.monthArray[row%[self.dataArray[component] count]];
                    self.month = month_value;
                    /// 刷新日
                    [self refreshDay];
                    
                } break;
                case 2: { // 日
                    NSString *day_value = self.dayArray[row%[self.dataArray[component] count]];
                    self.day = day_value;
                    
                } break;
                case 3: { // 时
                    NSString *hour_value = self.hourArray[row%[self.dataArray[component] count]];
                    self.hour = hour_value;
                    
                } break;
                case 4: { // 分
                    self.minute = self.minuteArray[row%[self.dataArray[component] count]];
                    
                } break;
                case 5: { // 秒
                    self.second = self.secondArray[row%[self.dataArray[component] count]];
                    
                } break;
                default: break;
            }
        }
            break;
            
        default:
            break;
    }
}

// UIPickerView返回每一行数据
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  [self.dataArray[component] objectAtIndex:row%[self.dataArray[component] count]];
}

// UIPickerView返回每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

// UIPickerView返回每一行的View
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *titleLbl;
    if (!view) {
        titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 44)];
        titleLbl.font = [UIFont systemFontOfSize:15];
        titleLbl.textAlignment = NSTextAlignmentCenter;
    } else {
        titleLbl = (UILabel *)view;
    }
    titleLbl.text = [self.dataArray[component] objectAtIndex:row%[self.dataArray[component] count]];
    return titleLbl;
}

- (void)pickerViewLoaded:(NSInteger)component row:(NSInteger)row{
    NSUInteger max = 16384;
    NSUInteger base10 = (max/2)-(max/2)%row;
    [self.pickerView selectRow:[self.pickerView selectedRowInComponent:component] % row + base10 inComponent:component animated:NO];
}

// 比较选择的时间是否小于当前时间
- (int)compareDate:(NSString *)date01 withDate:(NSString *)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy年,MM月,dd日,HH时,mm分"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result) {
            //date02比date01大
        case NSOrderedAscending: ci = 1; break;
            //date02比date01小
        case NSOrderedDescending: ci = -1; break;
            //date02=date01
        case NSOrderedSame: ci = 0; break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1);break;
    }
    return ci;
}

- (void)refreshDay {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i < [self getDayNumber:self.year.integerValue month:self.month.integerValue].integerValue + 1; i ++) {
        [arr addObject:[NSString stringWithFormat:@"%d日", i]];
    }
    
    [self.dataArray replaceObjectAtIndex:2 withObject:arr];
    [self.pickerView reloadComponent:2];
}

- (NSString *)getDayNumber:(NSInteger)year month:(NSInteger)month{
    NSArray *days = @[@"31", @"28", @"31", @"30", @"31", @"30", @"31", @"31", @"30", @"31", @"30", @"31"];
    if (2 == month && 0 == (year % 4) && (0 != (year % 100) || 0 == (year % 400))) {
        return @"29";
    }
    return days[month - 1];
}

@end
