//
//  reminderViewController.m
//  el16wy
//
//  Created by WEIBIN YUAN on 2017/12/2.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import "reminderViewController.h"
#import <UserNotifications/UserNotifications.h>

// The noticfication in this part will not run in the simulator, need to use real device to test.

@interface reminderViewController ()
<
UIPickerViewDataSource,
UIPickerViewDelegate,
UITextFieldDelegate,
UNUserNotificationCenterDelegate
>
{
    NSInteger isEdit;     // textfield editing
    NSString *hour;
    NSString *minute;
//    NSString *second;
    
}
@end

@implementation reminderViewController


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    isEdit = textField.tag;
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    hour  = @"00";
    minute = @"00";
    // get the data want to show
    [self loadData];
    UIPickerView * pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-300, self.view.frame.size.width, 300)];   // creat pickerView and set its size
    pickView.dataSource = self;
    pickView.delegate = self;
    self.clock1.inputView = pickView;
    self.clock2.inputView = pickView;
    self.clock3.inputView = pickView;
    self.clock4.inputView = pickView;
    self.clock5.inputView = pickView;
    self.clock6.inputView = pickView;
    self.clock7.inputView = pickView;
    self.clock8.inputView = pickView;
}
- (void)loadData {
    // hours show
    self.data1 = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",
                   @"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",
                   @"22",@"21",@"22",@"23"];
    // minutes show
    self.data2 = @[
                   @"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",
                   @"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",
                   @"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",
                   @"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",
                   @"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",
                   @"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59"];
}
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;   // 2 rows, hour and minute
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.data1.count;
    }else{
        return self.data2.count;
    }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.data1[row];
    }else{
        return self.data2[row];
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        hour = [self.data1 objectAtIndex:row];
    }else if (component == 1){
        minute = [self.data2 objectAtIndex:row];
    }
    if (isEdit == 1) {
        [self.clock1 setText:[NSString stringWithFormat:@"%@:%@",hour,minute]];
    }else if (isEdit == 2) {
        [self.clock2 setText:[NSString stringWithFormat:@"%@:%@",hour,minute]];
    }else if (isEdit == 3) {
        [self.clock3 setText:[NSString stringWithFormat:@"%@:%@",hour,minute]];
    }else if (isEdit == 4) {
        [self.clock4 setText:[NSString stringWithFormat:@"%@:%@",hour,minute]];
    }else if (isEdit == 5) {
        [self.clock5 setText:[NSString stringWithFormat:@"%@:%@",hour,minute]];
    }else if (isEdit == 6) {
        [self.clock6 setText:[NSString stringWithFormat:@"%@:%@",hour,minute]];
    }else if (isEdit == 7) {
        [self.clock7 setText:[NSString stringWithFormat:@"%@:%@",hour,minute]];
    }else if (isEdit == 8) {
        [self.clock8 setText:[NSString stringWithFormat:@"%@:%@",hour,minute]];
    }
    //    NSLog(@"row: %d, component: %d", row, component);
}
- (IBAction)changeSwitch:(UISwitch *)sender {
    BOOL isButtonOn = [sender isOn];
    if (isButtonOn) {
        NSLog(@"ON");
        if (sender.tag == 0) {
            // Repeat Everyday
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"RepeatEveryday"];
        }else{
            
            NSDate *nowDate = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
            NSString *NowDateTime = [formatter stringFromDate:nowDate];
            
            [formatter setDateFormat:@"dd-MM-yyyy"];
            NSString *SelectDateTime = [formatter stringFromDate:nowDate];
            if (sender.tag == 1){
                //clock1
                SelectDateTime = [NSString stringWithFormat:@"%@ %@",SelectDateTime,self.clock1.text];
            }else if (sender.tag == 2){
                //clock2
                SelectDateTime = [NSString stringWithFormat:@"%@ %@",SelectDateTime,self.clock2.text];
            }else if (sender.tag == 3){
                //clock3
                SelectDateTime = [NSString stringWithFormat:@"%@ %@",SelectDateTime,self.clock3.text];
            }else if (sender.tag == 4){
                //clock4
                SelectDateTime = [NSString stringWithFormat:@"%@ %@",SelectDateTime,self.clock4.text];
            }else if (sender.tag == 5){
                //clock5
                SelectDateTime = [NSString stringWithFormat:@"%@ %@",SelectDateTime,self.clock5.text];
            }else if (sender.tag == 6){
                //clock6
                SelectDateTime = [NSString stringWithFormat:@"%@ %@",SelectDateTime,self.clock6.text];
            }else if (sender.tag == 7){
                //clock7
                SelectDateTime = [NSString stringWithFormat:@"%@ %@",SelectDateTime,self.clock7.text];
            }else if (sender.tag == 8){
                //clock8
                SelectDateTime = [NSString stringWithFormat:@"%@ %@",SelectDateTime,self.clock8.text];
            }
            [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
            nowDate = [formatter dateFromString:NowDateTime];
            NSDate *selectData = [formatter dateFromString:SelectDateTime];
            
            if (![self isTodayNow:NowDateTime Select:SelectDateTime]){
                // if time is past, add it to next day
                selectData = [NSDate dateWithTimeInterval:24*60*60 sinceDate:selectData];
            }
            // calculate the difference in seconds
            NSTimeInterval timeBetween = [selectData timeIntervalSinceDate:nowDate];
            
            NSLog(@"nowDate:%@  time:%f",nowDate,timeBetween);
            
            
            // new notification content object
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
            content.title = @"Notification！";
            content.subtitle = @"It's time to drink！";
            content.body = @"test message,";
            content.badge = @0;
            UNNotificationSound *sound = [UNNotificationSound soundNamed:@"caodi.m4a"];
            content.sound = sound;
            content.categoryIdentifier = [NSString stringWithFormat:@"%ld",sender.tag];
            
            // trigger notification (repeat should be longer than 60s)
            UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeBetween repeats:NO];
            
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"RepeatEveryday"]isEqualToString:@"YES"]) {
                NSDateComponents *components = [[NSDateComponents alloc] init];
                
                [formatter setDateFormat:@"HH"];
                NSString *select = [formatter stringFromDate:selectData];
                components.hour = [select integerValue];
                UNCalendarNotificationTrigger *trigger2 = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
                
                // creat UNNotificationRequest to notice the request object
                NSString *requertIdentifier = [NSString stringWithFormat:@"%ld",sender.tag];
                NSLog(@"requertIdentifier:%@",requertIdentifier);
                UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger2];
                
                // add notification to notification center
                [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                    NSLog(@"Error:%@",error);
                    
                }];
            }else{
                // creat UNNotificationRequest to notice the request object
                NSString *requertIdentifier = [NSString stringWithFormat:@"%ld",sender.tag];
                NSLog(@"requertIdentifier:%@",requertIdentifier);
                UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger1];
                
                // add notification to notification center
                [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                    NSLog(@"Error:%@",error);
                    
                }];
            }
            
            
        }
    }else {
        NSLog(@"OFF");
        if (sender.tag == 0) {
            // Repeat Everyday
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"RepeatEveryday"];
            // delete notification
            NSString *requestIdentifier = [NSString stringWithFormat:@"%ld",sender.tag];
            NSLog(@"requestIdentifier:%@",requestIdentifier);
            UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
            // delete all messages that not received by the device
            [center removeAllPendingNotificationRequests];
        }else{
            // delete notification
            NSString *requestIdentifier = [NSString stringWithFormat:@"%ld",sender.tag];
            NSLog(@"requestIdentifier:%@",requestIdentifier);
            UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
            // delete all messages that not received by the device of specific id
            [center removePendingNotificationRequestsWithIdentifiers:@[requestIdentifier]];
        }
    }
}


