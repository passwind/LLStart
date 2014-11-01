//
//  GuageViewController.m
//  Beautyou
//
//  Created by Zhu Yu on 14/10/24.
//  Copyright (c) 2014年 Zhu Yu. All rights reserved.
//

#import "GuageViewController.h"
#import "GuageScrollView.h"
#import "Global.h"


@interface GuageViewController ()<GuageScrollViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *guageTitleLabel;
@property (weak, nonatomic) IBOutlet GuageScrollView *guageView;

@end

@implementation GuageViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    _guageView.dataSource=self;
    
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

#pragma mark - Properties 

-(void)setGuageInfo:(NSDictionary *)dic
{
    _guageInfo=dic;
    
    self.guageTitleLabel.text=_guageInfo[@"unit"];
    [self reloadGuageData];
}

#pragma mark - functions

-(void)reloadGuageData
{
    int n=([_guageInfo[@"max"] intValue]-[_guageInfo[@"min"] intValue])/[_guageInfo[@"step"] intValue];
    int width=UnitWidth*n;
    
    CGRect frame=[self.view bounds];
    CGSize newSize=CGSizeMake(width, frame.size.height);
    
    [_guageView setContentSize:newSize];
    
    [self moveMidPosition];
}

-(void)moveMidPosition
{
    CGSize totalSize=_guageView.contentSize;
    CGRect frame=_guageView.frame;
    
    CGPoint offset=CGPointMake(totalSize.width/2-frame.size.width/2, 0);
    
    _guageView.contentOffset=offset;
}

#pragma mark - GuageScrollViewDataSource Method
-(UIView*)guageScrollView:(GuageScrollView *)scrollView withCol:(int)column
{
    UIImageView * tile=(UIImageView *)[scrollView dequeueReusableTile];
    
    if(!tile)
    {
        tile=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guage"]];
    }
    
    return tile;
}

@end
