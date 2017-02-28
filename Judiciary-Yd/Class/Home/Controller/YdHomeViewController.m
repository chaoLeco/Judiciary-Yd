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
#import "SDCycleScrollView.h"
@interface YdHomeViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *banner;

@property (strong,nonatomic) SDCycleScrollView *cycleScrollView;
@end

@implementation YdHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cycleScrollView.localizationImageNamesGroup = @[@"ad_1.jpg",@"ad_2.jpg",@"ad_3.jpg",@"ad_4.jpg"];
    [_banner addSubview:_cycleScrollView];
}

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:_banner.bounds delegate:self placeholderImage:nil];
    }
    return _cycleScrollView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     YdHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YdHomeTableViewCell"];
    cell.cycleScrollView.localizationImageNamesGroup = @[@"ad_1.jpg",@"ad_2.jpg",@"ad_3.jpg",@"ad_4.jpg"];
    cell.cycleScrollView.titlesGroup = @[@"中国好了律师1",@"中国好了律师2",@"中国好了律师3",@"中国好了律师4"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
//    NSLog(@"当前位置%ld",index);
}


#pragma mark - action -

- (IBAction)btnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 101:
            //法律条文
            [self performSegueWithIdentifier:@"pushYdListViewControllerSegue" sender:@"法律条文"];
            break;
        case 102:
            //司法解释
            [self performSegueWithIdentifier:@"pushYdListViewControllerSegue" sender:@"司法解释"];
            break;
        case 103:
            //司法案例
            [self performSegueWithIdentifier:@"pushYdListViewControllerSegue" sender:@"司法案例"];
            break;
        case 104:
            //法律文献
            [self performSegueWithIdentifier:@"pushYdListViewControllerSegue" sender:@"法律文献"];
            break;
        case 105:
            //在线咨询
            break;
        case 106:
            //费用咨询
            break;
        case 107:
            //法律援助
            break;
        case 108:
            //文书下载
            [self performSegueWithIdentifier:@"pushYdListViewControllerSegue" sender:@"文书下载"];
            break;
        case 109:
            //论坛
            break;

        default:
            break;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *vc = [segue destinationViewController];
    if ([vc isKindOfClass:[YdListViewController class]]) {
        YdListViewController *ydList = (YdListViewController *)vc;
        ydList.title = sender;
    }
}


@end
