//
//  YdBanner.h
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/8.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface YdBanner : JSONModel
@property (nonatomic, retain) NSString <Optional>*banner_id;
@property (nonatomic, retain) NSString <Optional>*banner_imagelink;
@property (nonatomic, retain) NSString <Optional>*banner_newsid;
@property (nonatomic, retain) NSString <Optional>*banner_showflag;
@property (nonatomic, retain) NSString <Optional>*banner_time;
@end
//        "banner_id": "4",
//        "banner_imagelink": "/uploads/newsimage/20170308/58bf855ed5b7d.png",
//        "banner_newsid": "5",
//        "banner_showflag": "1",
//        "banner_time": "2017-03-08 12:15:38"
