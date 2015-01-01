//
//  ViewController.m
//  FinalProject
//
//  Created by Oscar on 3/13/14.
//  Copyright (c) 2014 Oscar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/bg.wav",[[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = 1000;
    audioPlayer.volume = 0.25;
    [audioPlayer play];
    
    NSURL *url2 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/explosion.mp3",[[NSBundle mainBundle] resourcePath]]];
    NSError *error2;
    effectSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:&error2];
    //effectSound.numberOfLoops = 1;
    effectSound.volume = 0.5;
    
    
    bulletarray = [[NSMutableArray alloc] init];
    [self gameInit];
    [self makeBullet];  //init all bullet UIImage and put in to array
    
    moveObjectTimer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(moveObject) userInfo:nil repeats:YES];
    countSec = [NSTimer scheduledTimerWithTimeInterval:(1.0/1.0) target:self selector:@selector(countTheTime) userInfo:nil repeats:YES];

    
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)gameInit
{
    gameover = false;
    pause = false;
    checkExplosion = false;
    isExplosion = false;
    haveBomb = false;
    
    timeCount = 0;
    
    [_gameOver_Menu setHidden:YES];
    [_pause_Menu setHidden:YES];
    [_B_resume setHidden:YES];
    [_B_home setHidden:YES];
    [_B_restart setHidden:YES];
    [_L_sec setHidden:YES];
    [_L_score setHidden:YES];
    [_L_hightest setHidden:YES];
    [_bomb setHidden:YES];
    [_explosion setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)makeBullet
{
    for(int i=0; i<30; ++i)
    {
        Bullets *tmp;
        tmp = [Bullets alloc];
        tmp = [tmp init];
        [self.view insertSubview:[tmp getPic] atIndex:2];
        [bulletarray addObject:tmp];
    }
}

-(void)countTheTime
{
    if(gameover == false && pause == false)
    {
        timeCount +=1;
        _L_time.text = [NSString stringWithFormat:@"%d",timeCount];
    }
}

- (IBAction)gamePause:(id)sender
{
    if(gameover == false )
    {
        pause = true;

        [_pause_Menu setHidden:NO];
        [_B_resume setHidden:NO];
        [_B_home setHidden:NO];
        [_B_restart setHidden:NO];
        [_B_pause setEnabled:NO];
    }
}

- (IBAction)gameRestart:(id)sender
{
    [self gameInit];
    [_B_pause setEnabled:YES];
    for(Bullets *tmp in [bulletarray subarrayWithRange:NSMakeRange(0, 30)])
    {
        [tmp resetPosition];
    }
}

- (IBAction)toHome:(id)sender
{
    [audioPlayer stop];
}

- (IBAction)gameResume:(id)sender
{
    pause = false;
    
    [_pause_Menu setHidden:YES];
    [_B_resume setHidden:YES];
    [_B_home setHidden:YES];
    [_B_restart setHidden:YES];
    [_B_pause setEnabled:YES];
}



- (void)gameOver
{
    gameover = true;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //NSString *myListPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSString *myListPath =[path stringByAppendingPathComponent:@"/data.plist"];
    NSMutableArray * dataArray = [[NSMutableArray alloc]initWithContentsOfFile:myListPath];
    NSInteger score = [[dataArray objectAtIndex:0] integerValue];
   
    if(timeCount > score)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *appSettingsPath = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
        
        NSMutableArray * newData =[[NSMutableArray alloc] init];
        [newData insertObject:[NSString stringWithFormat:@"%i", timeCount] atIndex:0];
        
        [newData writeToFile:appSettingsPath atomically:YES];
        [_L_hightest setHidden:NO];
    }
    
    _L_score.text = [NSString stringWithFormat:@"%i",timeCount];

    [_gameOver_Menu setHidden:NO];
    [_B_home setHidden:NO];
    [_B_restart setHidden:NO];
    [_L_sec setHidden:NO];
    [_L_score setHidden:NO];
}

