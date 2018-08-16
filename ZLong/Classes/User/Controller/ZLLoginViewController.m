//
//  ZLLoginViewController.m
//  ZLong
//
//  Created by 刘星 on 2018/8/5.
//  Copyright © 2018年 4vit. All rights reserved.
//

#import "ZLLoginViewController.h"
#import "ZLRegisterViewController.h"
#import "ZLMallViewController.h"
#import "ZLNearbyViewController.h"
#import "ZLIMViewController.h"
#import "ZLBonusViewController.h"
@interface ZLLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UILabel *verifyLabel;
@property (weak, nonatomic) IBOutlet UIButton *rememberbtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *verifyField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (assign,nonatomic) BOOL isPwdLogin;

@end

@implementation ZLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
}

#pragma mark - initialize
- (void)setUpBase
{
    [self showVerifyView:NO];
    _loginButton.enabled = _verifyBtn.enabled = NO;

    [_userNameField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    [_verifyField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
}

- (void)showVerifyView:(BOOL)isShow
{
    if (isShow) {
        _verifyBtn.hidden = NO;
        _forgetBtn.hidden = YES;
        _rememberbtn.hidden = YES;
        _isPwdLogin = NO;
        _verifyLabel.text = @"验证码";
        _verifyField.placeholder = @"请输入您收到的验证码";
    } else {
        _verifyBtn.hidden = YES;
        _forgetBtn.hidden = NO;
        _rememberbtn.hidden = NO;
        _isPwdLogin = YES;
        _verifyLabel.text = @"密    码";
        _verifyField.placeholder = @"请输入您设置的密码";

    }
}

#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_userNameField.text.length != 0 && _isPwdLogin == NO) {
        _verifyBtn.enabled = YES;
    }else if (_userNameField.text.length == 0 && _isPwdLogin == NO){
        [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verifyBtn.enabled = NO;
    }
    
    if (_userNameField.text.length != 0 && _verifyField.text.length != 0) {
        _loginButton.enabled = YES;
    }else{
        _loginButton.enabled = NO;
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
- (IBAction)switchVerifyLogin:(UIButton *)sender {
    if (_isPwdLogin) {
        [self showVerifyView:YES];
    } else {
        [self showVerifyView:NO];
    }
}

- (IBAction)loginClick:(UIButton *)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = @{
                             @"phone":@"17671728582",
                             @"password":@"123456"
                             };
    [ZLNetwork POSTWithURL:API_LOGIN parameters:params callback:^(ZLResponse *responseObject, NSError *error, BOOL isFromCache) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!responseObject.success) {
            [MBProgressHUD showError:responseObject.msg];
            return ;
        } //失败
        
        if (responseObject.s == ZLStatusCodeSuccess) {
            [MBProgressHUD showSuccess:responseObject.msg];
            [DCUserInfo saveLoginCookie]; //保存cookie
            [self dismissViewControllerAnimated:YES completion:^{
                if ([@[[ZLIMViewController class],[ZLMallViewController class],[ZLNearbyViewController class],[ZLBonusViewController class]] containsObject:[[DCSpeedy dc_getCurrentVC] class]]) { //过滤
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"LOGINSELECTCENTERINDEX" object:nil];
                }
            }];
        } else {
            [MBProgressHUD showError:responseObject.msg];
        }
    }];
}

- (IBAction)closeClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerClick:(UIButton *)sender {
    ZLRegisterViewController *reVC = [[ZLRegisterViewController alloc] init];
    [self presentViewController:reVC animated:YES completion:nil];
}

- (IBAction)forgetPwdClick:(UIButton *)sender {
}

#pragma mark - net request




@end
