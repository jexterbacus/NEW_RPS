//
//  BusinessMan.m
//  RPS
//
//  Created by chibitotoro on 12-06-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusinessMan.h"

@implementation BusinessMan
-(id) init{    
    if((self=[super init])){
        CCDirector *director = [CCDirector sharedDirector];
        
        name=@"BusinessMan";
        winLine=@"";
        NSString * suffix=@"";
        
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        // sprite sheet load ========================
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"businessman%@.plist",suffix]];
        
        ssCharacter = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"businessman%@.png",suffix]]retain];
        
        //idle animation ========================
        [anfIdle addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"businessman-idle1%@.png",suffix]]];
        [anfIdle addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"businessman-idle2%@.png",suffix]]];

      
        
        
        aniIdle = [[CCAnimation animationWithFrames:anfIdle delay:1.f/4.f]retain];
        actIdle=[[CCRepeatForever actionWithAction:
                  [CCAnimate actionWithAnimation:aniIdle restoreOriginalFrame:NO]]retain];
        
        [anfIdle removeAllObjects];
        
        //character defaults ==========================
        sprCharacter=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"businessman-idle1%@.png",suffix]]retain];
        
        [self idle];
        
        sprCharacter.position=ccp(240,240);
        [ssCharacter addChild:sprCharacter];
    }
    return self;
    
}
@end
