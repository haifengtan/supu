//
//  OrderListCell.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-20.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "OrderListCell.h"

@interface OrderListCell ()

@property (retain, nonatomic) UILabel *ordernumberlabel;
@property (retain, nonatomic) UILabel *orderpricelabel;
@property (retain, nonatomic) UILabel *ordertimelabel;
@property (retain, nonatomic) UILabel *orderstatuslabel;
@property BOOL isPad;

@end

@implementation OrderListCell
@synthesize personalorderobj  = _personalorderobj;
@synthesize ordernumberlabel;
@synthesize orderpricelabel;
@synthesize ordertimelabel;
@synthesize orderstatuslabel;
@synthesize isPad;

- (void)dealloc
{
    [_personalorderobj release];
    [ordernumberlabel release];
    [orderpricelabel release];
    [ordertimelabel release];
    [orderstatuslabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self.isPad = iPad;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *ordernubmer = nil;
        UILabel *orderprice = nil;
        UILabel *ordertime = nil;
        UILabel *orderstatus = nil;
        UIImageView *orderdetailpic = nil;
        if (self.isPad) {
            ordernubmer = [[UILabel alloc] initWithFrame:CGRectMake(32, 10, 100, 30)];
            ordernubmer.font = [UIFont boldSystemFontOfSize:24];
            ordernumberlabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 400, 30)];
            self.ordernumberlabel.font = [UIFont boldSystemFontOfSize:24];
            orderprice = [[UILabel alloc] initWithFrame:CGRectMake(32, 42, 100, 30)];
            orderprice.font = [UIFont boldSystemFontOfSize:24];
            orderpricelabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 42, 400, 30)];
            self.orderpricelabel.font = [UIFont boldSystemFontOfSize:24];
            ordertime = [[UILabel alloc] initWithFrame:CGRectMake(32, 75, 120, 30)];
            ordertime.font = [UIFont boldSystemFontOfSize:24];
            ordertimelabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 75, 400, 30)];
            self.ordertimelabel.font = [UIFont boldSystemFontOfSize:24];
            orderstatus = [[UILabel alloc] initWithFrame:CGRectMake(32, 108, 80, 30)];
            orderstatus.font = [UIFont boldSystemFontOfSize:24];
            orderstatuslabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 108, 400, 30)];
            self.orderstatuslabel.font = [UIFont boldSystemFontOfSize:24];
            orderdetailpic = [[UIImageView alloc] initWithFrame:CGRectMake(722, 60, 14, 24)];
        }else{
            ordernubmer = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 50, 15)];
            ordernubmer.font = [UIFont boldSystemFontOfSize:12];
            ordernumberlabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 200, 15)];
            self.ordernumberlabel.font = [UIFont boldSystemFontOfSize:12];
            orderprice = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 50, 15)];
            orderprice.font = [UIFont boldSystemFontOfSize:12];
            orderpricelabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, 200, 15)];
            self.orderpricelabel.font = [UIFont boldSystemFontOfSize:12];
            ordertime = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 60, 15)];
            ordertime.font = [UIFont boldSystemFontOfSize:12];
            ordertimelabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, 200, 15)];
            self.ordertimelabel.font = [UIFont boldSystemFontOfSize:12];
            orderstatus = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 38, 15)];
            orderstatus.font = [UIFont boldSystemFontOfSize:12];
            orderstatuslabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 50, 200, 15)];
            self.orderstatuslabel.font = [UIFont boldSystemFontOfSize:12];
            orderdetailpic = [[UIImageView alloc] initWithFrame:CGRectMake(290, 30, 7, 11)];
        }
        ordernubmer.text = @"订单号：";
        ordernubmer.backgroundColor = [UIColor clearColor];
        [self addSubview:ordernubmer];
        [ordernubmer release];
        
        
        
        self.ordernumberlabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.ordernumberlabel];
        
        orderprice.text = @"总价：￥";
        orderprice.backgroundColor = [UIColor clearColor];
        [self addSubview:orderprice];
        [orderprice release];
        
        
        self.orderpricelabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.orderpricelabel];
        
        ordertime.text = @"下单时间：";
        ordertime.backgroundColor = [UIColor clearColor];
        [self addSubview:ordertime];
        [ordertime release];
        

        self.ordertimelabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.ordertimelabel];
        
        
        orderstatus.text = @"状态：";
        orderstatus.backgroundColor = [UIColor clearColor];
        [self addSubview:orderstatus];
        [orderstatus release];
        
        self.orderstatuslabel.backgroundColor = [UIColor clearColor];
        self.orderstatuslabel.textColor = [UIColor redColor];
        [self addSubview:self.orderstatuslabel];
        
        orderdetailpic.image = [UIImage imageNamed:@"小箭头.png"];
        [self addSubview:orderdetailpic];
        [orderdetailpic release];
        
        UIImageView *cellbackgroundview = [[UIImageView alloc] initWithFrame:self.bounds];
        cellbackgroundview.image = [UIImage imageNamed:@"背景.png"];
        self.backgroundView = cellbackgroundview;
        [cellbackgroundview release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPersonalorderobj:(PersonalOrder *)personalorderobj
{
    [personalorderobj retain];
    [_personalorderobj release];
    _personalorderobj = personalorderobj;
    self.ordernumberlabel.text = _personalorderobj.OrderSN;
    self.orderpricelabel.text = [NSString stringWithFormat:@"%.2f",[_personalorderobj.OrderAmount floatValue]+[_personalorderobj.ShippingFee floatValue]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_personalorderobj.AddTime.doubleValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datestr = [formatter stringFromDate:date];
    [formatter release];
    self.ordertimelabel.text = datestr;
    self.orderstatuslabel.text = _personalorderobj.OrderStatus;
}

@end
