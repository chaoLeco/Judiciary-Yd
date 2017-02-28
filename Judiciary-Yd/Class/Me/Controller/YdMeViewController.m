//
//  YdMeViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/21.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdMeViewController.h"

@interface YdMeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,strong) NSArray *icons;
@end

@implementation YdMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView setTableFooterView:[UIView new]];
}

-(NSArray *)titles
{
    if (!_titles) {
        _titles = @[@[@"我的钱包",@"意见反馈",@"律师认证",@"关于我们"],@[@"更多设置"]];
    }
    return _titles;
}

-(NSArray *)icons
{
    if (!_icons) {
        _icons = @[@[@"qianbao",@"fankui",@"renzheng",@"guanyu"],@[@"shezhi"]];
    }
    return _icons;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YdMetableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YdMetableViewCell"];
    cell.title.text = self.titles[indexPath.section][indexPath.row];
    [cell.icon setImage:[UIImage imageNamed:self.icons[indexPath.section][indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            if (indexPath.section==0) {
                
            }else{
                [self performSegueWithIdentifier:@"pushYdSetViewControllerSegue" sender:nil];
            }
            break;
        case 1:
            [self performSegueWithIdentifier:@"pushYdFeedbackViewControllerSegue" sender:nil];
            break;
        case 2:

            break;
        case 3:
            [self performSegueWithIdentifier:@"pushYdAboutmeViewControllerSegue" sender:nil];
            break;
            
        default:
            break;
    }
}

- (IBAction)lodinAction:(id)sender {
    
    UIViewController *lodinVc = [self.storyboard instantiateViewControllerWithIdentifier:@"YdLodinNavigationViewController"];
    [self presentViewController:lodinVc animated:YES completion:nil];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation YdMetableViewCell

@end
