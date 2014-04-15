//
//  Boy.m
//  RPS
//
//  Created by chibitotoro on 12-04-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Boy.h"

@implementation Boy


-(id) init{    
    if((self=[super init])){
        CCDirector *director = [CCDirector sharedDirector];
        
        name=@"Charlie";
        winLine=@"Winning is a habit. So is losing.";
        NSString * suffix=@"";
        
        winEffect=@"BoyWin.mp3";
        sprWin=[[CCSprite spriteWithFile:@"boy-win-large.png"]retain];
        sprAvatar=[[CCSprite spriteWithFile:@"boy-avatar.png"]retain];
        sprVSAvatar=[[CCSprite spriteWithFile:@"versus-boy-avatar.png"]retain];
        
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        // sprite sheet load ========================
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"boy%@.plist",suffix]];
        
        ssCharacter = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"boy%@.png",suffix]]retain];
        
        
        //idle animation ========================
        
        for(int i = 1; i <= 7; ++i) {
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"boy-idle%d%@.png", i,suffix]]];
        }
        aniIdle = [[CCAnimation animationWithFrames:anfIdle delay:1.f/6.f]retain];
        actIdle=[CCRepeatForever actionWithAction:
                 [CCAnimate actionWithAnimation:aniIdle restoreOriginalFrame:NO]];
        
        [actIdle retain];
        [anfIdle removeAllObjects];
        
        //jyankenpon animation ====================
        for(int i = 1; i <= 5; ++i) {
            [anfJyankenpon addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"boy-prep%d%@.png", i,suffix]]];
        }
        
        aniJyankenpon=[[CCAnimation animationWithFrames:anfJyankenpon delay:1.f/2.f]retain];
        actJyankenpon=[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniJyankenpon restoreOriginalFrame:NO]];
        
        [actJyankenpon retain];
        [anfJyankenpon removeAllObjects];
        //rock animation ====================
        
        [anfRock addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"boy-rock%@.png",suffix]]];
        
        aniRock=[[CCAnimation animationWithFrames:anfRock delay:1.f/6.f]retain];
        actRock=[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniRock restoreOriginalFrame:NO]];
        
        [actRock retain];
        [anfRock removeAllObjects];
        
        //paper animation ====================
        [anfPaper addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"boy-paper%@.png",suffix]]];
        
        aniPaper=[[CCAnimation animationWithFrames:anfPaper delay:1.f/6.f]retain];
        actPaper=[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniPaper restoreOriginalFrame:NO]];
        
        [actPaper retain];
        [anfPaper removeAllObjects];
        
        //scissors animation ====================

        [anfScissors addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"boy-scissors%@.png", suffix]]];
        
        
        aniScissors=[[CCAnimation animationWithFrames:anfScissors delay:1.f/6.f]retain];
        actScissors=[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniScissors restoreOriginalFrame:NO]];
        
        [actScissors retain];
        [anfScissors removeAllObjects];
        
        //round win animation ====================
        for(int i = 1; i <= 2; ++i) {
            [anfRoundWin addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"boy-round-win%d%@.png", i,suffix]]];
        }
        
        aniRoundWin=[[CCAnimation animationWithFrames:anfRoundWin delay:1.f/12.f]retain];
        actRoundWin=[CCAnimate actionWithAnimation:aniRoundWin restoreOriginalFrame:NO];
        
        [actRoundWin retain];
        [anfRoundWin removeAllObjects];
        
        //round lose animation ====================
        for(int i=1;i<=2;i++){
            [anfRoundLose addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"boy-round-lose%d%@.png",i,suffix]]];
        }
        
        aniRoundLose=[[CCAnimation animationWithFrames:anfRoundLose delay:1.f/12.f]retain];
        actRoundLose=[CCAnimate actionWithAnimation:aniRoundLose restoreOriginalFrame:NO];
        
        [actRoundLose retain];
        [anfRoundLose removeAllObjects];
        
        //match lose animation ====================
        
        for(int i=1;i<=2;i++){
            [anfMatchLose addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"boy-match-lose%d%@.png",i,suffix]]];
        }
        
        aniMatchLose=[[CCAnimation animationWithFrames:anfMatchLose delay:1.f/12.f]retain];
        actMatchLose=[CCAnimate actionWithAnimation:aniMatchLose restoreOriginalFrame:NO];
        
        [actMatchLose retain];
        [anfMatchLose removeAllObjects];
        
        //fall animation ====================
        
        [anfFall addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"boy-fall%@.png",suffix]]];
        
        aniFall=[[CCAnimation animationWithFrames:anfFall delay:1.f/12.f]retain];
        actFall=[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniFall restoreOriginalFrame:NO]];
        
        [actFall retain];
        [anfFall removeAllObjects];
        
        
        //character defaults ==========================
        sprCharacter=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"boy-idle1%@.png",suffix]]retain];
        
        [self idle];
        
        sprCharacter.position=ccp(240,160);
        [ssCharacter addChild:sprCharacter];
        
        [anfIdle release];
        [anfJyankenpon release];
        [anfRoundWin release];            //win animation frames
        [anfRoundLose release];           //lose animation frames
        [anfFall release];                //falling animation frames
        [anfMatchLose release];           //lose animation frames
        [anfRock release];                //rock animation frames
        [anfPaper release];               //paper animation frames
        [anfScissors release];            //scissors animation frames
    }
    return self;
    
}
-(void) idle{
    [super idle];
    
}
-(void) jyankenpon{
    [super jyankenpon];
    
}
-(void) roundWin{
    [super roundWin];
}
-(void) roundLose{
    [super roundLose];
}
-(void) fall{
    [super fall];
}
-(void) matchLose{
    [super matchLose];
    
}
-(void) rock{
    [super rock];
}
-(void) paper{
    [super paper];
}
-(void) scissors{
    [super scissors];
}

-(void) flipX{
    [super flipX];
}

-(void) addCharacterToLayer:(CCLayer*) layer atX:(float)x atY:(float)y isFlipped:(bool)flip{
    [super addCharacterToLayer:layer atX:x atY:y isFlipped:flip];
    
    
}
@end

