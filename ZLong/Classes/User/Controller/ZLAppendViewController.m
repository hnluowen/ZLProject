//
//  ZLAppendViewController.m
//  ZLong
//
//  Created by David on 2018/8/9.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "ZLAppendViewController.h"

@interface ZLAppendViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation ZLAppendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
}

- (void)setUpBase {
    _headView.layer.cornerRadius = _headView.frame.size.height/2.0;
    _bgView.layer.cornerRadius = 3.0f;
    _bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    _bgView.layer.shadowOffset = CGSizeMake(1,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),5 5 这个跟shadowRadius配合使用
    _bgView.layer.shadowOpacity = 0.6;//阴影透明度，默认0
//    _bgView.layer.shadowRadius = 1;//阴影半径，默认3
    
}


@end
