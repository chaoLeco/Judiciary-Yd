//
//  YdnewsListModel.h
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/1.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface YdnewsListModel : JSONModel
@property (nonatomic, retain) NSString *news_id;
@property (nonatomic, retain) NSString <Optional>*news_title;
@property (nonatomic, retain) NSString <Optional>*news_content;
@property (nonatomic, retain) NSString <Optional>*news_time;
@property (nonatomic, retain) NSString <Optional>*news_type;
@property (nonatomic, retain) NSString <Optional>*news_listimage;

@end
//"news_id": "4",
//"news_title": "这是新闻标题2",
//"news_content": "这是新闻内容",
//"news_time": "2017-02-27 15:54:14",
//"news_type": "1",
//"news_listimage": "123213123123"
