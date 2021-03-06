//
//  YdHomeTableViewCell.h
//  judiciary
//
//  Created by lecochao on 2017/2/21.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "YdAssistanceModel.h"

@interface YdHomeTableViewCell : UITableViewCell<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (strong,nonatomic) SDCycleScrollView *cycleScrollView;

typedef void(^cellBlock)(NSInteger nn);
@property (strong,nonatomic) cellBlock clickblock;

-(void)setValue:(NSArray *)datas;
@end
