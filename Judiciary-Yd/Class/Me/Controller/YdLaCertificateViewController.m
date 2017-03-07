//
//  YdLaCertificateViewController.m
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/3.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdLaCertificateViewController.h"
#import "YdCity.h"
#import "OrderPickerView.h"

@interface YdLaCertificateViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtSuo;
@property (weak, nonatomic) IBOutlet UITextField *txtNum;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtQQ;
@property (weak, nonatomic) IBOutlet UITextField *txtwechat;
@property (weak, nonatomic) IBOutlet UITextView *txtInfo;
@property (weak, nonatomic) IBOutlet UIImageView *imgleft;
@property (weak, nonatomic) IBOutlet UIImageView *imgright;
@property (weak, nonatomic) IBOutlet UIButton *btnleft;
@property (weak, nonatomic) IBOutlet UIButton *btnright;
@property (weak, nonatomic) IBOutlet UILabel *lblplaceholder;
@property (weak, nonatomic) IBOutlet UIScrollView *scorllView;

@property (assign,nonatomic) NSInteger imgTag;
@property (strong,nonatomic) NSMutableArray *provinces;
@property (strong,nonatomic) NSMutableArray *citys;
@property (strong,nonatomic) NSMutableArray *cityStr;
@property (assign,nonatomic) NSInteger pn;
@property (assign,nonatomic) NSInteger cn;

@property (strong,nonatomic) UIImage *img13;
@property (strong,nonatomic) UIImage *img14;

@end

@implementation YdLaCertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnleft.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnright.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _imgright.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _imgleft.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _txtInfo.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self getProvince];
    _pn = 0;
    _cn = 0;
    _imgleft.userInteractionEnabled = YES;
    _imgright.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTapq = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uesrClicked:)];
    [_imgleft addGestureRecognizer:singleTapq];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uesrClicked:)];
    [_imgright addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action -

- (IBAction)chooseAction:(UIButton *)sender {
    [self .view endEditing:YES];
    if (sender.tag ==11) {
        //选择省份
        if (_provinces.count>0) {
            _cityStr = [NSMutableArray array];
            for (YdCity *city in _provinces) {
                [_cityStr addObject:city.name];
            }
            if (_cityStr.count>0) {
                [OrderPickerView showViewStyleDefaultWithData:_cityStr Block:^(id data, NSIndexPath *path) {
                    if (data) {
                        [_btnleft setTitle:data forState:UIControlStateNormal];
                        _pn = path.row + 1;
                        [_btnright setTitle:@"请选择市" forState:UIControlStateNormal];
                        _cn = 0;
                    }
                }];
            }
        }else [self getProvince];
    }else{
        //选择城市
        if (_pn>0) {
            [self getCitys];
        }else{
            [self showHint:@"请选择省份"];
        }
    }
}

- (IBAction)submitAction:(id)sender {
    
    if (!kStringIsEmpty(_txtName.text)) {
        if (!kStringIsEmpty(_txtSuo.text)) {
            if ([_txtNum.text isMatchingRegularEpressionByPattern:RE_IsNumber]) {
                if (_pn>0) {
                    if (_cn>0) {
                        if ([_txtPhone.text isMatchingRegularEpressionByPattern:RE_MobileNumber]) {
                            if ([_txtQQ.text isMatchingRegularEpressionByPattern:RE_IsNumber]) {
                                if (_txtwechat.text.length >2) {
                                    if(!kStringIsEmpty(_txtInfo.text)){
                                        if (_img13) {
                                            if (_img14) {
                                                [self submitInfo];
                                            }else
                                                [self showHint:@"请上传年检证"];
                                        }else
                                            [self showHint:@"请上传执业证内页"];
                                    }else
                                        [self showHint:@"请简述一下自己"];
                                }else
                                    [self showHint:@"请输入正确微信号"];
                            }else
                                [self showHint:@"请输入正确QQ"];
                        }else
                            [self showHint:@"请输入正确手机号"];
                    }else
                        [self showHint:@"请选择市"];
                }else
                    [self showHint:@"请选择省份"];
            }else{
                [self showHint:@"请输入正确执业证号"];
            }
        }else{
            [self showHint:@"请输入事务所名称"];
        }
    }else{
        [self showHint:@"请输入姓名"];
    }
}

- (void)uesrClicked:( UITapGestureRecognizer *)sender {
    
    _imgTag = sender.view.tag;
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"上传照片"                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
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
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        if (_imgTag ==13) {
            _img13 = img;
            _imgleft.image = img;
            _imgleft.contentMode = UIViewContentModeScaleToFill;
        }else
        {
            _img14 = img;
            _imgright.image = img;
            _imgright.contentMode = UIViewContentModeScaleToFill;
        }
    }];
    
}

