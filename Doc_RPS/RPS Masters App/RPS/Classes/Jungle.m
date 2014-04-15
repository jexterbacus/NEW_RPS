//
//  Jungle.m
//  RPS
//
//  Created by chibitotoro on 12-05-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Jungle.h"

@implementation Jungle

@synthesize jungle,jungleSpriteSheet;
@synthesize gull1,gull2;

-(id)init{
    if((self=[super init])){
        sprBackground=[[CCSprite spriteWithFile: @"sky-bg.png"] retain];
        sprBackground.position=ccp(335,220);
        bgMusic=@"Jungle.mp3";
        
        CCDirector *director = [CCDirector sharedDirector];
        
        NSMutableArray *animationFrames = [[NSMutableArray alloc]init];        //fan animation frames
        NSString * suffix=@"";
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"jungle%@.plist",suffix]];
        
        jungleSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"jungle%@.png",suffix]];
        
        
        for(int i = 1; i <= 4; ++i) {
            [animationFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"jungle%d%@.png", i,suffix]]];
        }
        
        jungle=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"jungle1%@.png",suffix]] retain];
        
        
        //non retina info
        jungle.position=ccp(240,160);
        jungleAnimation = [[CCAnimation 
                        animationWithFrames:animationFrames delay:1.f/6.f] retain];
        
        jungleAction=[[CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:jungleAnimation restoreOriginalFrame:NO]]retain];
        [jungle runAction:jungleAction];
        [jungleSpriteSheet addChild:jungle];
        
        [animationFrames removeAllObjects];
        [animationFrames release];
        
        gull1=[[Gull alloc]init];
        gull1.sprCharacter.position=ccp(245,225);
        
        gull2=[[Gull alloc]init];
        gull2.sprCharacter.position=ccp(290,250);

    }
    return self;
}
-(void) pause{
    [super pause];
    //[[ActionManager sharedManager] pauseAllActionsForTarget:fan];
}
-(void) resume{
    [super resume];
}
-(void) dealloc{
    [gull1 release];
    [gull2 release];
    [jungle release];
    [jungleAnimation release];
    [jungleAction release];
    [super dealloc];
}
@end