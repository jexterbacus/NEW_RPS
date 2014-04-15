//
//  Grandma.m
//  RPS
//
//  Created by chibitotoro on 12-06-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Grandma.h"

@implementation Grandma
-(id) init{    
    if((self=[super init])){
        CCDirector *director = [CCDirector sharedDirector];
        
        name=@"Grandma";
        winLine=@"";
        NSString * suffix=@"";
        
        
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        // sprite sheet load ========================
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"grandma%@.plist",suffix]];
        
        ssCharacter = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"grandma%@.png",suffix]]retain];
        
        //idle animation ========================
        
        for(int i=0;i<3;i++){
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"grandma-idle1%@.png",suffix]]];
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"grandma-idle2%@.png",suffix]]];
        }
        for(int i=0;i<2;i++){
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"grandma-idle3%@.png",suffix]]];
        }
        
        
        aniIdle = [[CCAnimation animationWithFrames:anfIdle delay:1.f/4.f]retain];
        actIdle=[[CCRepeatForever actionWithAction:
                  [CCAnimate actionWithAnimation:aniIdle restoreOriginalFrame:NO]]retain];
        
        [anfIdle removeAllObjects];
        
        //character defaults ==========================
        sprCharacter=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"grandma-idle1%@.png",suffix]]retain];
        
        [self idle];
        
        sprCharacter.position=ccp(240,240);
        [ssCharacter addChild:sprCharacter];
    }
    return self;
    
}
@end
