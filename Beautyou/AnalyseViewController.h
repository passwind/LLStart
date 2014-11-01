//
//  AnalyseViewController.h
//  Beautyou
//
//  Created by Zhu Yu on 14/10/25.
//  Copyright (c) 2014年 Zhu Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnalyseViewController;

@protocol AnalyseViewControllerDelegate <NSObject>

-(void)analyseViewController:(AnalyseViewController*)controller didExitWithFlag:(BOOL)reflag;

@end

@interface AnalyseViewController : UIViewController

@property (nonatomic,assign) id<AnalyseViewControllerDelegate> delegate;

@end
