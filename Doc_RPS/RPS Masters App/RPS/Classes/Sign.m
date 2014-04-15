//
//  Sign.m
//  RPS
//
//  Created by chibitotoro on 12-05-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Sign.h"

@implementation Sign
-(id) init{    
    if((self=[super init])){
        CCDirector *director = [CCDirector sharedDirector];
        
        name=@"Sign";
        winLine=@"";
        NSString * suffix=@"";
        
        
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        // sprite sheet load ========================
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"lights%@.plist",suffix]];
        
        ssCharacter = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"lights%@.png",suffix]]retain];
        
        //idle animation ========================
        
        for(int i=1;i<=3;i++){
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"light-idle%d%@.png",i,suffix]]];
        }
        
        aniIdle = [[CCAnimation animationWithFrames:anfIdle delay:1.f/6.f]retain];
        actIdle=[[CCRepeatForever actionWithAction:
                  [CCAnimate actionWithAnimation:aniIdle restoreOriginalFrame:NO]]retain];
        
        [anfIdle removeAllObjects];
        
        for(int i=1;i<=2;i++){
            [anfRoundWin addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"light-winner%d%@.png",i,suffix]]];
        }
        
        aniRoundWin = [[CCAnimation animationWithFrames:anfRoundWin delay:1.f/6.f]retain];
        actRoundWin = [[CCRepeatForever actionWithAction:
                  [CCAnimate actionWithAnimation:aniRoundWin restoreOriginalFrame:NO]]retain];
        
        [anfRoundWin removeAllObjects];
        
        for(int i=1;i<=3;i++){
            [anfMatchLose addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"light-idle%d%@.png",i,suffix]]];
        }
        for(int i=1;i<=9;i++){
            [anfMatchLose addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"light-jackpot%d%@.png",(i%2)+1,suffix]]];
        }
        
        aniMatchLose = [[CCAnimation animationWithFrames:anfMatchLose delay:1.f/6.f]retain];
        actMatchLose = [[CCAnimate actionWithAnimation:aniMatchLose restoreOriginalFrame:NO]retain];
        
        [anfMatchLose removeAllObjects];
        
        //character defaults ==========================
        sprCharacter=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"light-idle1%@.png",suffix]]retain];
        
        [self idle];
        
        sprCharacter.position=ccp(188,218);
        [ssCharacter addChild:sprCharacter];
    }
    return self;
    
}

-(void) dealloc{
    
    
    [super dealloc];
}
@end
