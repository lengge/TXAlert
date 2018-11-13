//
//  TXAlertManager.h
//  TXFutures
//
//  Created by dong on 2018/10/7.
//  Copyright © 2018年 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TXAlertManager : NSObject

+ (instancetype)sharedManager;

- (void)showAlertWithTitle:(nullable NSString *)title
                   message:(nullable NSString *)message
                   actions:(NSArray<UIAlertAction *> *)actions
            preferredStyle:(UIAlertControllerStyle)preferredStyle;

- (void)showAlertWithAttributedTitle:(nullable NSAttributedString *)attributedTitle
                   attributedMessage:(nullable NSAttributedString *)attributedMessage
                             actions:(NSArray<UIAlertAction *> *)actions
                      preferredStyle:(UIAlertControllerStyle)preferredStyle;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
