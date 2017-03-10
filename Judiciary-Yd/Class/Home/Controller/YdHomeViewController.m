//
//  YdHomeViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/21.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdHomeViewController.h"
#import "YdHomeTableViewCell.h"
#import "YdListViewController.h"
#import "YdSearchViewController.h"
#import "YdLawyerWebViewController.h"
#import "SDCycleScrollView.h"
#import "YdAssistanceModel.h"
#import "YdwebViewController.h"
#import "YdnewsListModel.h"
#import "DXPopover.h"
#import "YdBanner.h"
#import "YdMenu.h"


@interface YdHomeViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *banner;
@property (strong,nonatomic) DXPopover *popover;
@property (strong,nonatomic) SDCycleScrollView *cycleScrollView;
@property (assign,nonatomic) NSInteger searchnn;
@property (strong,nonatomic) NSMutableArray *dataBanners;
@property (strong,nonatomic) NSMutableArray *dataSource;
@end

@implementation YdHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_banner addSubview:self.cycleScrollView];
    [self tableRefresh:_tableView];
    [self getDataSource];
}

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(KBounds), CGRectGetHeight(_banner.bounds)) delegate:self placeholderImage:[UIImage imageNamed:@"Yzwt22.png"]];
    }
    return _cycleScrollView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataSource.count >0) {
        return 1;
    }else return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     YdHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YdHomeTableViewCell"];
    [cell setValue:_dataSource];
    cell.clickblock=^(NSInteger nn){
        [self performSegueWithIdentifier:@"pushYdLawyerWebViewControllerSegue" sender:_dataSource[nn]];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SDCycleScrollViewDelegate -
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    NSLog(@"点击了第%ld个",index);
    YdBanner *model = _dataBanners[index];
    [self performSegueWithIdentifier:@"pushYdwebViewControllerSegue" sender:model.banner_newsid];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
//    NSLog(@"当前位置%ld",index);
}

#pragma mark - Data -


- (void)getDataSource
{
    [self getBannerData];
    [self getAssistanceList];
}
- (void)getBannerData
{
    [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_getBannerList Params:nil success:^(id json) {
        if ([self isFlag:json]) {
            NSArray *data = json[@"data"];
            _dataBanners = [NSMutableArray array];
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in data) {
                NSError *error;
                YdBanner *model = [[YdBanner alloc]initWithDictionary:dic error:&error];
                if (!error) {
                    [_dataBanners addObject:model];
                    [array addObject:[NSString stringWithFormat:@"%@%@",Yd_imgUrl_basis,model.banner_imagelink]];
                }
            }
            _cycleScrollView.imageURLStringsGroup = array.copy;
        }
    } fail:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

- (void)getAssistanceList
{
    [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_getExcellentAssistanceList Params:nil success:^(id json) {
        if ([self isFlag:json]) {
            _dataSource = [NSMutableArray array];
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
    } fail:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

#pragma mark - action -

- (IBAction)btnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 101:
            //法律条文
            [self performSegueWithIdentifier:@"pushYdListViewControllerSegue" sender:@"1"];
            break;
        case 102:
            //司法解释
            [self performSegueWithIdentifier:@"pushYdListViewControllerSegue" sender:@"2"];
            break;
        case 103:
            //司法案例
            [self performSegueWithIdentifier:@"pushYdListViewControllerSegue" sender:@"3"];
            break;
        case 104:
            //法律文献
            [self performSegueWithIdentifier:@"pushYdListViewControllerSegue" sender:@"4"];
            break;
        case 105:
            //在线咨询
            [kNotificationCenter postNotificationName:Yd_Tabbar_selectedIndex object:@1];
            break;
        case 106:
            //费用咨询
            break;
        case 107:
            //法律援助
            [kNotificationCenter postNotificationName:Yd_Tabbar_selectedIndex object:@3];
            break;
        case 108:
            //文书下载
            [self performSegueWithIdentifier:@"pushYdListViewControllerSegue" sender:@"文书下载"];
            break;
        case 109:
            //论坛
            [kNotificationCenter postNotificationName:Yd_Tabbar_selectedIndex object:@2];
            break;

        default:
            break;
    }
}

- (IBAction)menuAction:(UIButton *)sender {
    
    if (!_popover) {
        _popover = [DXPopover popover];
    }
    YdMenu *menu = [YdMenu menu];
    menu.datas = @[@"法律法规",@"法律案例",@"法律流程"];
//    [_popover showAtView:sender withContentView:menu inView:self.navigationController.view];
    
    [_popover showAtPoint:CGPointMake(100, 60) popoverPostion:DXPopoverPositionDown withContentView:menu inView:self.navigationController.view];
    menu.block =^(NSInteger nn,id data){
        NSLog(@"%d__%@",nn,data);
        [_popover dismiss];
        _searchnn = nn;
        [sender setTitle:data forState:UIControlStateNormal];
    };
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length>0) {
        [self performSegueWithIdentifier:@"pushYdSearchViewControllerSegue" sender:textField.text];
        textField.text = nil;
    }else
        [self showHint:@"请输入关键字搜索"];
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *vc = [segue destinationViewController];
    if ([vc isKindOfClass:[YdListViewController class]]) {
        YdListViewController *ydList = (YdListViewController *)vc;
        ydList.newstype = sender;
    }
    
    if ([vc isKindOfClass:[YdSearchViewController class]]) {
        YdSearchViewController *ydsearch = (YdSearchViewController *)vc;
        ydsearch.searchtxt = sender;
        ydsearch.searchnn = _searchnn;
    }
    if ([vc isKindOfClass:[YdLawyerWebViewController class]]) {
        YdLawyerWebViewController *Lawyer = (YdLawyerWebViewController *)vc;
        Lawyer.lawyerInfo = sender;
    }
    if ([vc isKindOfClass:[YdwebViewController class]]) {
        YdwebViewController *ydweb = (YdwebViewController *)vc;
        ydweb.newid = sender;
    }
    
}


@end
