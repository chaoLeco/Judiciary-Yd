//
//  YdSearchViewController.m
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/8.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdSearchViewController.h"
#import "YdnewsListModel.h"
#import "YdListTableViewCell.h"
#import "DXPopover.h"
#import "YdMenu.h"

@interface YdSearchViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (strong,nonatomic) NSMutableArray *dataSource;
@property (strong,nonatomic) DXPopover *popover;
@end

@implementation YdSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableview.tableFooterView = [UIView new];
    if (_searchtxt) {
        _searchText.text = _searchtxt;
        NSArray *array = @[@"法律法规",@"法律案例",@"法律流程"];
        [_searchBtn setTitle:array[_searchnn] forState:UIControlStateNormal];
        [self searchData];
        
    }
}

- (IBAction)popBackAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
    [self searchData];
    return YES;
}

- (void)searchData
{
    NSDictionary *dic = @{@"newtype":[NSString stringWithFormat:@"%d",_searchnn*2+1],
                          @"keyword":_searchText.text,@"rownum":@"100",@"page":@"1"};
    [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_getNewsListByType Params:dic success:^(id json) {
        if ([self isFlag:json]) {
            NSArray *data = json[@"data"];
            for (NSDictionary *dic in data) {
                NSError *error;
                YdnewsListModel *model = [[YdnewsListModel alloc]initWithDictionary:dic error:&error];
                if (!error) {
                    [_dataSource addObject:model];
                }
            }
            [_tableview reloadData];
        }else [self showHint:@"没有搜到"];
    } fail:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YdListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YdListTableViewCell"];
    YdnewsListModel *model = _dataSource[indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Yd_imgUrl_basis,model.news_listimage]] placeholderImage:[UIImage imageNamed:@"Yzwt22.png"]];
    cell.lblTitle.text = model.news_title;
    cell.lblsubTitle.text = model.news_content;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"pushYdwebViewControllerSegue" sender:self.navigationItem.title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
