//
//  YdUserInfoViewController.m
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/2.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdUserInfoViewController.h"
#import "YdeditorInfoViewController.h"
@interface YdUserInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *portraitImg;
@property (strong,nonatomic) NSArray *titles;
@property (strong,nonatomic) NSMutableArray *details;
@end

@implementation YdUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_userInfo) {
        [self getUserInfo];
    }else
        [self updateInfo];
    [_tableView setTableFooterView:[UIView new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"姓名",@"电话",@"微信",@"邮箱",@"简介"];
    }
    return _titles;
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
                    [self updateInfo];
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

- (void)updateInfo
{
    NSString *headStr = [NSString stringWithFormat:@"%@%@",Yd_imgUrl_basis,_userInfo.user_headsmallimage];
    [_portraitImg sd_setImageWithURL:[NSURL URLWithString:headStr] placeholderImage:[UIImage imageNamed:@"Ydtouxiang"]];
    self.title = _userInfo.user_name;
    _details = [NSMutableArray array];
    [_details addObject:_userInfo.user_name];
    [_details addObject:_userInfo.user_phone];
    [_details addObject:[NSString handleNetString:_userInfo.user_wx]];
    [_details addObject:[NSString handleNetString:_userInfo.user_email]];
    [_details addObject:[NSString handleNetString:_userInfo.user_abstract]];
    [_tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoCell"];
    cell.textLabel.text = self.titles[indexPath.row];
    cell.detailTextLabel.text = _details[indexPath.row];
    if (indexPath.row!=1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row!=1) {
        [self performSegueWithIdentifier:@"pushYdeditorInfoViewControllerSegue" sender:indexPath];
    }
}


- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)editorHeadportrait:(id)sender {
    //头像修改
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self submitImg:info];
    }];
   
}

- (void)submitImg:(NSDictionary *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    _portraitImg.image = img;
    NSString *token = k_GET_TOKEN
    NSString *userid= k_GET_OBJECT(Yd_user_id);
    if (token&&userid) {
        [self showHUDWithHint:nil];
        NSData *data = UIImageJPEGRepresentation(img, 0.8);
        [XCNetworking XC_Post_UploadWithUrl:Yd_url_uploadHeadImg Params:@{@"userid":userid} Data_arr:@[@{@"picKey":@"headerphoto",@"picData":data}] success:^(id responseObject) {
            if ([self isFlag:responseObject]) {
                [self showHint:@"新头像已保存"];
                [kNotificationCenter postNotificationName:Yd_Notification_login object:nil];
            }
            [self hideHud];
        } fail:^(NSError *error) {
            [self hideHud];
            [self showHint:@"网络错误，提交失败"];
            NSString *headStr = [NSString stringWithFormat:@"%@sifanvshen/%@",Yd_url_basis,_userInfo.user_headsmallimage];
            [_portraitImg sd_setImageWithURL:[NSURL URLWithString:headStr] placeholderImage:[UIImage imageNamed:@"Ydtouxiang"]];
        }];
    }

}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *vc = [segue destinationViewController];
    if ([vc isKindOfClass:[YdeditorInfoViewController class]]) {
       YdeditorInfoViewController *editorInfo = (YdeditorInfoViewController *)vc;
        NSInteger row = [(NSIndexPath *)sender row];
        editorInfo.row = row;
        editorInfo.info= _details[row];
        editorInfo.block =^(NSInteger row,NSString *info){
            NSLog(@"%d -- %@",row,info);
            [_details removeObjectAtIndex:row];
            [_details insertObject:info atIndex:row];
            [_tableView reloadData];
        };
    }
    
}


@end
