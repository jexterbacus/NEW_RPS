//
//  Robot.m
//  RPS
//
//  Created by chibitotoro on 12-04-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Robot.h"

@implementation Robot

-(id) init{    
    if((self=[super init])){
        CCDirector *director = [CCDirector sharedDirector];
        
        name=@"Super Ultrabot";
        winLine=@"There are 10 types of people in this world. Those who understand binary, and losers.";
        NSString * suffix=@"";
        
        sprAvatar=[[CCSprite spriteWithFile:@"robot-avatar.png"]retain];
        
        winEffect=@"RobotWin.mp3";
        sprWin=[[CCSprite spriteWithFile:@"robot-win-large.png"]retain];
        sprVSAvatar=[[CCSprite spriteWithFile:@"versus-robot-avatar.png"]retain];
        
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        // sprite sheet load ========================
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"robot%@.plist",suffix]];
        
        ssCharacter = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"robot%@.png",suffix]]retain];
        
        
        //idle animation ========================
        
        for(int i = 1; i <= 6; ++i) {
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"robot-idle%d%@.png", i,suffix]]];
        }
        aniIdle = [[CCAnimation animationWithFrames:anfIdle delay:1.f/6.f] retain];
        actIdle=[[CCRepeatForever actionWithAction:
                 [CCAnimate actionWithAnimation:aniIdle restoreOriginalFrame:NO]] retain];
        [anfIdle removeAllObjects];
        
        //jyankenpon animation ====================
        for(int i = 1; i <= 5; ++i) {
            [anfJyankenpon addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"robot-prep%d%@.png", i,suffix]]];
        }
        
        aniJyankenpon=[[CCAnimation animationWithFrames:anfJyankenpon delay:1.f/2.f] retain];
        actJyankenpon=[[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniJyankenpon restoreOriginalFrame:NO]] retain];
        [anfJyankenpon removeAllObjects];
        
        //rock animation ====================
        
        for(int i = 1; i <= 3; ++i) {
            [anfRock addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"robot-rock%d%@.png", i,suffix]]];
        }
        
        aniRock=[[CCAnimation animationWithFrames:anfRock delay:1.f/6.f]retain];
        actRock=[[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniRock restoreOriginalFrame:NO]]retain];
        
        [anfRock removeAllObjects];
        
        //paper animation ====================
        for(int i = 1; i <= 3; ++i) {
            [anfPaper addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"robot-paper%d%@.png", i,suffix]]];
        }
        
        aniPaper=[[CCAnimation animationWithFrames:anfPaper delay:1.f/6.f]retain];
        actPaper=[[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniPaper restoreOriginalFrame:NO]]retain];
        
        [anfPaper removeAllObjects];
        
        
        //scissors animation ====================

        for(int i = 1; i <= 3; ++i) {
            [anfScissors addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"robot-scissors%d%@.png", i,suffix]]];
        }

        
        aniScissors=[[CCAnimation animationWithFrames:anfScissors delay:1.f/6.f]retain];
        actScissors=[[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniScissors restoreOriginalFrame:NO]]retain];
        
        [anfScissors removeAllObjects];
        
        //round win animation ====================
        for(int i = 1; i <= 5; ++i) {
            [anfRoundWin addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"robot-round-win%d%@.png", i,suffix]]];
        }
        
        aniRoundWin=[[CCAnimation animationWithFrames:anfRoundWin delay:1.f/12.f]retain];
        actRoundWin=[[CCRepeatForever actionWithAction:
                     [CCAnimate actionWithAnimation:aniRoundWin restoreOriginalFrame:NO]]retain];
        
        [anfRoundWin removeAllObjects];
        
        //round lose animation ====================
        for(int i=1;i<=5;i++){
            [anfRoundLose addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"robot-round-lose%d%@.png",i,suffix]]];
        }
        
        aniRoundLose=[[CCAnimation animationWithFrames:anfRoundLose delay:1.f/12.f]retain];
        actRoundLose=[[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniRoundLose restoreOriginalFrame:NO]] retain];
        
        [anfRoundLose removeAllObjects];
        
        //match lose animation ====================
        
        for(int i=1;i<=5;i++){
            [anfMatchLose addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"robot-match-lose%d%@.png",i,suffix]]];
        }

        aniMatchLose=[[CCAnimation animationWithFrames:anfMatchLose delay:1.f/12.f]retain];
        actMatchLose=[[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniMatchLose restoreOriginalFrame:NO]]retain];
        
        [anfMatchLose removeAllObjects];
        
        //fall animation ====================
        
        for(int i=1;i<=3;i++){
            [anfFall addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"robot-fall%d%@.png",i,suffix]]];
        }
        
        aniFall=[[CCAnimation animationWithFrames:anfFall delay:1.f/12.f]retain];
        actFall=[[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniFall restoreOriginalFrame:NO]]retain];
        
        [anfFall removeAllObjects];
        
        
        //character defaults ==========================
        sprCharacter=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"robot-idle1%@.png",suffix]]retain];
        
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
