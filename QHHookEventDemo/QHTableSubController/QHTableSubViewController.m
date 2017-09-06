//
//  QHTableSubViewController.m
//  QHTableViewDemo
//
//  Created by chen on 17/3/21.
//  Copyright © 2017年 chen. All rights reserved.
//

#import "QHTableSubViewController.h"

@interface QHTableSubViewController ()

@end

@implementation QHTableSubViewController

- (void)dealloc {
#if DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)p_viewPath:(id)sender {
    id responder = sender;
    UIView *currentView = responder;
    NSMutableString *viewPath = [NSMutableString stringWithUTF8String:object_getClassName(responder)];
    NSMutableString *indexPath = [NSMutableString new];
    while (![responder isKindOfClass:[UIViewController class]] && ![responder isKindOfClass:[UIWindow class]]) {
        responder = [responder nextResponder];
        [viewPath insertString:[NSString stringWithFormat:@"%@/", [NSString stringWithUTF8String:object_getClassName(responder)]] atIndex:0];
        
        UIView *childView = currentView;
        UIView *superView = currentView.superview;
        NSInteger index = [superView.subviews indexOfObject:childView];
        [indexPath insertString:[NSString stringWithFormat:@"/%ld", (long)index] atIndex:0];
        currentView = superView;
    }
    [indexPath insertString:@"0" atIndex:0];
    NSLog(@"%@ & %@", viewPath, indexPath);
}

#pragma mark - Public


#pragma mark - <#SystemDelegate#>


#pragma mark - <#CustomDelegate#>


#pragma mark - Util


#pragma mark - Action

- (IBAction)buttonAction:(id)sender {
    [self p_viewPath:sender];
}

#pragma mark - Get



@end
