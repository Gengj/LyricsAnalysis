//
//  LrcManager.h
//  LyricsAnalysis
//
//  Created by 耿嘉 on 16/6/11.
//  Copyright © 2016年 GengMAX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LrcItem.h"
//继承LrcItem类
//表示一个歌词文件中所有的歌词
//形式为如下这样一个可变数组：*_lrcList
//时间  -  歌词
//时间  -  歌词
//时间  -  歌词
//时间  -  歌词
//时间  -  歌词
//时间  -  歌词

@interface LrcManager : NSObject
{
    
NSString       *_title;  //歌词的标题
NSString       *_author; //歌词的作者
NSMutableArray *_lrcList;//可变数组,存储LrcItem类的实例对象
}

-(id)initWithLrcFile:(NSString *)path;
//initWithLrcFile方法，从指定的文件路径进行初始化
//实际上先是把文件把指定路径下的txt文件进行解析，包含了解析文件的praseLrcFile方法

-(void)showLrcItem;
//把_lrclist中的每一个item都打印出来，用到了LrcItem类中print方法

+(void)userInterface;
//OC的类方法，不是实例方法哦，相当于java的static方法
//不同的是OC的+方法只能通过类名进行调用，实例化对象都不能调用

@end
