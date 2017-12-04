//
//  ViewController.m
//  el16wy
//
//  Created by WEIBIN YUAN on 2017/11/6.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // empty glass
    self.img1.hidden = true;
    self.img2.hidden = true;
    self.img3.hidden = true;
    self.img4.hidden = true;
    self.img5.hidden = true;
    self.img6.hidden = true;
    self.img7.hidden = true;
    self.img8.hidden = true;
    
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


// add water
- (IBAction)plus:(UIButton *)sender {

}

// pour water
- (IBAction)minus:(UIButton *)sender {

}


@end
