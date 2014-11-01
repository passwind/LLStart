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
#import "AnalyseViewController.h"

#define kViewTypeSexInput @"SexInput"
#define kViewTypeGuage @"Guage"

@interface DataInputViewController ()<AnalyseViewControllerDelegate>
{
    NSInteger _currentDataIndex;
}

@property (weak, nonatomic) IBOutlet UILabel *dataTitleLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *dataPageControl;
@property (strong,nonatomic) SexInputViewController * sexInputViewController;
@property (strong,nonatomic) GuageViewController * guageViewController;

@property (strong,nonatomic) NSArray * bodyDataArray;
@property (strong,nonatomic) NSString * currentViewType;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation DataInputViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sexInputViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"SexInputView"];
    [self addChildViewController:_sexInputViewController];
    [_sexInputViewController didMoveToParentViewController:self];
    
    _guageViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"GuageView"];
    [self addChildViewController:_guageViewController];
    [_guageViewController didMoveToParentViewController:self];
    
    _bodyDataArray=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dataview" ofType:@"plist"]];
    
    _dataPageControl.numberOfPages=[_bodyDataArray count];
    
    _currentDataIndex=0;
    [self displayData];
    _dataPageControl.currentPage=_currentDataIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowAnalyse"]) {
        UINavigationController * controller=segue.destinationViewController;
        AnalyseViewController * analyseViewController=(AnalyseViewController*)[controller.viewControllers objectAtIndex:0];
        analyseViewController.delegate=self;
    }
}

#pragma mark - IBActions
- (IBAction)pageMoveAction:(id)sender {
    UIPageControl * pc=sender;
    _currentDataIndex=pc.currentPage;
    [self displayData];
}

- (IBAction)nextAction:(id)sender {
    if (_currentDataIndex==[_bodyDataArray count]-1) {
        [self performSegueWithIdentifier:@"ShowAnalyse" sender:nil];
        return;
    }
    _currentDataIndex++;
    [self displayData];
    _dataPageControl.currentPage=_currentDataIndex;
}

- (IBAction)priorAction:(id)sender {
    if (_currentDataIndex==0) {
        return;
    }
    _currentDataIndex--;
    [self displayData];
    _dataPageControl.currentPage=_currentDataIndex;
}

#pragma mark - functions

-(void)displayData
{
    if (_currentDataIndex<0) {
        return;
    }
    
    if (_currentDataIndex>=[_bodyDataArray count]) {
        return;
    }
    
    NSDictionary * dataItem=_bodyDataArray[_currentDataIndex];
    
    _dataTitleLabel.text=dataItem[@"viewTitle"];
    
    CGRect frame=self.view.bounds;
    
    if ([dataItem[@"viewType"] isEqualToString:kViewTypeSexInput]) {
        [_guageViewController.view removeFromSuperview];
        [_sexInputViewController.view setFrame:frame];
        [self.view insertSubview:_sexInputViewController.view belowSubview:_dataPageControl];
        _currentViewType=kViewTypeSexInput;
    }
    else if([dataItem[@"viewType"] isEqualToString:kViewTypeGuage]) {
        if ([_currentViewType isEqualToString:kViewTypeSexInput]) {
            [_sexInputViewController.view removeFromSuperview];
            
            [_guageViewController.view setFrame:frame];
            [self.view insertSubview:_guageViewController.view belowSubview:_dataPageControl];
            _currentViewType=kViewTypeGuage;
        }
        
        [_guageViewController setGuageInfo:dataItem[@"guageInfo"]];
    }
    
    if (_currentDataIndex==0) {
        _backButton.hidden=YES;
    }
    else {
        _backButton.hidden=NO;
    }
}

#pragma mark - AnalyseViewControllerDelegate
-(void)analyseViewController:(AnalyseViewController *)controller didExitWithFlag:(BOOL)reflag
{
    [self dismissViewControllerAnimated:NO completion:^{
        if (reflag) {
            _currentDataIndex=0;
            [self displayData];
        }
    }];
}

@end
