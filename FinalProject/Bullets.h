//
//  Bullets.h
//  FinalProject
//
//  Created by Oscar on 3/16/14.
//  Copyright (c) 2014 Oscar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bullets : NSObject
{
    UIImageView *bullet;
    float dir_x , dir_y;
}

- (Bullets *) init;
-(UIImageView *) getPic;
-(CGPoint) getPosition;
-(void) movebullet : (CGPoint) p time: (int) timeCount;
-(bool) checkGameOver: (CGPoint) p;
-(void) removebullet: (CGPoint) p;
-(void) resetPosition;
@end
