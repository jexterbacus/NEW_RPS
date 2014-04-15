//
//  CasinoRoof.m
//  RPS
//
//  Created by chibitotoro on 12-05-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CasinoRoof.h"

@implementation CasinoRoof
-(id) init{    
    if((self=[super init])){
        CCDirector *director = [CCDirector sharedDirector];
        
        name=@"Roof";
        winLine=@"";
        NSString * suffix=@"";
        
        
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        // sprite sheet load ========================
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"casino-roof%@.plist",suffix]];
        
        ssCharacter = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"casino-roof%@.png",suffix]]retain];
        
        //idle animation ========================
        
        for(int i=1;i<=3;i++){
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"casino-top%d%@.png",i,suffix]]];
        }
        
        aniIdle = [[CCAnimation animationWithFrames:anfIdle delay:5.f/12.f]retain];
        actIdle=[[CCRepeatForever actionWithAction:
                  [CCAnimate actionWithAnimation:aniIdle restoreOriginalFrame:NO]]retain];
        
        [anfIdle removeAllObjects];
        
        //character defaults ==========================
        sprCharacter=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"casino-top1%@.png",suffix]]retain];
        
        [self idle];
        
        sprCharacter.position=ccp(240,240);
        [ssCharacter addChild:sprCharacter];
    }
    return self;
    
}
-(void) idle{
    [super idle];
}

-(void) addCharacterToLayer:(CCLayer*) layer atX:(float)x atY:(float)y isFlipped:(bool)flip{
    [super addCharacterToLayer:layer atX:x atY:y isFlipped:flip];
    
    
}

-(void) dealloc{

    
    [super dealloc];
}

@end
