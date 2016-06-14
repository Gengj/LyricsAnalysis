//
//  LrcItem.h
//  LyricsAnalysis
//
//  Created by 耿嘉 on 16/6/11.
//  Copyright © 2016年 GengMAX. All rights reserved.
//


//歌词最基础的类，最小的逻辑单元，包含互相对应的“一个时间，一句歌词”
//方法有构造、setter、getter、比较时间、打印出“时间---歌词”
#import <Foundation/Foundation.h>

@interface LrcItem : NSObject
{
    float  _lrcTime;
    NSString   *_lrcString;
}

-(id)initWithLrcTime:(float)time andLrcString:(NSString *)lrcString;

//set
-(void)setLrcTime:(float)  time;
-(void)setLrcString:(NSString*) lrcString;

//get
-(float)lrcTime;
-(NSString *)lrcString;


-(BOOL)isSortByTime:(LrcItem *)aItem;

//print
-(void)printLrcItem;

@end
