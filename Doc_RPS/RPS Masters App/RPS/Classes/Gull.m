//
//  Gull.m
//  RPS
//
//  Created by chibitotoro on 12-05-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Gull.h"

@implementation Gull
-(id) init{    
    if((self=[super init])){
        CCDirector *director = [CCDirector sharedDirector];
        
        name=@"Gull";
        winLine=@"";
        NSString * suffix=@"";
        
        
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        // sprite sheet load ========================
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"gull%@.plist",suffix]];
        
        ssCharacter = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"gull%@.png",suffix]]retain];
        
        
        //idle animation ========================
        
        //stay
        for(int i=1;i<=4;i++){
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"gull%d%@.png",i,suffix]]];
        }
        aniIdle = [[CCAnimation animationWithFrames:anfIdle delay:1.f/(5.f+(arc4random()%3))]retain];
        actIdle=[[CCRepeatForever actionWithAction:
                 [CCAnimate actionWithAnimation:aniIdle restoreOriginalFrame:NO]] retain];

        [anfIdle removeAllObjects];
        
        //character defaults ==========================
        sprCharacter=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"gull1%@.png",suffix]]retain];
        
        [self idle];
        
        sprCharacter.position=ccp(240,160);
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
@end
