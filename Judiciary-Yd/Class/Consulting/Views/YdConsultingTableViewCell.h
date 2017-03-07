//
//  YdConsultingTableViewCell.h
//  judiciary
//
//  Created by lecochao on 2017/2/21.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YdAssistanceModel.h"

@interface YdConsultingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbladdress;
@property (weak, nonatomic) IBOutlet UILabel *lblname;
@property (weak, nonatomic) IBOutlet UILabel *lblcomment;
@property (weak, nonatomic) IBOutlet UIImageView *img;

- (void)setValue:(YdAssistanceModel *)data;
@end
