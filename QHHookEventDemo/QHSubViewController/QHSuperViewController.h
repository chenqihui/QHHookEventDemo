//
//  QHSuperViewController.h
//  QHHookEventDemo
//
//  Created by Anakin chen on 2017/10/3.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

#import "QHTableSubViewController.h"

@interface QHSuperViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@end
