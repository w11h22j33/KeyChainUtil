//
//  ViewController.m
//  KeyChainDemo
//
//  Created by wanghaijun on 14-3-10.
//  Copyright (c) 2014年 ___NAVY___. All rights reserved.
//

#import "ViewController.h"
#import <UIView+Positioning.h>
#import "SFHFKeychainUtils.h"

@interface ViewController ()

- (void)buttonClicked:(id)sender;

@end


#define SERVICE_NAME @"com.umpay.KeyChainDemo"

@implementation ViewController

@synthesize name,pwd;

- (void)loadView{
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    self.view = [UIView new];
    self.view.width = window.width;
    self.view.height = window.height;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.name = [UITextField new];
    name.x = 20;
    name.y = 30;
    name.width = window.width - 20 * 2;
    name.height = 30;
    name.borderStyle = UITextBorderStyleLine;
    name.placeholder = @"请输入账号";
    name.tag = 100;
    [name setAutocapitalizationType:(UITextAutocapitalizationTypeNone)];
    [self.view addSubview:name];
    
    
    self.pwd = [UITextField new];
    pwd.x = 20;
    pwd.y = 80;
    pwd.width = window.width - 20 * 2;
    pwd.height = 30;
    pwd.borderStyle = UITextBorderStyleLine;
    pwd.placeholder = @"请输入密码";
    pwd.tag = 101;
    [pwd setAutocapitalizationType:(UITextAutocapitalizationTypeNone)];
    [self.view addSubview:pwd];
    
    UIButton *save = [UIButton buttonWithType:UIButtonTypeSystem];
    save.tag = 102;
    save.x = 20;
    save.y = 130;
    save.width = window.width - 20 * 2;
    save.height = 30;
    save.backgroundColor = [UIColor greenColor];
    [save setTitle:@"保存" forState:UIControlStateNormal];
    [save addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:save];
    
    UIButton *restore = [UIButton buttonWithType:UIButtonTypeSystem];
    restore.tag = 103;
    restore.x = 20;
    restore.y = 180;
    restore.width = window.width - 20 * 2;
    restore.height = 30;
    restore.backgroundColor = [UIColor orangeColor];
    [restore setTitle:@"恢复" forState:UIControlStateNormal];
    [restore addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restore];
    
    UIButton *delete = [UIButton buttonWithType:UIButtonTypeSystem];
    delete.tag = 104;
    delete.x = 20;
    delete.y = 230;
    delete.width = window.width - 20 * 2;
    delete.height = 30;
    delete.backgroundColor = [UIColor redColor];
    [delete setTitle:@"删除" forState:UIControlStateNormal];
    [delete addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delete];
    
}

- (void)buttonClicked:(id)sender{
    
    int tag = ((UIView*)sender).tag;
    
    NSString *nameText = self.name.text;
    NSString *pwdText = self.pwd.text;
    
    switch (tag) {
        case 102:{
            
            NSLog(@"save buttonClicked -->");
            
            if (nameText && pwdText && ![nameText isEqualToString:@""] && ![pwdText isEqualToString:@""]) {
                [name resignFirstResponder];
                [pwd resignFirstResponder];
                
                NSError* error = nil;
                
                BOOL result = [SFHFKeychainUtils storeUsername:nameText andPassword:pwdText forServiceName:SERVICE_NAME updateExisting:YES error:&error];
                
                if (result && (error == nil)) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:@"name and password had saved!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:@"please input name and password!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
            
            
            break;
            
        }
            
        case 103:{
            
            NSLog(@"restore buttonClicked -->");
            
            if (nameText && ![nameText isEqual:@""]) {
                
                NSError *error = nil;
                
                NSString *pwdString = [SFHFKeychainUtils getPasswordForUsername:nameText andServiceName:SERVICE_NAME error:&error];
                
                if ((error == nil) && (pwdString != nil)) {
                    
                    pwd.text = pwdString;
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:@"password had read!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }
                
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:@"please input name!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
            break;
            
        }
            
        case 104:{
            
            NSLog(@"delete buttonClicked -->");
            
            if (nameText && ![nameText isEqual:@""]) {
                
                NSError *error = nil;
                
                BOOL result = [SFHFKeychainUtils deleteItemForUsername:nameText andServiceName:SERVICE_NAME error:&error];
                
                if ((error == nil) && result) {
                    
                    pwd.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:@"password had deleted!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }
                
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:@"please input name!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
            break;
            
        }
            
        default:
            break;
    }
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