-(void)moveObject
{
    int i = 5;
    int speed = 100;
    
    if(timeCount > 40)
    {
        i = 30;
        speed = 60;
    }
    if(timeCount > 30)
    {
        i = 20;
        speed = 70;
    }
    else if(timeCount > 20)
    {
        i = 15;
        speed = 80;
    }
    else if(timeCount > 10)
    {
        i = 10;
        speed = 90;
    }
    
    if(gameover == false && pause == false)
    {
        if(timeCount > 0 && (timeCount % 10) == 0 && haveBomb == false)
        {

            float x = arc4random()% 260 + 40;
            float y = arc4random()% 280 + 60;
            
            _bomb.center = CGPointMake(x, y);
            [_bomb setHidden:NO];
            checkExplosion = true;
            haveBomb = true;
            
        }
        
        if(checkExplosion == true)
        {
            float bomb_x = abs(_bomb.center.x - _plane.center.x);
            float bomb_y = abs(_bomb.center.y - _plane.center.y);
            float bomb_r = sqrt(pow(bomb_x, 2.0) + pow(bomb_y, 2.0));
            if(bomb_r < 25)
            {
                checkExplosion = false;
                isExplosion = true;
                _explosion.alpha = 1;
                _explosion.center = CGPointMake(_bomb.center.x, _bomb.center.y);
                [_explosion setHidden:NO];
                [effectSound play];
                [_bomb setHidden:YES];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5];
                _explosion.alpha = 0;
                [UIView commitAnimations];
            }
        }
    
        for(Bullets *tmp in [bulletarray subarrayWithRange:NSMakeRange(0, i)])
        {
            if(isExplosion == true)
            {
                [tmp removebullet:CGPointMake(_explosion.center.x, _explosion.center.y)];
            }
            
            [tmp movebullet:CGPointMake(_plane.center.x, _plane.center.y) time:timeCount];
        }
        
        if(isExplosion ==true)
        {
            isExplosion = false;
            haveBomb = false;
        }
        
        if(_control.center.x != 160 &&_control.center.y != 430)
        {
            if(_plane.center.x > 24 && _plane.center.x < 296 && _plane.center.y > 44 && _plane.center.y < 356)
            {
                if(_control.center.x > 160 && _control.center.y > 430)
                {
                    _plane.center = CGPointMake(_plane.center.x + ((_control.center.x -160)/ speed), _plane.center.y + ((_control.center.y - 430) / speed));
                }
                else if(_control.center.x > 160 && _control.center.y < 430)
                {
                    _plane.center = CGPointMake(_plane.center.x + ((_control.center.x -160)/ speed), _plane.center.y - ((430 - _control.center.y) / speed));
                }
                else if(_control.center.x < 160 && _control.center.y < 430)
                {
                    _plane.center = CGPointMake(_plane.center.x - ((160 -_control.center.x) / speed), _plane.center.y - ((430 - _control.center.y) / speed));
                }
                else if(_control.center.x < 160 && _control.center.y > 430)
                {
                    _plane.center = CGPointMake(_plane.center.x - ((160 - _control.center.x) / speed), _plane.center.y + ((_control.center.y - 430) / speed));
                }
            }
            
            if(_plane.center.x < 25)
                _plane.center = CGPointMake(25, _plane.center.y);
            if(_plane.center.x > 295)
                _plane.center = CGPointMake(295, _plane.center.y);
            if(_plane.center.y < 45)
                _plane.center = CGPointMake(_plane.center.x, 45);
            if(_plane.center.y > 355)
                _plane.center = CGPointMake(_plane.center.x, 355);
        }
        
    }
    
    
    for(Bullets *tmp in [bulletarray subarrayWithRange:NSMakeRange(0, i)])
    {
        if([tmp checkGameOver:CGPointMake(_plane.center.x, _plane.center.y)])
        {
            [self gameOver];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(gameover == false && pause == false)
    {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:self.view];
        
        float x = abs(location.x - 160);
        float y = abs(location.y - 430);
        float r = sqrt(pow(x, 2.0) + pow(y, 2.0));
        if(r <= 25)
        {
            _control.center = CGPointMake(location.x, location.y);
        }
        else
        {
            float new_x = 25/r * x ;
            float new_y = 25/r * y ;
            if(location.x < 160)
                new_x = new_x * (-1);
            if(location.y < 430)
                new_y = new_y * (-1);
            
           _control.center = CGPointMake(160 + new_x, 430 + new_y);
        }
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _control.center = CGPointMake(160, 430);
}


@end
