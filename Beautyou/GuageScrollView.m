//
//  GuageScrollView.m
//  Beautyou
//
//  Created by Zhu Yu on 14/10/25.
//  Copyright (c) 2014年 Zhu Yu. All rights reserved.
//

#import "GuageScrollView.h"
#import "Global.h"

@interface GuageScrollView()
{
    NSMutableSet       *reusableTiles;
    NSMutableSet * reusableNotes;
    
    // we use the following ivars to keep track of which rows and columns are visible
    NSInteger firstVisibleColumn, lastVisibleColumn;
}

@end
@implementation GuageScrollView

#pragma mark - View Life Cycle

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        // we will recycle tiles by removing them from the view and storing them here
        reusableTiles = [[NSMutableSet alloc] init];
        
        reusableNotes=[[NSMutableSet alloc] init];
        
        // no rows or columns are visible at first; note this by making the firsts very high and the lasts very low
        firstVisibleColumn = NSIntegerMax;
        lastVisibleColumn  = NSIntegerMin;
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect visibleBounds=[self bounds];
    
    for (UIView * tile in [self subviews]) {
        if([tile isKindOfClass:[UILabel class]]) {
            [reusableNotes addObject:tile];
            [tile removeFromSuperview];
        }
        else {
            CGRect tileFrame=tile.frame;
            if (! CGRectIntersectsRect(tileFrame, visibleBounds)) {
                if ([tile isKindOfClass:[UIImageView class]]) {
                    [reusableTiles addObject:tile];
                }
                
                [tile removeFromSuperview];
            }
        }
    }
    
    int maxCol=floorf([self contentSize].width/UnitWidth);
    
    int firstNeededCol=MAX(0,floorf(visibleBounds.origin.x/UnitWidth));
    int lastNeededCol=MIN(maxCol, floorf(CGRectGetMaxX(visibleBounds)/UnitWidth));
    
    for(int col=firstNeededCol;col<=lastNeededCol;col++) {
        BOOL tileIsMissing=(firstVisibleColumn>col || lastVisibleColumn<col);
        
        if (tileIsMissing) {
            UIView * tile=[self.dataSource guageView:self withCol:col];
            CGRect frame=CGRectMake(UnitWidth*col, GuageUnitY, UnitWidth, UnitHeight);
            [tile setFrame:frame];
            [self addSubview:tile];
        }
        
        UILabel * label=(UILabel*)[self.dataSource noteView:self withCol:col];
        CGRect frame1=CGRectMake(UnitWidth*col-NoteWidth/2, GuageUnitY+UnitHeight+kPadding, NoteWidth, NoteHeight);
        [label setFrame:frame1];
        [self addSubview:label];
    }
    
    UILabel * label=(UILabel*)[self.dataSource noteView:self withCol:lastNeededCol];
    CGRect frame1=CGRectMake(UnitWidth*lastNeededCol-NoteWidth/2, GuageUnitY+UnitHeight+kPadding, NoteWidth, NoteHeight);
    [label setFrame:frame1];
    [self addSubview:label];
    
    firstVisibleColumn=firstNeededCol;
    lastVisibleColumn=lastNeededCol;
}

#pragma mark - functions

- (UIView *)dequeueReusableTile:(GuageTileType)type {
    UIView *tile =nil;
    
    if (type==GuageTileType_Guage) {
        tile = [reusableTiles anyObject];
        if (tile) {
            // the only object retaining the tile is our reusableTiles set, so we have to retain/autorelease it
            // before returning it so that it's not immediately deallocated when we remove it from the set
            [reusableTiles removeObject:tile];
        }
    }
    else if(type==GuageTileType_Note) {
        tile=[reusableNotes anyObject];
        if (tile) {
            [reusableNotes removeObject:tile];
        }
    }
    
    return tile;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
