//
//  QHSuperViewController.m
//  QHHookEventDemo
//
//  Created by Anakin chen on 2017/10/3.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

#import "QHSuperViewController.h"

@interface QHSuperViewController ()

@end

@implementation QHSuperViewController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - Private


#pragma mark - Public


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QHTableViewCell"];
    if (!cell) {
        cell = [[QHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QHTableViewCell"];
    }
    cell.label.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - <#CustomDelegate#>


#pragma mark - Util


#pragma mark - Action


#pragma mark - Get


@end
