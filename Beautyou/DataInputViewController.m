//
//  DataInputViewController.m
//  Beautyou
//
//  Created by Zhu Yu on 14/10/24.
//  Copyright (c) 2014年 Zhu Yu. All rights reserved.
//

#import "DataInputViewController.h"
#import "SexInputViewController.h"
#import "GuageViewController.h"

@interface DataInputViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dataTitleLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *dataPageControl;
@property (strong,nonatomic) SexInputViewController * sexInputViewController;
@property (strong,nonatomic) GuageViewController * guageViewController;

@end

@implementation DataInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sexInputViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"SexInputView"];
    [self addChildViewController:_sexInputViewController];
    [_sexInputViewController didMoveToParentViewController:self];
    
    _guageViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"GuageView"];
    [self addChildViewController:_guageViewController];
    [_guageViewController didMoveToParentViewController:self];
    
    CGRect frame=self.view.bounds;
    [_sexInputViewController.view setFrame:frame];
    [self.view insertSubview:_sexInputViewController.view belowSubview:_dataPageControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)nextAction:(id)sender {
    [_sexInputViewController.view removeFromSuperview];
    
    CGRect frame=self.view.bounds;
    [_guageViewController.view setFrame:frame];
    [self.view insertSubview:_guageViewController.view belowSubview:_dataPageControl];
}
- (IBAction)priorAction:(id)sender {
    [_guageViewController.view removeFromSuperview];
    
    CGRect frame=self.view.bounds;
    [_sexInputViewController.view setFrame:frame];
    [self.view insertSubview:_sexInputViewController.view belowSubview:_dataPageControl];
}

@end
