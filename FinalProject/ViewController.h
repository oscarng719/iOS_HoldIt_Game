//
//  ViewController.h
//  FinalProject
//
//  Created by Oscar on 3/13/14.
//  Copyright (c) 2014 Oscar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bullets.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController
{
    NSTimer *moveObjectTimer;
    NSTimer *countSec;
    int timeCount;
    bool gameover;
    bool pause;
    NSMutableArray *bulletarray;
    bool checkExplosion;
    bool isExplosion;
    bool haveBomb;
    AVAudioPlayer *audioPlayer;
    AVAudioPlayer *effectSound;
}
@property (weak, nonatomic) IBOutlet UIImageView *control;
@property (weak, nonatomic) IBOutlet UIImageView *plane;
@property (weak, nonatomic) IBOutlet UILabel *L_time;
@property (weak, nonatomic) IBOutlet UIButton *B_pause;
@property (weak, nonatomic) IBOutlet UIImageView *gameOver_Menu;
@property (weak, nonatomic) IBOutlet UIImageView *pause_Menu;
@property (weak, nonatomic) IBOutlet UIButton *B_resume;
@property (weak, nonatomic) IBOutlet UIButton *B_home;
@property (weak, nonatomic) IBOutlet UIButton *B_restart;
@property (weak, nonatomic) IBOutlet UILabel *L_score;
@property (weak, nonatomic) IBOutlet UILabel *L_sec;
@property (weak, nonatomic) IBOutlet UILabel *L_hightest;
@property (weak, nonatomic) IBOutlet UIImageView *bomb;
@property (weak, nonatomic) IBOutlet UIImageView *explosion;


-(void) moveObject;
-(void)gameInit;
@end
