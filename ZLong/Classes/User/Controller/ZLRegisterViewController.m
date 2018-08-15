//
//  ZLRegisterViewController.m
//  ZLong
//
//  Created by David on 2018/8/9.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "ZLRegisterViewController.h"

@interface ZLRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeField;
@property (weak, nonatomic) IBOutlet UITextField *verifyField;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation ZLRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
}

#pragma mark - initialize
- (void)setUpBase
{
    
    [_userNameField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    [_verifyField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
}


#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_userNameField.text.length != 0) {
        _verifyBtn.enabled = YES;
    } else {
        [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verifyBtn.enabled = NO;
    }
    
    if (_userNameField.text.length != 0 && _verifyField.text.length != 0) {
        _registerBtn.enabled = YES;
    }else{
        _registerBtn.enabled = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - 验证点击
- (IBAction)validationClick:(UIButton *)sender {
    
    __block NSInteger time = 59; //设置倒计时时间
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    WEAKSELF
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [weakSelf.verifyBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                weakSelf.verifyBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            NSInteger seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [weakSelf.verifyBtn setTitle:[NSString stringWithFormat:@"已发(%.2ld)", (long)seconds] forState:UIControlStateNormal];
                weakSelf.verifyBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - Button Action

- (IBAction)registerClick:(UIButton *)sender {
}
- (IBAction)contactClick:(UIButton *)sender {
}
- (IBAction)loginClick:(UIButton *)sender {
}
- (IBAction)checkDealClick:(UIButton *)sender {
}
- (IBAction)closeClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
