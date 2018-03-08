//
//  ViewController.m
//  iOSHybridRNDemo
//
//  Created by 刘光强 on 2018/3/8.
//  Copyright © 2018年 刘光强. All rights reserved.
//

#import "ViewController.h"
#import "RNViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushRNVC:(id)sender {
    RNViewController *VC = [[RNViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
