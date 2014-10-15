//
//  DetailViewController.h
//  Beautyou
//
//  Created by Zhu Yu on 14-10-15.
//  Copyright (c) 2014年 Zhu Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

