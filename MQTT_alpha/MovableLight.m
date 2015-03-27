//
//  MovableLight.m
//  MQTT_alpha
//
//  Created by 北島知司 on 2015/03/12.
//  Copyright (c) 2015年 北島知司. All rights reserved.
//

#import "MovableLight.h"

@implementation MovableLight

- (void)_init
{
    // initialize
    self.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 初期設定など
}


+ (instancetype) lightView
{
    // xib ファイルから MyView のインスタンスを得る
    UINib *nib = [UINib nibWithNibName:@"MovableLight" bundle:nil];
    MovableLight *view = [nib instantiateWithOwner:self options:nil][0];
    return view;
}


@end
