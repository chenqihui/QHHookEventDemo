//
//  QHSubViewController.m
//  QHHookEventDemo
//
//  Created by Anakin chen on 2017/10/3.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

#import "QHSubViewController.h"

@interface QHSubViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation QHSubViewController

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


#pragma mark - <#SystemDelegate#>


#pragma mark - <#CustomDelegate#>


#pragma mark - Util


#pragma mark - Action


#pragma mark - Get


@end
