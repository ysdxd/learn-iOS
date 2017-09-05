//
//  ViewController.m
//  MyTableView
//
//  Created by 云朽 on 2017/9/5.
//  Copyright © 2017年 云朽. All rights reserved.
//

#import "ViewController.h"
#import "BaseUITableViewController.h"
#import "SimpleViewController.h"
#import "AdvanceTableViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnBaseTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnCustomTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnSimpleTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initView];
}

- (void)initView {
    self.btnBaseTableView.layer.borderWidth = 1;
    self.btnBaseTableView.layer.borderColor = [UIColor blueColor].CGColor;
    self.btnBaseTableView.layer.cornerRadius = 5;
    
    self.btnCustomTableView.layer.borderWidth = 1;
    self.btnCustomTableView.layer.borderColor = [UIColor blueColor].CGColor;
    self.btnCustomTableView.layer.cornerRadius = 5;
    
    self.btnSimpleTableView.layer.borderWidth = 1;
    self.btnSimpleTableView.layer.borderColor = [UIColor blueColor].CGColor;
    self.btnSimpleTableView.layer.cornerRadius = 5;
}

- (IBAction)btnSimpleClick:(id)sender {
    
    SimpleViewController *simpleVC = [[SimpleViewController alloc] init];
    
    [self.navigationController pushViewController:simpleVC animated:YES];
}

- (IBAction)btnBaseClick:(id)sender {
//    NSLog(@"base table view");
    
    BaseUITableViewController *baseVC = [[BaseUITableViewController alloc] init];
    
    [self.navigationController pushViewController:baseVC animated:YES];
}


- (IBAction)btnCustomClick:(id)sender {
//    NSLog(@"custom table view");
    
    AdvanceTableViewController *advanceVC = [[AdvanceTableViewController alloc] init];
    
    [self.navigationController pushViewController:advanceVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
