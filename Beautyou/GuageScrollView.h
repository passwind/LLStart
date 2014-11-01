//
//  GuageScrollView.h
//  Beautyou
//
//  Created by Zhu Yu on 14/10/25.
//  Copyright (c) 2014年 Zhu Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GuageTileType_Guage,
    GuageTileType_Note
}GuageTileType;

@class GuageScrollView;

@protocol GuageScrollViewDataSource <NSObject>

-(UIView*)guageView:(GuageScrollView*)scrollView withCol:(int)column;

-(UIView*)noteView:(GuageScrollView*)scrollView withCol:(int)column;

@end

@interface GuageScrollView : UIScrollView

@property (nonatomic,strong) id<GuageScrollViewDataSource> dataSource;

- (UIView *)dequeueReusableTile:(GuageTileType)type;

@end
