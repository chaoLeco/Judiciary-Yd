//
//  YdListViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/22.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdListViewController.h"
#import "YdListTableViewCell.h"
#import "YdwebViewController.h"
#import "YdnewsListModel.h"
@interface YdListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign,nonatomic) NSInteger nowPage;
@property (assign,nonatomic) NSInteger totalPage;
@property (strong,nonatomic) NSMutableArray *dataSource;
@end

@implementation YdListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setItemtitle];
    [self setTableRefresh];
}

- (void)setItemtitle
{
//    1：法律条文 2：司法解释 3：司法案例 4：法律文献
    switch ([_newstype intValue]) {
        case 1:
            self.navigationItem.title = @"法律条文";
            break;
        case 2:
            self.navigationItem.title = @"司法解释";
            break;
        case 3:
            self.navigationItem.title = @"司法案例";
            break;
        case 4:
            self.navigationItem.title = @"法律文献";
            break;
        default:
            break;
    }
}

- (void)setTableRefresh
{
    _nowPage = 1;
    _nowPage = 1;
    [_tableView setTableFooterView:[UIView new]];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.mj_footer endRefreshing];
        });
        if (++_nowPage >_totalPage) {
            _nowPage = _totalPage;
            [_tableView.mj_footer endRefreshing];
            [self showHint:@"没有更多了"];
        }else
            [self getDataSource];
    }];
    _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        _nowPage = 1;
        [self getDataSource];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.mj_header endRefreshing];
        });
    }];
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
    YdListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YdListTableViewCell"];
    YdnewsListModel *model = _dataSource[indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
    cell.lblTitle.text = model.news_title;
    cell.lblsubTitle.text = model.news_content;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"pushYdwebViewControllerSegue" sender:self.navigationItem.title];
}

- (IBAction)goback:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)getDataSource
{
    if (_newstype) {
        NSDictionary *dic = @{@"newtype":_newstype,@"rownum":@"10",@"page":[NSString stringWithFormat:@"%ld",_nowPage]};
        [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_getNewsList Params:dic success:^(id json) {
            if ([self isFlag:json]) {
                if (_nowPage ==1) {
                    _dataSource = [NSMutableArray array];
                }
                _totalPage = [json[@"sumnum"] integerValue];
                NSArray *data = json[@"data"];
                for (NSDictionary *dic in data) {
                    NSError *error;
                    YdnewsListModel *model = [[YdnewsListModel alloc]initWithDictionary:dic error:&error];
                    if (!error) {
                        [_dataSource addObject:model];
                    }
                }
            }
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_header endRefreshing];
        } fail:^(NSError *error) {
            NSLog(@"网络错误");
            [self showHint:@"网络错误"];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_header endRefreshing];
        }];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *vc = [segue destinationViewController];
    if ([vc isKindOfClass:[YdwebViewController class]]) {
        YdwebViewController *ydweb = (YdwebViewController *)vc;
        ydweb.title = sender;
    }
}


@end
