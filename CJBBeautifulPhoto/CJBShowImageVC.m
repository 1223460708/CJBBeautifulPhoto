//
//  CJBShowImageVC.m
//  CJBBeautifulPhoto
//
//  Created by 炳神 on 16/8/31.
//  Copyright © 2016年 as2482199. All rights reserved.
//

#import "CJBShowImageVC.h"
#define MainWidth self.view.frame.size.width
#define MainHright self.view.frame.size.height
@interface CJBShowImageVC ()

@end

@implementation CJBShowImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 50, 50)];
    
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
    
    
    self.showImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 70, MainWidth, MainHright - 100)];
    
    self.showImage.image = self.imageB;
    
    [self.view addSubview:self.showImage];
    
    
}


-(void)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
