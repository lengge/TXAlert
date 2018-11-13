//
//  TXAlertManager.m
//  TXFutures
//
//  Created by dong on 2018/10/7.
//  Copyright © 2018年 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXAlertManager.h"
#import <objc/runtime.h>

BOOL TXJudgeKeyExistInClass(Class metaClass, NSString *key) {
    BOOL exist = NO;
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(metaClass, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        if ([keyName isEqualToString:key]) {
            exist = YES;
            break;
        }
    }
    return exist;
}

@interface TXAlertManager ()

@property (nonatomic, weak) UIAlertController *alertController;

@end

static id _manager = nil;

@implementation TXAlertManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (void)showAlertWithTitle:(nullable NSString *)title
                   message:(nullable NSString *)message
                   actions:(NSArray<UIAlertAction *> *)actions
            preferredStyle:(UIAlertControllerStyle)preferredStyle {
    NSAssert(actions.count > 0, @"Actions至少有一个Action");

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title ? : @"" message:message preferredStyle:preferredStyle];
    _alertController = alertController;
    [actions enumerateObjectsUsingBlock:^(UIAlertAction * _Nonnull action, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertController addAction:action];
    }];
    
    UINavigationController *rootViewController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController.topViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)showAlertWithAttributedTitle:(nullable NSAttributedString *)attributedTitle
                   attributedMessage:(nullable NSAttributedString *)attributedMessage
                             actions:(NSArray<UIAlertAction *> *)actions
                      preferredStyle:(UIAlertControllerStyle)preferredStyle {
    NSAssert(actions.count > 0, @"Actions至少有一个Action");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[attributedTitle string] ? : @"" message:[attributedMessage string] preferredStyle:preferredStyle];
    _alertController = alertController;
    
    if (TXJudgeKeyExistInClass([UIAlertController class], @"_attributedTitle")) {
        [alertController setValue:attributedTitle forKey:@"_attributedTitle"];
    }
    
    if (TXJudgeKeyExistInClass([UIAlertController class], @"_attributedMessage")) {
        [alertController setValue:attributedMessage forKey:@"_attributedMessage"];
    }
    
    [actions enumerateObjectsUsingBlock:^(UIAlertAction * _Nonnull action, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertController addAction:action];
    }];
    
    UINavigationController *rootViewController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController.topViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)dismiss {
    [_alertController dismissViewControllerAnimated:YES completion:nil];
}

@end
