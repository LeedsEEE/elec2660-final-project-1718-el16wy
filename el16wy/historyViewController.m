//
//  historyViewController.m
//  el16wy
//
//  Created by WEIBIN YUAN on 2017/12/4.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import "historyViewController.h"
#import "JQFMDB.h"
#import "historyModel.h"
#import "DVBarChartView.h"

@interface historyViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
DVBarChartViewDelegate
>
{
    NSInteger type;
}

@end

@implementation historyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Change:(UISegmentedControl *)sender {
    self.tableView.tableHeaderView = [[UIView alloc]init];
    NSInteger Index = sender.selectedSegmentIndex;
    if (Index == 0) {
        NSLog(@"table View");
    }else{
        NSLog(@"bar Chart");
        // setting of bar chart
        DVBarChartView *chartView = [[DVBarChartView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 400)];
        [self.view addSubview:chartView];
        
        NSMutableArray * xAxisTitleArray = [NSMutableArray array];
        NSMutableArray * xValues = [NSMutableArray array];
        
        for (historyModel * model in self.array) {
            [xAxisTitleArray addObject:model.date];
            NSNumber * number = [NSNumber numberWithInteger:[model.water integerValue]];
            [xValues addObject:number];
        }
        chartView.yAxisViewWidth = 52;
        chartView.numberOfYAxisElements = 8;
        chartView.xAxisTitleArray = xAxisTitleArray;
        
        chartView.xValues = xValues;
        chartView.delegate = self;
        chartView.yAxisMaxValue = 8;
        //    chartView.barUserInteractionEnabled = NO;
        [chartView draw];
        
        self.tableView.tableHeaderView = chartView;
    }
    
    type = Index;
    [self.tableView reloadData];
}


- (void)barChartView:(DVBarChartView *)barChartView didSelectedBarAtIndex:(NSInteger)index {
    
    NSLog(@"%ld", index);
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // creat a database
    JQFMDB *db = [JQFMDB shareDatabase:@"water.sqlite" path:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    // creat a history list
    [db jq_createTable:@"history" dicOrModel:[historyModel class]];
    
    // check the list
    NSArray *array = [db jq_lookupTable:@"history" dicOrModel:[historyModel class] whereFormat:nil];
    NSLog(@"The list shows:");
    for (historyModel *model in array) {
        NSLog(@"date:%@ water:%@",model.date,model.water);
    }
    self.array = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (type == 0) {
        return self.array.count;
    }else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    historyModel * model = [self.array objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@  complete %@ /8 glasses of water", model.date,model.water];
    
    return cell;
}

@end

