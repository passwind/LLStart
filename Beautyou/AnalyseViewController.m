//
//  AnalyseViewController.m
//  Beautyou
//
//  Created by Zhu Yu on 14/10/25.
//  Copyright (c) 2014年 Zhu Yu. All rights reserved.
//

#import "AnalyseViewController.h"

@interface AnalyseViewController ()

@end

@implementation AnalyseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)backAction:(id)sender {
    [self.delegate analyseViewController:self didExitWithFlag:YES];
}

- (IBAction)shareAction:(id)sender {
}

@end
