//
//  Bullets.m
//  FinalProject
//
//  Created by Oscar on 3/16/14.
//  Copyright (c) 2014 Oscar. All rights reserved.
//

#import "Bullets.h"

@implementation Bullets

- (Bullets *) init
{
    bullet = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"bullet.png"]]];
    bullet.frame = CGRectMake(320, 380, 10, 10);
    bullet.center = CGPointMake(325, 385);
    dir_x = -1.0;
    dir_y = -1.0;
    return self;
}


-(UIImageView *) getPic
{
    return bullet;
}

-(CGPoint) getPosition
{
    return CGPointMake(bullet.center.x, bullet.center.y);
}

-(void) resetPosition
{
    bullet.center = CGPointMake(325, 385);
    dir_x = -1.0;
    dir_y = -1.0;
}

-(bool) checkGameOver: (CGPoint) p
{
    float x = abs(bullet.center.x - p.x);
    float y = abs(bullet.center.y - p.y);
    float r = sqrt(pow(x, 2.0) + pow(y, 2.0));
    if(r < 17)
    {
        return true;
    }
    else
    {
        return false;
    }
    
}

-(void) removebullet: (CGPoint) p
{
    float x = abs(bullet.center.x - p.x);
    float y = abs(bullet.center.y - p.y);
    float r = sqrt(pow(x, 2.0) + pow(y, 2.0));
    if(r < 60)
    {
        bullet.center = CGPointMake(325, 385);
    }
}

-(void) movebullet: (CGPoint) p time: (int) timeCount
{
    //if(bullet.center.x == 325 && bullet.center.y == 385)
   
    int speed = 8;
    
    if(timeCount > 20)
    {
        speed = 3;
    }
    else if(timeCount > 10)
    {
        speed = 5;
    }
    else if(timeCount > 5)
    {
        speed = 7;
    }
   
    [UIImageView animateWithDuration:0.1 animations:^(){
        if(bullet.center.x >=325 || bullet.center.x <= -5 || bullet.center.y <= 15 || bullet.center.y>=385)
        {
            float x, y;
            NSInteger d = arc4random()%4 + 1;
            if(d == 1)
            {
                x = 325;
                y = arc4random()% 360 + 20;
                dir_x = -1;
                dir_y = arc4random()% 3 - 1;
            }
            else if(d == 2)
            {
                x = arc4random()% 320;
                y = 385;
                dir_x = arc4random()% 3 - 1;
                dir_y = -1;
            }
            else if(d == 3)
            {
                x = -5;
                y = arc4random()% 360 + 20;
                dir_x = 1;
                dir_y = arc4random()% 3 - 1;
            }
            else
            {
                x = arc4random()% 320;
                y = 15;
                dir_x = arc4random()% 3 - 1;
                dir_y = 1;
            }
            
            bullet.center = CGPointMake(x, y);
            bullet.hidden = NO;
            dir_x = (p.x - bullet.center.x) / 200;
            dir_y = (p.y - bullet.center.y) / 200;
        }
        
        bullet.center = CGPointMake(bullet.center.x + (dir_x / speed) , bullet.center.y + (dir_y / speed));

    }];
}

@end
