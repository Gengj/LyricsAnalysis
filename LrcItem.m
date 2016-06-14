//
//  LrcItem.m
//  LyricsAnalysis
//
//  Created by 耿嘉 on 16/6/11.
//  Copyright © 2016年 GengMAX. All rights reserved.
//

#import "LrcItem.h"

@implementation LrcItem

//构造方法：先用super类init，再用时间和歌词初始化
-(id)initWithLrcTime:(float)time andLrcString:(NSString *)lrcString
{
    self = [super init];
    if(self){
        _lrcTime = time;
        _lrcString = lrcString;
        
    }
    return self;
    
}

//setter
-(void)setLrcTime:(float)  time
{
    _lrcTime = time;
}
-(void)setLrcString:(NSString*) lrcString
{
    _lrcString = lrcString;
}

//getter
-(float)lrcTime
{
    return _lrcTime;
}
-(NSString *)lrcString
{
    return _lrcString;
}

//用自己声明的对象中的时间与自己的getter方法得到的时间比较，返回bool值
-(BOOL)isSortByTime:(LrcItem *)aItem
{
    if([self lrcTime] > [aItem lrcTime])
        return YES;
    else
        return NO;
}

//print
-(void)printLrcItem
{
    NSLog(@"Time: %.2f -----LRC:%@\n",[self lrcTime],[self lrcString]);
}


@end
