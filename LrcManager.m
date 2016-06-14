//
//  LrcManager.m
//  LyricsAnalysis
//
//  Created by 耿嘉 on 16/6/11.
//  Copyright © 2016年 GengMAX. All rights reserved.
//

#import "LrcManager.h"

#define LrcPath @"/Users/gengjia/Documents/LyricsAnalysis/传奇.txt"
//宏定义，直接在程序中指明需要解析的歌词文件路径


@interface LrcManager ()


//OC中的类的私有化方法，使用category的形式实现
//相当于java中private方法，实现了类方法的私有化封装

-(BOOL)praseLrcFile:(NSString *)path;
//文件解析方法，从指定路径的文件中解析出_lrclist对象

-(void)praseLrcTitle:(NSString *)lineString;
//从每一行的NSString对象中解析出歌词的标题

-(void)praseLrcAuthor:(NSString *)lineString;
//从每一行的NSString对象中解析出歌词的作者

-(void)praseLrcItem:(NSString *)lineString;
//从每一行的NSString对象中解析出LrcItem对象

-(float)praseLrcTime:(NSString *)TimeString;
//从每一行的NSString对象中解析出歌词的時間


-(NSString *)lrcStringByTime:(float)time;
//用时间的float变量将lrcString排序
                                              
@end

@implementation LrcManager


+(void)userInterface
{
    LrcManager *manager = [[LrcManager alloc]initWithLrcFile:LrcPath];
    [manager showLrcItem];
    //初始化病解析，这个过程可以在.m文件里做，也可以在main.m文件里做。这个不重要
    
    char string[100]  = {};
    NSLog(@"----------INPUT TIME----------");
    scanf("%s",string);
    float time = [[NSString stringWithUTF8String:string] floatValue];
    NSLog(@"lrc = %@",[manager lrcStringByTime:time]);
    
}


-(id)initWithLrcFile:(NSString *)path
{
    self = [super init];
    //调用super类的init方法初始化
    
    if(self){
        _lrcList = [NSMutableArray array];
        //初始化_lrclist
        [self praseLrcFile:path];
        //从文件路径将文件全部解析成lrclist对象
        //注意文件路径是个NSString
    }
    return self;
}



-(NSString *)lrcStringByTime:(float)time
{
    NSInteger count = [_lrcList count];
    NSInteger index = -1;
    
    for (NSInteger i = 0; i < count; i++) {
        LrcItem *item = [_lrcList objectAtIndex:i];
        if (time < [item lrcTime]){
            index = i - 1;
            break;
        }
        
    }
    if(index == -1)
        return @"";
    else
        return [[_lrcList objectAtIndex:index] lrcString];

    
}

-(void)showLrcItem
{
    for (LrcItem *item in _lrcList) {
        [item printLrcItem];
    }
}

-(BOOL)praseLrcFile:(NSString *)path
{
    NSString  *fileContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //把文件读出来，读成一个NSString
    
    if(!fileContent){
        return NO;
    }
    
    
    NSArray *lineArray = [fileContent componentsSeparatedByString:@"\n"];
    //按照每行进行分段，每行放入lineArray数组中
    //lineArray中存储的是txt文件的每行内容，别着急，下面一步步拆分

    NSInteger lineCount = [lineArray count];
    //先把lineArray的数组count取出来，方便下面遍历
    
    //遍历整个lineArray
    for(NSInteger i = 0;i < lineCount;i++)
    {
        NSString *lineString = [lineArray objectAtIndex:i];
        //把数组的每项出去来，单独放到NSString变量中
        //接下来就是判断，空的就跳过
        if ([lineString isEqualToString:@""]){
            continue;
        }
        
        //带ti的就是调用解析标题的方法
        else if([lineString hasPrefix:@"ti:"]){
            [self praseLrcTitle:lineString];
        }
        
        //带ar的就是调用解析作者的方法
        else if([lineString hasPrefix:@"ar:"]){
            [self praseLrcAuthor:lineString];
        }
        
        //其余的就是正儿八经的歌词内容了：
        else{
            [self praseLrcItem:lineString];
        }
    }
    
    //最后排序
    [_lrcList sortUsingSelector:@selector(isSortByTime:)];
    
   
    return YES;
    
}

//解析title
-(void)praseLrcTitle:(NSString *)lineString
{
    NSInteger len = [lineString length];
    _title = [lineString substringWithRange:NSMakeRange(4, len-4-1)];

}

//解析作者
-(void)praseLrcAuthor:(NSString *)lineString
{
    NSInteger len = [lineString length];
    _author = [lineString substringWithRange:NSMakeRange(4, len-4-1)];
    
}

//例如：[00:45.01][02:48.83]想你时你在天边
-(void)praseLrcItem:(NSString *)lineString
{
    //以 ］标记，再次分割一下，放到lcrLineArray中去
    NSArray *lrcLineArray = [lineString componentsSeparatedByString:@"]"];
    
    NSInteger count = [lrcLineArray count];//例子的count为3
    //遍历，这是最核心最难的部分
    for (NSInteger i = 0;i < count - 1 ; i++) {
        //实例下LrcItem
        LrcItem *item = [[LrcItem alloc]init];
        
        //无论这句话前面有几个时间，遍历的时候都把第i个设置为时间
        [item setLrcTime:[self praseLrcTime:[lrcLineArray objectAtIndex:i]]];
        
        //遍历的时候都把最后一个设置为歌词
        [item setLrcString:[lrcLineArray lastObject]];
        
        //把实例化的LrcItem添加到list中去
        //添加的结果是这个样的：
        //[00:45.01]想你时你在天边
        //[02:48.83]想你时你在天边
        //这么做就把一整个重复的理顺了
        [_lrcList addObject:item];

    }
}


//[01:21.81]
-(float)praseLrcTime:(NSString *)TimeString
{
    NSString *minString = [TimeString substringWithRange:NSMakeRange(1, 2)];
    //单独提出秒和分钟，计算下就ok了
    NSString *secondString = [TimeString substringFromIndex:4];
    return [minString integerValue]*60 + [secondString floatValue];
}



@end
