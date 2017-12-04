//
//  historyViewController.h
//  el16wy
//
//  Created by WEIBIN YUAN on 2017/12/4.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface historyViewController : UIViewController
- (IBAction)Change:(UISegmentedControl *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * array;

@end

