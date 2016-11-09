//
//  ViewController.m
//  Track
//
//  Created by Kenvin on 2016/03/10.
//  Copyright © 2016年 Kenvin. All rights reserved.
//

#import "ViewController.h"
#import "Tracker.h"

static NSString *const viewWillAppear = @"viewWillAppear";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[Tracker sharedInstance] addLog:[[LogData create]
                                      event:viewWillAppear]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
