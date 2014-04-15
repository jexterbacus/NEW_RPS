//
//  SlotLeft.m
//  RPS
//
//  Created by chibitotoro on 12-05-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SlotLeft.h"

@implementation SlotLeft
-(id) init{    
    if((self=[super init])){
        CCDirector *director = [CCDirector sharedDirector];
        
        name=@"Slot Left";
        winLine=@"";
        NSString * suffix=@"";
        
        
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        // sprite sheet load ========================
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"left-slot%@.plist",suffix]];
        
        ssCharacter = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"left-slot%@.png",suffix]]retain];
        
        //idle animation ========================
        
        for(int i=1;i<=3;i++){
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"left-slot%d%@.png",i,suffix]]];
        }
        
        aniIdle = [[CCAnimation animationWithFrames:anfIdle delay:1.f/6.f]retain];
        actIdle=[[CCRepeatForever actionWithAction:
                  [CCAnimate actionWithAnimation:aniIdle restoreOriginalFrame:NO]]retain];
        
        [anfIdle removeAllObjects];
        
        //character defaults ==========================
        sprCharacter=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"left-slot1%@.png",suffix]]retain];
        
        [self idle];
        
        sprCharacter.position=ccp(240,240);
        [ssCharacter addChild:sprCharacter];
    }
    return self;
    
}
@end
