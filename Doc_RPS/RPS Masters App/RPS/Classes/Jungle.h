//
//  Jungle.h
//  RPS
//
//  Created by chibitotoro on 12-05-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Stage.h"
#import "Gull.h"

@interface Jungle : Stage{
    CCSprite * jungle;
    CCAction * jungleAction;
    
    CCSpriteBatchNode * jungleSpriteSheet;
    CCAnimation *jungleAnimation;
    
    Gull * gull1;
    Gull * gull2;
}

@property (nonatomic,assign) Gull * gull1;
@property (nonatomic,assign) Gull * gull2;
@property (nonatomic, assign) CCSprite * jungle;
@property (nonatomic, assign) CCSpriteBatchNode * jungleSpriteSheet;

-(void) pause;
-(void) resume;


@end
