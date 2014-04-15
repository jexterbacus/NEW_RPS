//
//  Character.h
//  RPS
//
//  Created by chibitotoro on 12-04-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface Character : NSObject{
    NSString * name;
    NSString * winLine;
    NSString * winEffect;
    CCSprite * sprWin;
    CCSpriteBatchNode * ssCharacter;
    CCSprite * sprCharacter;
    CCSprite * sprAvatar;
    CCSprite * sprVSAvatar;
    CCSprite * sprUserAvatar;
    
    NSMutableArray *anfIdle;                //idle animation frames
    NSMutableArray *anfJyankenpon;          //jyankenpon animation frames
    NSMutableArray *anfRoundWin;            //win animation frames
    NSMutableArray *anfRoundLose;           //lose animation frames
    NSMutableArray *anfFall;                //falling animation frames
    NSMutableArray *anfMatchLose;           //lose animation frames
    NSMutableArray *anfRock;                //rock animation frames
    NSMutableArray *anfPaper;               //paper animation frames
    NSMutableArray *anfScissors;            //scissors animation frames
    
    CCAnimation * aniIdle;                  //animations
    CCAnimation * aniJyankenpon;
    CCAnimation * aniRoundWin;
    CCAnimation * aniRoundLose;
    CCAnimation * aniFall;
    CCAnimation * aniMatchLose;
    CCAnimation * aniRock;
    CCAnimation * aniPaper;
    CCAnimation * aniScissors;
    
    CCAction * actIdle;
    CCAction * actJyankenpon;
    CCAction * actRoundWin;
    CCAction * actRoundLose;
    CCAction * actFall;
    CCAction * actMatchLose;
    CCAction * actRock;
    CCAction * actPaper;
    CCAction * actScissors;
}

-(void) idle;
-(void) jyankenpon;
-(void) roundWin;
-(void) roundLose;
-(void) fall;
-(void) matchLose;
-(void) rock;
-(void) paper;
-(void) scissors;
-(void) flipX;
-(void) addCharacterToLayer:(CCLayer*) layer atX:(float)x atY:(float)y isFlipped:(bool)flip;

@property (nonatomic,assign) NSString * name;
@property (nonatomic,assign) NSString * winLine;
@property (nonatomic,assign) NSString * winEffect;
@property (nonatomic,assign) CCSprite * sprCharacter;
@property (nonatomic,assign) CCSprite * sprAvatar;
@property (nonatomic,assign) CCSprite * sprVSAvatar;
@property (nonatomic,assign) CCSprite * sprUserAvatar;
@property (nonatomic,assign) CCSprite * sprWin;
@property (nonatomic,assign) CCSpriteBatchNode * ssCharacter;
@end
