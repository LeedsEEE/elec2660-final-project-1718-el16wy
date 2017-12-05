//
//  reminderViewController.h
//  el16wy
//
//  Created by WEIBIN YUAN on 2017/12/2.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reminderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *clock1;
@property (weak, nonatomic) IBOutlet UITextField *clock2;
@property (weak, nonatomic) IBOutlet UITextField *clock3;
@property (weak, nonatomic) IBOutlet UITextField *clock4;
@property (weak, nonatomic) IBOutlet UITextField *clock5;
@property (weak, nonatomic) IBOutlet UITextField *clock6;
@property (weak, nonatomic) IBOutlet UITextField *clock7;
@property (weak, nonatomic) IBOutlet UITextField *clock8;

@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UISwitch *switch3;
@property (weak, nonatomic) IBOutlet UISwitch *switch4;
@property (weak, nonatomic) IBOutlet UISwitch *switch5;
@property (weak, nonatomic) IBOutlet UISwitch *switch6;
@property (weak, nonatomic) IBOutlet UISwitch *switch7;
@property (weak, nonatomic) IBOutlet UISwitch *switch8;


@property (strong, nonatomic) NSArray * data1;   // array of hour number 00-23
@property (strong, nonatomic) NSArray * data2;   // arrat of minute number 00-59

@end
