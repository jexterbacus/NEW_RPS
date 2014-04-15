//
//  SlotRight.m
//  RPS
//
//  Created by chibitotoro on 12-05-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SlotRight.h"

@implementation SlotRight
-(id) init{    
    if((self=[super init])){
        CCDirector *director = [CCDirector sharedDirector];
        
        name=@"Slot Right";
        winLine=@"";
        NSString * suffix=@"";
        
        
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        // sprite sheet load ========================
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"right-slot%@.plist",suffix]];
        
        ssCharacter = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"right-slot%@.png",suffix]]retain];
        
        //idle animation ========================
        
        for(int i=1;i<=3;i++){
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"right-slot%d%@.png",i,suffix]]];
        }
        
        aniIdle = [[CCAnimation animationWithFrames:anfIdle delay:1.f/12.f]retain];
        actIdle=[[CCRepeatForever actionWithAction:
                  [CCAnimate actionWithAnimation:aniIdle restoreOriginalFrame:NO]]retain];
        
        [anfIdle removeAllObjects];
        

        [anfRoundWin addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"right-slot4%@.png",suffix]]];
        
        aniRoundWin = [[CCAnimation animationWithFrames:anfRoundWin delay:1.f/12.f]retain];
        actRoundWin=[[CCRepeatForever actionWithAction:
                  [CCAnimate actionWithAnimation:aniRoundWin restoreOriginalFrame:NO]]retain];
        
        [anfRoundWin removeAllObjects];
        
        [anfRoundLose addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"right-slot5%@.png",suffix]]];
        
        aniRoundLose = [[CCAnimation animationWithFrames:anfRoundLose delay:1.f/12.f]retain];
        actRoundLose=[[CCRepeatForever actionWithAction:
                      [CCAnimate actionWithAnimation:aniRoundLose restoreOriginalFrame:NO]]retain];
        
        [anfRoundLose removeAllObjects];
        
        for(int i=0;i<6;i++){
            [anfMatchLose addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"right-slot%d%@.png",(i%3)+1,suffix]]];
        }
        [anfMatchLose addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"right-slot7%@.png",suffix]]];
        
        aniMatchLose = [[CCAnimation animationWithFrames:anfMatchLose delay:1.f/12.f]retain];
        actMatchLose=[[CCAnimate actionWithAnimation:aniMatchLose restoreOriginalFrame:NO]retain];
        
        [anfMatchLose removeAllObjects];
        
        //character defaults ==========================
        sprCharacter=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"right-slot1%@.png",suffix]]retain];
        
        [self idle];
        
        sprCharacter.position=ccp(240,240);
        [ssCharacter addChild:sprCharacter];
    }
    return self;
    
}

@end
