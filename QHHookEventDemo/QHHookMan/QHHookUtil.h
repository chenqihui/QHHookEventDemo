//
//  QHHookUtil.h
//  QHHookEventDemo
//
//  Created by Anakin chen on 2017/9/6.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QHHookUtil : NSObject

+ (void)swizzleTarget:(Class)class method:(SEL)originalSelector toMethod:(SEL)swizzledSelector;

@end
