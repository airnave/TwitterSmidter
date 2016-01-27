//
//  ViewController.m
//  TwitterShmidter
//
//  Created by Alexander Demidovich on 26.01.16.
//  Copyright © 2016 Alexander Demidovich. All rights reserved.
//

#import "ViewController.h"
#import "AccViewController.h"

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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    AccViewController *accountOnViewCont = [segue destinationViewController];
    accountOnViewCont.username = _usernameTextField.text;
}

@end
