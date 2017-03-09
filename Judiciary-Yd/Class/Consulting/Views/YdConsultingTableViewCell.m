//
//  YdConsultingTableViewCell.m
//  judiciary
//
//  Created by lecochao on 2017/2/21.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdConsultingTableViewCell.h"

@implementation YdConsultingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValue:(YdAssistanceModel *)data
{
    _lbladdress.text = data.lawyer_addresstext;
    _lblname.text = [NSString stringWithFormat:@"%@-%@",data.lawyer_username,data.lawyer_company];
    _lblcomment.text = [NSString stringWithFormat:@"点赞：%@ 评论：%@",data.lawyer_praise,data.lawyer_comment];
    NSString *url = [NSString stringWithFormat:@"%@%@",Yd_imgUrl_basis,data.lawyer_headerimage];
    [_img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"Ydzwt22.png"]];
}

@end
