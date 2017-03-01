//
//  YdListViewController.h
//  judiciary
//
//  Created by lecochao on 2017/2/22.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdBasisViewController.h"

@interface YdListViewController : YdBasisViewController
//newstype-新闻类型（ 1：法律条文 2：司法解释 3：司法案例 4：法律文献)
@property (strong ,nonatomic) NSString *newstype;
@end