#pragma mark - netWorking -
- (void)getCitys
{
    [self showHUDWithHint:nil];
    YdCity *city = _provinces[_pn-1];
    [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_getCity Params:@{@"id":city._id} success:^(id json) {
        if ([self isFlag:json]) {
            _citys = [NSMutableArray array];
            _cityStr = [NSMutableArray array];
            NSArray *array = json[@"data"];
            for (NSDictionary *dic in array) {
                NSError *error;
                YdCity *city = [[YdCity alloc]initWithDictionary:dic error:&error];
                if (!error) {
                    [_citys addObject:city];
                    [_cityStr addObject:city.name];
                }
            }
            if (_cityStr.count>0) {
                [OrderPickerView showViewStyleDefaultWithData:_cityStr Block:^(id data, NSIndexPath *path) {
                    if (data) {
                        [_btnright setTitle:data forState:UIControlStateNormal];
                        _cn = path.row +1;
                    }
                }];
            }
        }else {
            _cn = 9999;
            //没有二级城市
        }
        [self hideHud];
    } fail:^(NSError *error) {
        [self showHint:@"市获取失败"];
        [self hideHud];
    }];
}

- (void)getProvince
{
    [self showHUDWithHint:nil];
    [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_getProvince Params:nil success:^(id json) {
        if ([self isFlag:json]) {
            _provinces = [NSMutableArray array];
            NSArray *array = json[@"data"];
            for (NSDictionary *dic in array) {
                NSError *error;
                YdCity *city = [[YdCity alloc]initWithDictionary:dic error:&error];
                if (!error) {
                    [_provinces addObject:city];
                }
            }
        }
        [self hideHud];
    } fail:^(NSError *error) {
        [self showHint:@"省获取失败"];
        [self hideHud];
    }];
}

- (void)submitInfo
{
    NSString *token = k_GET_TOKEN
    NSString *userid= k_GET_OBJECT(Yd_user_id);
    if (token&&userid) {
        [self showHUDWithHint:nil];
        
        NSDictionary *params = @{@"userid":userid,
                                 @"lowyeraddress":[self address],
                                 @"lowyername":_txtName.text,
                                 @"lowyercompany":_txtSuo.text,
                                 @"lowyercode":_txtNum.text,
                                 @"lowyerabstract":_txtInfo.text,
                                 @"lowyerwx":_txtwechat.text,
                                 @"lowyerqq":_txtQQ.text,
                                 @"lowyerphone":_txtPhone.text};
        NSArray *aa = @[@{@"picKey":@"inimage[]",@"picData":UIImageJPEGRepresentation(_img13, 0.8)},
                        @{@"picKey":@"inimage[]",@"picData":UIImageJPEGRepresentation(_img14, 0.8)}];
        [XCNetworking XC_Post_UploadWithUrl:Yd_url_lawyerAuthenUpload Params:params Data_arr:aa success:^(id responseObject) {
            if ([self isFlag:responseObject]) {
                [self showHint:@"上传成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            [self hideHud];
        } fail:^(NSError *error) {
            [self showHint:@"网络错误,资质上传失败"];
            [self hideHud];
        }];
        
    }
    
}

- (NSString *)address
{
    if (_pn>0) {
        YdCity *pp = _provinces[_pn-1];
        if (_cn>0) {
            if (_cn!=9999) {
                return [NSString stringWithFormat:@"%@-%@",pp._id,pp._id];
            }else{
               YdCity *cc = _citys[_cn-1];
                return [NSString stringWithFormat:@"%@-%@",pp._id,cc._id];
            }
        }else
            [self showHint:@"请选择市"];
    }else
        [self showHint:@"请选择省份"];
    return @"";
}

#pragma mark - TextFieldDelegate -

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.text.length>0) {
        _lblplaceholder.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        _lblplaceholder.text = @"简述一下自己...";
        
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    CGFloat y = _scorllView.contentSize.height - _scorllView.bounds.size.height;
    [_scorllView setContentOffset:CGPointMake(0, 150) animated:YES];
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        _lblplaceholder.text = @"简述一下自己...";
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (textView.text.length>499) {
        if (text.length==0) {
            return YES;
        }else
            return NO;
    }
    if (text.length>0) {
        _lblplaceholder.text = @"";
    }
    if (text.length == 0 &textView.text.length==1) {
        _lblplaceholder.text = @"简述一下自己...";
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        _lblplaceholder.text = @"";
    }else{
        _lblplaceholder.text = @"简述一下自己...";
    }
}

#pragma mark - UITextFieldDelegate -


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
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
