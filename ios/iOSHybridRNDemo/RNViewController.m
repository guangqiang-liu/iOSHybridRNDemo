//
//  RNViewController.m
//  iOSHybridRNDemo
//
//  Created by 刘光强 on 2018/3/8.
//  Copyright © 2018年 刘光强. All rights reserved.
//

#import "RNViewController.h"
#import <React/RCTRootView.h>

@interface RNViewController ()

@end

@implementation RNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"RN Hybrid";
    
    NSURL * jsCodeLocation;
    NSString * strUrl = @"http://localhost:8081/index.ios.bundle?platform=ios&dev=true";
    jsCodeLocation = [NSURL URLWithString:strUrl];
    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                         moduleName:@"iOSHybridRNDemo"
                                                  initialProperties:nil
                                                      launchOptions:nil];
    
    self.view = rootView;
}


@end
