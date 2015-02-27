//
//  ViewController.m
//  sinaweibo
//
//  Created by aoi on 15/2/26.
//  Copyright (c) 2015年 cezr. All rights reserved.
//

#import "ViewController.h"
#import "WeiBoDemo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sigin:(id)sender {
    [[WeiBoDemo sharedWeiBo] sigin];
}

- (IBAction)sendMsg:(id)sender {
    //NSData *data = [NSData dataWithContentsOfFile:@"psb.jpg"];
    [[WeiBoDemo sharedWeiBo] sendMsgText:@"Azusa" Image:[UIImage imageNamed:@"psb.jpg"]];
}



@end










