//
//  Chef.m
//  RPS
//
//  Created by chibitotoro on 12-05-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Chef.h"

@implementation Chef
-(id) init{    
    if((self=[super init])){
        CCDirector *director = [CCDirector sharedDirector];
        
        name=@"Chef";
        winLine=@"";
        NSString * suffix=@"";
        
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        // sprite sheet load ========================
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"chef%@.plist",suffix]];
        
        ssCharacter = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"chef%@.png",suffix]]retain];
        
        
        //idle animation ========================
        
        //stay
        for(int i = 1; i <= 7; i++) {
            
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"chef1%@.png",suffix]]];
        }
        //duck
        for(int i = 1; i <= 4; i++) {
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"chef2%@.png",suffix]]];
        }
        //blink
        [anfIdle addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"chef3%@.png",suffix]]];
        //duck
        for(int i = 1; i <= 2; i++) {
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"chef2%@.png",suffix]]];
        }
        
        //turned
        for(int i = 1; i <= 7; i++) {
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"chef4%@.png",suffix]]];
        } 
        
        //turned duck
        for(int i = 1; i <= 7; i++) {
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"chef5%@.png",suffix]]];
        }  
        
        //laugh
        [anfIdle addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"chef6%@.png",suffix]]];

        [anfIdle addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"chef7%@.png",suffix]]];

        [anfIdle addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"chef8%@.png",suffix]]];
        
        [anfIdle addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"chef7%@.png",suffix]]];
        
        [anfIdle addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"chef8%@.png",suffix]]];
        
        [anfIdle addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"chef7%@.png",suffix]]];
        
        [anfIdle addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"chef8%@.png",suffix]]];
        
        [anfIdle addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"chef7%@.png",suffix]]];
        
        [anfIdle addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"chef6%@.png",suffix]]];

        
        aniIdle = [[CCAnimation animationWithFrames:anfIdle delay:1.f/12.f] retain];
        actIdle=[[CCRepeatForever actionWithAction:
                 [CCAnimate actionWithAnimation:aniIdle restoreOriginalFrame:NO]] retain];
        
        [anfIdle removeAllObjects];
        
        //character defaults ==========================
        sprCharacter=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"chef1%@.png",suffix]]retain];
        
        [self idle];
        
        sprCharacter.position=ccp(240,160);
        [ssCharacter addChild:sprCharacter];
    }
    return self;
    
}
-(void) idle{
    [super idle];
    
}
-(void) dealloc{

    [super dealloc];
}

-(void) addCharacterToLayer:(CCLayer*) layer atX:(float)x atY:(float)y isFlipped:(bool)flip{
    [super addCharacterToLayer:layer atX:x atY:y isFlipped:flip];
    
    
}
@end
