//
//  Home_ViewController.m
//  FinalProject
//
//  Created by Oscar on 4/2/14.
//  Copyright (c) 2014 Oscar. All rights reserved.
//

#import "Home_ViewController.h"

@interface Home_ViewController ()

@end

@implementation Home_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //NSString *myListPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSString *myListPath =[path stringByAppendingPathComponent:@"/data.plist"];
    NSMutableArray * dataArray = [[NSMutableArray alloc]initWithContentsOfFile:myListPath];
    
    if([dataArray objectAtIndex:0] == NULL)
    {
        _score_lable.text = @"Highest Score :  No Record";
    }
    else
    {
        _score_lable.text = [NSString stringWithFormat:@"Highest Score :  %@ second",[dataArray objectAtIndex:0]];
    }
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
