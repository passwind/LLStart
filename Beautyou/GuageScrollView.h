//
//  GuageScrollView.h
//  Beautyou
//
//  Created by Zhu Yu on 14/10/25.
//  Copyright (c) 2014年 Zhu Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GuageScrollView;

@protocol GuageScrollViewDataSource <NSObject>

-(UIView*)guageScrollView:(GuageScrollView*)scrollView withCol:(int)column;

@end

@interface GuageScrollView : UIScrollView

@property (nonatomic,strong) id<GuageScrollViewDataSource> dataSource;

- (UIView *)dequeueReusableTile;

@end
