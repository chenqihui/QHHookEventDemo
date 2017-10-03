//
//  QHTableSubViewController.m
//  QHTableViewDemo
//
//  Created by chen on 17/3/21.
//  Copyright © 2017年 chen. All rights reserved.
//

#import "QHTableSubViewController.h"

#import "QHHookUtil.h"

@implementation QHTableViewCell

- (IBAction)switchAction:(id)sender {
    NSLog(@"%s", __FUNCTION__);
}

@end

@interface QHTableSubViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@property (weak, nonatomic) IBOutlet UILabel *tapGestureLabel;

@property (weak, nonatomic) IBOutlet UIView *addButtonView;

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
    [self p_setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)p_setup {
    self.dataArray = @[@"a", @"b"];
    
    UINib *nib = [UINib nibWithNibName:@"QHTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"QHTableViewCell"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(manualAction)];
    [self.tapGestureLabel addGestureRecognizer:tap];
}

- (void)p_addButtonWithTitle:(NSString *)title frame:(CGRect)frame tag:(NSInteger)tag {
    id button = [self.addButtonView viewWithTag:tag];
    if (button != nil) {
        return;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.frame = frame;
    btn.tag = tag;
    [self.addButtonView addSubview:btn];
    
    [btn addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - <#CustomDelegate#>


#pragma mark - Util


#pragma mark - Action

- (IBAction)buttonAction:(id)sender {
    NSLog(@"%s", __FUNCTION__);
}

- (IBAction)xibAction:(id)sender {
    NSLog(@"%s", __FUNCTION__);
}

- (void)manualAction {
    NSLog(@"%s", __FUNCTION__);
}

/*
 同一父viewPath，动态添加显相同的控件，其index位置就不固定，针对这种情况就需要获取其他参考物，如获取它当前的frame.origin.x或者y，或者title，下面的情况两种都可以。这点需要圈点和埋点配合。
 */
- (IBAction)addButtonOneAction:(id)sender {
    CGRect frame = CGRectMake(0, 0, self.addButtonView.frame.size.width/3, self.addButtonView.frame.size.height);
    [self p_addButtonWithTitle:@"oneAction" frame:frame tag:1];
}

- (IBAction)addButtonTwoAction:(id)sender {
    CGRect frame = CGRectMake(self.addButtonView.frame.size.width/3, 0, self.addButtonView.frame.size.width/3, self.addButtonView.frame.size.height);
    [self p_addButtonWithTitle:@"twoAction" frame:frame tag:2];
}

- (IBAction)addButtonThreeAction:(id)sender {
    CGRect frame = CGRectMake(self.addButtonView.frame.size.width/3*2, 0, self.addButtonView.frame.size.width/3, self.addButtonView.frame.size.height);
    [self p_addButtonWithTitle:@"threeAction" frame:frame tag:3];
}

- (void)addButtonAction:(UIButton *)sender {
    NSLog(@"%@", sender.titleLabel.text);
}

- (IBAction)cleanAction:(id)sender {
    [self.addButtonView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

#pragma mark - Get



@end
