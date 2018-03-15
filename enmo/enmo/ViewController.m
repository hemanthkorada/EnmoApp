//
//  ViewController.m
//  enmo
//
//  Created by APPLE on 07/03/18.
//  Copyright © 2018 APPLE. All rights reserved.
//

#import "ViewController.h"

#import "EnmoSDK/EnmoSDK.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [EnmoManager.shared  start3rdPartyRanging];
    [EnmoManager.shared  stop3rdPartyRanging];

    
    
   // EnmoManager *fdsfv = [EnmoManager new];
    

    


    
   // [.shared start3rdPartyRanging];

    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
