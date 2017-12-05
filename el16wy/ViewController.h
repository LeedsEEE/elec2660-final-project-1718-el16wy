//
//  ViewController.h
//  el16wy
//
//  Created by WEIBIN YUAN on 2017/11/6.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
//suggestion value
- (IBAction)mySwitch:(UISwitch *)sender;
- (IBAction)mySlider:(UISlider *)sender;

@property (weak, nonatomic) IBOutlet UILabel *Gender;
@property (weak, nonatomic) IBOutlet UILabel *Weight;
@property (weak, nonatomic) IBOutlet UILabel *Suggestion;
@property (weak, nonatomic) IBOutlet UISlider *kgValue;
@property (weak, nonatomic) IBOutlet UISwitch *MF;


- (IBAction)reclick:(UIButton *)sender;  // use for reset the cup if you mistaken the glasses of water

@property (weak, nonatomic) IBOutlet UIImageView *imageView;  // for images show

@end

