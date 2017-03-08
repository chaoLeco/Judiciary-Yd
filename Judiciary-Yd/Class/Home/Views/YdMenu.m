//
//  YdMenu.m
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/8.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdMenu.h"

@implementation YdMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)menu {
    return [[YdMenu alloc] init];
}


-(void)setDatas:(NSArray *)datas
{
    _datas = datas;
    self.frame = CGRectMake(0, 0, 100, datas.count*30);
    if (datas) {
        UITableView *table = [[UITableView alloc]initWithFrame:self.bounds];
        table.dataSource = self;
        table.delegate = self;
        table.rowHeight = 30;
        table.tableFooterView = [UIView new];
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.bounces = NO;
        [self addSubview:table];
    }else
        return;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5,cell.bounds.size.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:line];
        
    }
    
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_block) {
        _block(indexPath.row,_datas[indexPath.row]);
    }
}

@end
