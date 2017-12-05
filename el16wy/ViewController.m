//
//  ViewController.m
//  el16wy
//
//  Created by WEIBIN YUAN on 2017/11/6.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import "ViewController.h"
#import "historyModel.h"
#import "JQFMDB.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // get system date
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSString *NowDateTime = [formatter stringFromDate:nowDate];
    
    NSLog(@"NowDateTime:%@",NowDateTime);
    
    // get the result of lastopen
    NSString * lastOpen = [[NSUserDefaults standardUserDefaults]objectForKey:@"lastOpen"];
    NSLog(@"lastOpen:%@",lastOpen);
    // for no record
    if (lastOpen.length == 0) {
        [[NSUserDefaults standardUserDefaults]setObject:NowDateTime forKey:@"lastOpen"];
    }else{
        // for record
        if ([NowDateTime isEqualToString:lastOpen]) {
            // for same day
        }else{
            // if not the same day, clear the water form glass
            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"water"];
        }
    }
    
    // update imageview
    NSString * water = [[NSUserDefaults standardUserDefaults]objectForKey:@"water"];
    NSLog(@"water:%@",water);
    [self.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"water%ld",[water integerValue]]]];
    
    [[NSUserDefaults standardUserDefaults]setObject:NowDateTime forKey:@"lastOpen"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // add medthod for imageView can be clicked
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.imageView addGestureRecognizer:singleTap];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// choose gender: on for male and off for female, then it will show the suggestion drinking value
- (IBAction)mySwitch:(UISwitch *)sender {
    if (sender.on) {
        self.Gender.text = @"Male";
        self.Suggestion.text = [NSString stringWithFormat:@"Drink %.f mL per glass", self.kgValue.value*40*13/25/8];
    } else {
        self.Gender.text = @"Female";
        self.Suggestion.text = [NSString stringWithFormat:@"Drink %.f mL per glass", self.kgValue.value*35*13/25/8];
    }
}


// move slider to choose weight and it will show the suggestion drinking value
- (IBAction)mySlider:(UISlider *)sender {
    self.Weight.text = [NSString stringWithFormat:@"Weight = %.f kg", sender.value];
    if (self.MF.on) {
        self.Suggestion.text = [NSString stringWithFormat:@"Drink %.f mL per glass", self.kgValue.value*40*13/25/8];
    } else {
        self.Suggestion.text = [NSString stringWithFormat:@"Drink %.f mL per glass", self.kgValue.value*35*13/25/8];
    }
}



- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    // record the current glasses of water
    NSString * water = [[NSUserDefaults standardUserDefaults]objectForKey:@"water"];
    // if < 8, then add a glass of water
    if ([water integerValue]<8) {
        [self.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"water%ld",[water integerValue]+1]]];
        // update userdefaults
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",[water integerValue]+1] forKey:@"water"];
        
        // create a database
        JQFMDB *db = [JQFMDB shareDatabase:@"water.sqlite" path:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
        // create a history list
        [db jq_createTable:@"history" dicOrModel:[historyModel class]];
        // init data
        historyModel *history = [[historyModel alloc] init];
        // get the system date
        NSDate *nowDate = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"dd-MM-YYYY"];
        
        NSString *NowDateTime = [formatter stringFromDate:nowDate];
        history.date = NowDateTime;
        history.water = [NSString stringWithFormat:@"%ld",[water integerValue]+1];
        
        // determine whether the database have the current day record and check in list
        NSArray *array = [db jq_lookupTable:@"history" dicOrModel:[historyModel class] whereFormat:nil];
        for (historyModel *model in array) {
            // delete current date if the data record in current date
            if ([model.date isEqualToString:history.date]) {
                [db jq_deleteTable:@"history" whereFormat:[NSString stringWithFormat:@"where date = '%@'",history.date]];
            }
        }
        
        // insert the data in history list
        [db jq_insertTable:@"history" dicOrModel:history];
    }
    
}


- (IBAction)reclick:(UIButton *)sender {
    // reset the image and data of today
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"water"];
    [self.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"water0"]]];
    
}
@end
