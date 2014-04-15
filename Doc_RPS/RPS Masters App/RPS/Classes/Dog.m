//
//  Dog.m
//  RPS
//
//  Created by chibitotoro on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Dog.h"

@implementation Dog

-(id) init{    
    if((self=[super init])){
        CCDirector *director = [CCDirector sharedDirector];
        
        name=@"K9";
        winLine=@"If you wish to taste victory, lick my paw.";
        NSString * suffix=@"";
        
        winEffect=@"DogWin.mp3";
        sprWin=[[CCSprite spriteWithFile:@"dog-win-large.png"] retain];
        sprAvatar=[[CCSprite spriteWithFile:@"dog-avatar.png"] retain];
        sprVSAvatar=[[CCSprite spriteWithFile:@"versus-dog-avatar.png"] retain];
        
        if([director enableRetinaDisplay:YES] ){
            suffix=@"-hd";
        }
        
        // sprite sheet load ========================
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"dog%@.plist",suffix]];
        
        ssCharacter = [[CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"dog%@.png",suffix]]retain];
        
        
        //idle animation ========================
        
        for(int i = 1; i <= 4; ++i) {
            [anfIdle addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"dog-idle%d%@.png", i,suffix]]];
        }
        aniIdle = [[CCAnimation animationWithFrames:anfIdle delay:1.f/3.f]retain];
        actIdle=[CCRepeatForever actionWithAction:
                 [CCAnimate actionWithAnimation:aniIdle restoreOriginalFrame:NO]];
        
        [actIdle retain];
        
        [anfIdle removeAllObjects];
        
        //jyankenpon animation ====================
        [anfJyankenpon addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-prep%@.png",suffix]]];
        [anfJyankenpon addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-throw%@.png",suffix]]];
        [anfJyankenpon addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-prep%@.png",suffix]]];
        [anfJyankenpon addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-throw%@.png",suffix]]];
        [anfJyankenpon addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-prep%@.png",suffix]]];
        
        aniJyankenpon=[[CCAnimation animationWithFrames:anfJyankenpon delay:1.f/2.f]retain];
        //actJyankenpon=[CCAnimate actionWithAnimation:aniJyankenpon];
        actJyankenpon=[CCAnimate actionWithAnimation:aniJyankenpon restoreOriginalFrame:NO];
        
        [actJyankenpon retain];
        
        [anfJyankenpon removeAllObjects];
        
        //rock animation ====================
        
        [anfRock addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-throw%@.png",suffix]]];

        aniRock=[[CCAnimation animationWithFrames:anfRock delay:1.f/2.f]retain];
        actRock=[CCAnimate actionWithAnimation:aniRock restoreOriginalFrame:NO];
        
        [actRock retain];
        
        [anfRock removeAllObjects];
        //paper animation ====================
        [anfPaper addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-throw%@.png",suffix]]];
        
        aniPaper=[[CCAnimation animationWithFrames:anfPaper delay:1.f/2.f]retain];
        actPaper=[CCAnimate actionWithAnimation:aniPaper restoreOriginalFrame:NO];
        
        [actPaper retain];
        
        [anfPaper removeAllObjects];
        
        //scissors animation ====================
        [anfScissors addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-throw%@.png",suffix]]];

        aniScissors=[[CCAnimation animationWithFrames:anfScissors delay:1.f/2.f]retain];
        actScissors=[CCAnimate actionWithAnimation:aniScissors restoreOriginalFrame:NO];
        
        [actScissors retain];
        
        [anfScissors removeAllObjects];
        
        //round win animation ====================
        [anfRoundWin addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-chuckle1%@.png",suffix]]];
        [anfRoundWin addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-chuckle2%@.png",suffix]]];
        
        aniRoundWin=[[CCAnimation animationWithFrames:anfRoundWin delay:1.f/12.f]retain];
        actRoundWin=[CCRepeatForever actionWithAction:
                     [CCAnimate actionWithAnimation:aniRoundWin restoreOriginalFrame:NO]];
        
        [actRoundWin retain];
        [anfRoundWin removeAllObjects];
        
        //round lose animation ====================
        for(int i=1;i<=9;i++){
            [anfRoundLose addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"dog-round-lose%d%@.png",i,suffix]]];
        }
        
        aniRoundLose=[[CCAnimation animationWithFrames:anfRoundLose delay:1.f/12.f]retain];
        actRoundLose=[CCAnimate actionWithAnimation:aniRoundLose restoreOriginalFrame:NO];
        
        [actRoundLose retain];
        [anfRoundLose removeAllObjects];
        
        //match lose animation ====================
        
        [anfMatchLose addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-match-lose%@.png",suffix]]];
        
        aniMatchLose=[[CCAnimation animationWithFrames:anfMatchLose delay:1.f/12.f]retain];
        actMatchLose=[CCAnimate actionWithAnimation:aniMatchLose restoreOriginalFrame:NO];
        
        [actMatchLose retain];
        [anfMatchLose removeAllObjects];
        
        
        //fall animation ====================
        
        [anfFall addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-fall1%@.png",suffix]]];
        [anfFall addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"dog-fall2%@.png",suffix]]];
        
        aniFall=[[CCAnimation animationWithFrames:anfFall delay:1.f/12.f]retain];
        actFall=[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:aniFall restoreOriginalFrame:NO]];
        
        [actFall retain];
        [anfFall removeAllObjects];
        
        
        //character defaults ==========================
        sprCharacter=[[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"dog-idle1%@.png",suffix]]retain];
        
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
