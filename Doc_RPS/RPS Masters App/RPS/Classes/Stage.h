//
//  Stage.h
//  RPS
//
//  Created by chibitotoro on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
@interface Stage : NSObject{
    CCSprite * sprBackground;
    NSString * bgMusic;
    
    CCSprite * sprLeftLifeContainer;
    CCSprite * sprRightLifeContainer;
    CCSprite * sprKOBox;
    
    CCSprite * sprLeftLife;
    CCSprite * sprRightLife;
    
    CCSprite * sprLeftDPContainer;
    CCSprite * sprRightDPContainer;
    
    CCSprite * sprLeftAvatar;
    CCSprite * sprRightAvatar;
}

@property (nonatomic,assign) CCSprite * sprBackground;
@property (nonatomic,assign) CCSprite * sprLeftLifeContainer;
@property (nonatomic,assign) CCSprite * sprRightLifeContainer;
@property (nonatomic,assign) CCSprite * sprKOBox;

@property (nonatomic,assign) CCSprite * sprLeftDPContainer;
@property (nonatomic,assign) CCSprite * sprRightDPContainer;

@property (nonatomic,assign) CCSprite * sprLeftLife;
@property (nonatomic,assign) CCSprite * sprRightLife;

@property (nonatomic,assign) CCSprite * sprLeftAvatar;
@property (nonatomic,assign) CCSprite * sprRightAvatar;

-(void) pause;
-(void) resume;

//-(void) addAvatar:(CCLayer*)layer;
-(void) playBGM;
    
@end
