//
//  QHTableSubViewController.m
//  QHTableViewDemo
//
//  Created by chen on 17/3/21.
//  Copyright © 2017年 chen. All rights reserved.
//

#import "QHTableSubViewController.h"

#import "QHHookUtil.h"

@interface QHTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation QHTableViewCell

- (IBAction)switchAction:(id)sender {
    NSLog(@"%s", __FUNCTION__);
}

@end

@interface QHTableSubViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

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

#pragma mark - Get



@end
