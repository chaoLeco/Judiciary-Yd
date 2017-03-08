//
//  YdHomeTableViewCell.m
//  judiciary
//
//  Created by lecochao on 2017/2/21.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdHomeTableViewCell.h"

@implementation YdHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(KBounds), CGRectGetHeight(_bannerView.bounds)) delegate:self placeholderImage:[UIImage imageNamed:@"Yzwt22.png"]];
        _cycleScrollView.hidesForSinglePage = YES;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _cycleScrollView;
}

-(void)setValue:(NSArray *)datas
{
     [_bannerView addSubview:self.cycleScrollView];
    NSMutableArray *imgs = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    for (YdAssistanceModel *model in datas) {
        [imgs addObject:[NSString stringWithFormat:@"%@%@",Yd_imgUrl_basis,model.lawyer_headerimage]];
        [titles addObject:[NSString stringWithFormat:@"%@-%@",model.lawyer_username,model.lawyer_company]];
    }
    _cycleScrollView.imageURLStringsGroup = imgs.copy;
    _cycleScrollView.titlesGroup = titles.copy;
}

#pragma mark - SDCycleScrollViewDelegate -
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    NSLog(@"点击了第%ld个",index);
    if (_clickblock) {
        _clickblock(index);
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
//    NSLog(@"当前位置%ld",index);
}

@end
