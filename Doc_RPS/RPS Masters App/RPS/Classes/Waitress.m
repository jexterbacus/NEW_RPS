//
//  Waitress.m
//  RPS
//
//  Created by chibitotoro on 12-05-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Waitress.h"

@implementation Waitress
-(id) init{    
    if((self=[super init])){
        CCDirector *director = [CCDirector sharedDirector];
        
        name=@"Waitress";
        winLine=@"";
        NSString * suffix=@"";
    
        
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        // sprite sheet load ========================
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"waitress%@.plist",suffix]];
        
        ssCharacter = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"waitress%@.png",suffix]]retain];
        
        
        //idle animation ========================
        
        anfCollectLeft=[[NSMutableArray alloc]init];
        anfCollectRight=[[NSMutableArray alloc]init];

        [anfCollectLeft addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"waitress12%@.png",suffix]]];
        
        [anfCollectRight addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"waitress11%@.png",suffix]]];

        aniCollectLeft = [[CCAnimation animationWithFrames:anfCollectLeft delay:1.f] retain];
        actCollectLeft=[[CCRepeatForever actionWithAction:
                 [CCAnimate actionWithAnimation:aniCollectLeft restoreOriginalFrame:NO]] retain];

        aniCollectRight = [[CCAnimation animationWithFrames:anfCollectRight delay:1.f] retain];
        actCollectRight=[[CCRepeatForever actionWithAction:
                        [CCAnimate actionWithAnimation:aniCollectRight restoreOriginalFrame:NO]]retain];
        
        [anfCollectLeft removeAllObjects];
        [anfCollectRight removeAllObjects];

        [anfCollectLeft release];
        [anfCollectRight release];
        
        //stay
        
        [self bobLeft];
        [self bobRight];
        
        aniIdle = [[CCAnimation animationWithFrames:anfIdle delay:1.f/12.f]retain];
        actIdle=[[CCRepeatForever actionWithAction:
                 [CCAnimate actionWithAnimation:aniIdle restoreOriginalFrame:NO]]retain];
        
        [anfIdle removeAllObjects];
        
        //character defaults ==========================
        sprCharacter=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"waitress1%@.png",suffix]]retain];
        
        [self idle];
        
        sprCharacter.position=ccp(240,160);
        [ssCharacter addChild:sprCharacter];
    }
    return self;
    
}
-(void) idle{
    [super idle];
    
}

-(void) collectLeft{
    [sprCharacter stopAllActions];
    [sprCharacter runAction:actCollectLeft];

}
-(void) collectRight{
    [sprCharacter stopAllActions];
    [sprCharacter runAction:actCollectRight];

}

-(void) bobLeft{
    CCDirector *director = [CCDirector sharedDirector];
    NSString * suffix=@"";
    
    if([director enableRetinaDisplay:YES] ){
        suffix=@"-hd";
    }

    
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress1%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress2%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress3%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress4%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress4%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress5%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress5%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress6%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress6%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress1%@.png",suffix]]];
}
-(void) bobRight{
    CCDirector *director = [CCDirector sharedDirector];
    NSString * suffix=@"";
    
    if([director enableRetinaDisplay:YES] ){
        suffix=@"-hd";
    } 
    
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress1%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress7%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress8%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress9%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress9%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress10%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress10%@.png",suffix]]];
    [anfIdle addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"waitress1%@.png",suffix]]];
}
-(void) addCharacterToLayer:(CCLayer*) layer atX:(float)x atY:(float)y isFlipped:(bool)flip{
    [super addCharacterToLayer:layer atX:x atY:y isFlipped:flip];
    
    
}

-(void) dealloc{
    [aniCollectLeft release];
    [aniCollectRight release];
    [actCollectLeft release];
    [actCollectRight release];

    [super dealloc];
}
@end
