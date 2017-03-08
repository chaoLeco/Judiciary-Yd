//
//  YdConsultingViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/21.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdConsultingViewController.h"
#import "YdConsultingTableViewCell.h"
#import "YdLawyerWebViewController.h"
#import "YdAssistanceModel.h"
@interface YdConsultingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSource;
@end

@implementation YdConsultingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableRefresh:_tableView];
    [self getDataSource];
}


- (void)getDataSource
{
    NSDictionary *dic = @{@"rownum":@"10",@"page":[NSString stringWithFormat:@"%ld",(long)self.nowPage]};
    [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_lawyergetAssistanceList Params:dic success:^(id json) {
        if ([self isFlag:json]) {
            if (self.nowPage ==1) {
                _dataSource = [NSMutableArray array];
            }
            self.totalPage = [json[@"sumnum"] integerValue];
            NSArray *data = json[@"data"];
            for (NSDictionary *dic in data) {
                NSError *error;
                YdAssistanceModel *model = [[YdAssistanceModel alloc]initWithDictionary:dic error:&error];
                if (!error) {
                    [_dataSource addObject:model];
                }
            }
            [_tableView reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YdConsultingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YdConsultingTableViewCell"];
    [cell setValue:_dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     [self performSegueWithIdentifier:@"pushYdLawyerWebViewControllerSegue" sender:_dataSource[indexPath.row]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *vc = [segue destinationViewController];
    if ([vc isKindOfClass:[YdLawyerWebViewController class]]) {
        YdLawyerWebViewController *Lawyer = (YdLawyerWebViewController *)vc;
        Lawyer.lawyerInfo = sender;
    }
}


@end
