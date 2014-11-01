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
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reloadGuageData];
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
    
    self.unitLabel.text=_guageInfo[@"unit"];
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
    
    [self moveToGuage:[_guageInfo[@"default"] floatValue]];
}

-(void)moveMidPosition
{
    CGSize totalSize=_guageView.contentSize;
    CGRect frame=_guageView.frame;
    
    CGPoint offset=CGPointMake(totalSize.width/2-frame.size.width/2, 0);
    
    _guageView.contentOffset=offset;
    
    int data=[_guageInfo[@"min"] intValue]+([_guageInfo[@"max"] intValue]-[_guageInfo[@"min"] intValue])*(offset.x+frame.size.width/2)/totalSize.width;
    _guageTitleLabel.text=[NSString stringWithFormat:@"%d",data];
}

-(void)moveToGuage:(CGFloat)data
{
    CGSize totalSize=_guageView.contentSize;
    CGRect frame=_guageView.frame;
    CGFloat x=(data-[_guageInfo[@"min"] intValue])/([_guageInfo[@"max"] intValue]-[_guageInfo[@"min"] intValue])*totalSize.width-frame.size.width/2;
    CGPoint offset=_guageView.contentOffset;
    offset.x=x;
    _guageView.contentOffset=offset;
}

#pragma mark - GuageScrollViewDataSource Method
-(UIView*)guageView:(GuageScrollView *)scrollView withCol:(int)column
{
    UIImageView * tile=(UIImageView *)[scrollView dequeueReusableTile:GuageTileType_Guage];
    
    if(!tile)
    {
        tile=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guage"]];
    }
    
    return tile;
}

-(UIView*)noteView:(GuageScrollView *)scrollView withCol:(int)column
{
    UILabel * tile=(UILabel*)[scrollView dequeueReusableTile:GuageTileType_Note];
    if (!tile) {
        tile=[[UILabel alloc] initWithFrame:CGRectZero];
        tile.font=[UIFont fontWithName:@"System" size:12.0f];
    }
    tile.text=[NSString stringWithFormat:@"%d",[_guageInfo[@"min"] intValue]+[_guageInfo[@"step"] intValue]*column];
    return tile;
}

#pragma mark - UIScrollViewDelegate Functions
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame=scrollView.frame;
    CGPoint offset=scrollView.contentOffset;
    
    int data=[_guageInfo[@"min"] intValue]+([_guageInfo[@"max"] intValue]-[_guageInfo[@"min"] intValue])*(offset.x+frame.size.width/2)/scrollView.contentSize.width;
    _guageTitleLabel.text=[NSString stringWithFormat:@"%d",data];
}

@end