// run in background
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    
    NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
    NSLog(@"received notice：%@",response.notification.request.content);
    NSLog(@"categoryIdentifier:%@",categoryIdentifier);
    completionHandler();
    
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"RepeatEveryday"]isEqualToString:@"YES"]) {
        if ([categoryIdentifier integerValue]==1) {
            [self.switch1 setOn:NO];
        }else if ([categoryIdentifier integerValue]==2) {
            [self.switch2 setOn:NO];
        }else if ([categoryIdentifier integerValue]==3) {
            [self.switch3 setOn:NO];
        }else if ([categoryIdentifier integerValue]==4) {
            [self.switch4 setOn:NO];
        }else if ([categoryIdentifier integerValue]==5) {
            [self.switch5 setOn:NO];
        }else if ([categoryIdentifier integerValue]==6) {
            [self.switch6 setOn:NO];
        }else if ([categoryIdentifier integerValue]==7) {
            [self.switch7 setOn:NO];
        }else if ([categoryIdentifier integerValue]==8) {
            [self.switch8 setOn:NO];
        }
        
    }
}


// only run in the foreground, display information in the foreground
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSLog(@"run willPresentNotificaiton");
    completionHandler(UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);
}


// determine current time
- (BOOL)isTodayNow:(NSString *)nowDateTime Select:(NSString*)selectDataTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSDate *nowDate = [dateFormatter dateFromString:nowDateTime];
    NSDate *selectData = [dateFormatter dateFromString:selectDataTime];
    if ([nowDate timeIntervalSinceDate:selectData] < 0.0f) {
        NSLog(@"time > now");
        return YES;
    } else {
        NSLog(@"time < now");
        return NO;
    }
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

@end

