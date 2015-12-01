//
//  DailyCalendarView.m
//  Deputy
//
//  Created by Caesar on 30/10/2014.
//  Copyright (c) 2014 Caesar Li
//
#import "DailyCalendarView.h"
#import "NSDate+CL.h"
#import "UIColor+CL.h"

@interface DailyCalendarView()
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *dateLabelContainer;
@end


#define DATE_LABEL_SIZE 28
#define DATE_LABEL_FONT_SIZE 13
#define DATE_LABEL_SIZE_SELECTED 45
#define DATE_LABEL_FONT_SIZE_SELECTED 14
#define DATE_LABEL_FONT_COLOR [UIColor colorWithRed:0.333 green:0.831 blue:0.776 alpha:1.000]
#define DATE_LABEL_FONT_COLOR_SELECTED [UIColor colorWithRed:0.208 green:0.698 blue:0.863 alpha:1.000]
#define DATE_LABEL_BG_COLOR [UIColor whiteColor]
#define DATE_LABEL_BG_COLOR_SELECTED [UIColor whiteColor]


@implementation DailyCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.dateLabelContainer];
        
        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dailyViewDidClick:)];
        [self addGestureRecognizer:singleFingerTap];
    }
    return self;
}
-(UIView *)dateLabelContainer
{
    if(!_dateLabelContainer){
        float x = (self.bounds.size.width - DATE_LABEL_SIZE)/2;
        _dateLabelContainer = [[UIView alloc] initWithFrame:CGRectMake(x, x, DATE_LABEL_SIZE, DATE_LABEL_SIZE)];
        _dateLabelContainer.backgroundColor = DATE_LABEL_BG_COLOR;
        _dateLabelContainer.layer.cornerRadius = DATE_LABEL_SIZE/2;
        _dateLabelContainer.clipsToBounds = YES;
        [_dateLabelContainer addSubview:self.dateLabel];
    }
    return _dateLabelContainer;
}
-(UILabel *)dateLabel
{
    if(!_dateLabel){
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DATE_LABEL_SIZE, DATE_LABEL_SIZE)];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textColor = DATE_LABEL_FONT_COLOR;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:DATE_LABEL_FONT_SIZE];
        
        [_dateLabel setNumberOfLines:2];
    }
    
    return _dateLabel;
}

-(void)setDate:(NSDate *)date
{
    _date = date;
    
    [self setNeedsDisplay];
}
-(void)setBlnSelected: (BOOL)blnSelected
{
    _blnSelected = blnSelected;
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    self.dateLabel.text = [self.date getDateOfMonth];
    
    if (_blnSelected) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"M月\nd日"];
        self.dateLabel.text = [formatter stringFromDate:self.date];
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"d"];
        self.dateLabel.text = [formatter stringFromDate:self.date];
    }
}

-(void)markSelected:(BOOL)blnSelected
{
    //    DLog(@"mark date selected %@ -- %d",self.date, blnSelected);
    /*
    if([self.date isDateToday]){
        self.dateLabelContainer.backgroundColor = (blnSelected)?[UIColor whiteColor]: [UIColor colorWithHex:0x0081c1];
        
        self.dateLabel.textColor = (blnSelected)?[UIColor colorWithHex:0x0081c1]:[UIColor whiteColor];
    }else{
        self.dateLabelContainer.backgroundColor = (blnSelected)?[UIColor whiteColor]: [UIColor clearColor];
        
        self.dateLabel.textColor = (blnSelected)?[UIColor colorWithRed:52.0/255.0 green:161.0/255.0 blue:255.0/255.0 alpha:1.0]:[self colorByDate];
    }
    */
    
    if (blnSelected) {
        float x = (self.bounds.size.width - DATE_LABEL_SIZE_SELECTED)/2;
        [_dateLabelContainer setFrame:CGRectMake(x, x, DATE_LABEL_SIZE_SELECTED, DATE_LABEL_SIZE_SELECTED)];
        [_dateLabelContainer.layer setCornerRadius:DATE_LABEL_SIZE_SELECTED / 2];
        [_dateLabelContainer setBackgroundColor:DATE_LABEL_BG_COLOR_SELECTED];
        [_dateLabel setFrame:CGRectMake(0, 0, DATE_LABEL_SIZE_SELECTED, DATE_LABEL_SIZE_SELECTED)];
        [_dateLabel setFont:[UIFont systemFontOfSize:DATE_LABEL_FONT_SIZE_SELECTED]];
        [_dateLabel setTextColor:DATE_LABEL_FONT_COLOR_SELECTED];
    } else {
        float x = (self.bounds.size.width - DATE_LABEL_SIZE)/2;
        [_dateLabelContainer setFrame:CGRectMake(x, x, DATE_LABEL_SIZE, DATE_LABEL_SIZE)];
        [_dateLabelContainer.layer setCornerRadius:DATE_LABEL_SIZE / 2];
        [_dateLabelContainer setBackgroundColor:DATE_LABEL_BG_COLOR];
        [_dateLabel setFrame:CGRectMake(0, 0, DATE_LABEL_SIZE, DATE_LABEL_SIZE)];
        [_dateLabel setFont:[UIFont systemFontOfSize:DATE_LABEL_FONT_SIZE]];
        [_dateLabel setTextColor:DATE_LABEL_FONT_COLOR];
    }
    
    _blnSelected = blnSelected;
    [self setNeedsDisplay];
    
}
-(UIColor *)colorByDate
{
    return [self.date isPastDate]?[UIColor colorWithHex:0x7BD1FF]:[UIColor whiteColor];
}

-(void)dailyViewDidClick: (UIGestureRecognizer *)tap
{
    [self.delegate dailyCalendarViewDidSelect: self.date];
}
@end

