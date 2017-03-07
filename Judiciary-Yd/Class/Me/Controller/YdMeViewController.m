//
//  YdMeViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/21.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdMeViewController.h"
#import "YdUserInfoModel.h"
#import "YdUserInfoViewController.h"

@interface YdMeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *userNikename;
@property (weak, nonatomic) IBOutlet UILabel *userbrief;
@property (weak, nonatomic) IBOutlet UIButton *userBtn;
@property (weak, nonatomic) IBOutlet UIImageView *portraitImg;
@property (weak, nonatomic) IBOutlet UIImageView *solicitorImg;//律师标识

@property(strong,nonatomic) YdUserInfoModel *userInfo;

@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,strong) NSArray *icons;
@end

@implementation YdMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView setTableFooterView:[UIView new]];
    [kNotificationCenter addObserver:self selector:@selector(userlogin:) name:Yd_Notification_login object:nil];
    [kNotificationCenter addObserver:self selector:@selector(userlogout:) name:Yd_Notification_logout object:nil];
    _userNikename.text = @"未登录，点击登录";
    _userbrief.text = @"";
    _solicitorImg.hidden = YES;
    [self getUserInfo];
//    WGAlertView *alter = [[WGAlertView alloc]initWithTitle:@"密码修改成功" message:@"需要重新登录" block:^(NSInteger buttonIndex, WGAlertView *alert_) {
//        if (buttonIndex ==0) {
//            
//        }
//    } cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
//    [alter show];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
            if ([_userInfo.user_flag intValue]==1) {
                [self showHint:@"您已通过律师认证"];
            }else
                [self performSegueWithIdentifier:@"pushYdLaCertificateViewControllerSegue" sender:nil];
            
            
            break;
        case 3:
            [self performSegueWithIdentifier:@"pushYdAboutmeViewControllerSegue" sender:nil];
            break;
            
        default:
            break;
    }
}

- (IBAction)lodinAction:(id)sender {
    
    NSString *token = k_GET_TOKEN
    if (token) {
        if (_userInfo) {
            //跳转个人资料
           [self performSegueWithIdentifier:@"pushYdUserInfoViewControllerSegue" sender:nil];
        }else{
            [self getUserInfo];
        }
    }else{
        [self performSegueWithIdentifier:@"YdLodinNavigationViewControllerSegue" sender:nil];
    }
}

- (void)userlogin:(NSNotification *)obj
{
//    obj.object json
//接受到登录成功通知
    
    [self getUserInfo];
}

- (void)userlogout:(NSNotification *)obj
{
    //登出通知 只处理数据
    _userNikename.text = @"未登录，点击登录";
    _portraitImg.image = [UIImage imageNamed:@"Ydtouxiang"];
    k_REMOVE_TOKEN;
    k_REMOVE_OBJECT(Yd_user_id);
    k_REMOVE_OBJECT(Yd_user_phone);
    k_REMOVE_OBJECT(Yd_user_pw);
}

- (void)getUserInfo{

    NSString *token = k_GET_TOKEN
    NSString *userid= k_GET_OBJECT(Yd_user_id);
    if (token&&userid) {
        [self showHUDWithHint:nil];
        [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_getUserInfo Params:@{@"userid":userid} success:^(id json) {
            [self hideHud];
            if ([self isFlag:json]) {
                NSError *error;
                _userInfo = [[YdUserInfoModel alloc]initWithDictionary:json[@"data"] error:&error];
                if (!error) {
                    NSString *headStr = [NSString stringWithFormat:@"%@%@",Yd_imgUrl_basis,_userInfo.user_headsmallimage];
                    [_portraitImg sd_setImageWithURL:[NSURL URLWithString:headStr] placeholderImage:[UIImage imageNamed:@"Ydtouxiang"]];
                    _userNikename.text = _userInfo.user_name;
                    _userbrief.text = _userInfo.user_abstract;
                    if ([_userInfo.user_flag intValue]==1) {
                        _solicitorImg.hidden = NO;
                    }
                }
            }
        } fail:^(NSError *error) {
            [self showHint:@"网络错误"];
            [self hideHud];
        }];
    }else{
        [self notLogin];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    UIViewController *vc = [segue destinationViewController];
    if ([vc isKindOfClass:[YdUserInfoViewController class]]) {
        YdUserInfoViewController *info = (YdUserInfoViewController *)vc;
        info.userInfo = _userInfo;
    }
}


@end

@implementation YdMetableViewCell

@end
