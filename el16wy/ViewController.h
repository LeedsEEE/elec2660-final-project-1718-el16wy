//
//  ViewController.h
//  el16wy
//
//  Created by WEIBIN YUAN on 2017/11/6.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)mySwitch:(UISwitch *)sender;
- (IBAction)mySlider:(UISlider *)sender;


//suggestion value
@property (weak, nonatomic) IBOutlet UILabel *Gender;
@property (weak, nonatomic) IBOutlet UILabel *Weight;
@property (weak, nonatomic) IBOutlet UILabel *Suggestion;
@property (weak, nonatomic) IBOutlet UISlider *kgValue;
@property (weak, nonatomic) IBOutlet UISwitch *MF;


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

