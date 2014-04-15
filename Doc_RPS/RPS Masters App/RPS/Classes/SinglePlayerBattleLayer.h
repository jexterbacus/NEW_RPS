//
//  SinglePlayerBattleLayer.h
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "MainMenuLayer.h"
#import "SinglePlayerVersusLayer.h"
#import "WinGameLayer.h"
#import "GameOverLayer.h"
#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "Character.h"
#import "Dog.h"
#import "Robot.h"
#import "Boy.h"
#import "Snowman.h"
#import "Girl.h"
#import "AppDelegate.h"

@interface SinglePlayerBattleLayer : CCLayer <UIAlertViewDelegate>{
    CCLayer * baseLayer;                //background
    CCLayer * winLayer;                 //win game layer
    CCLayer * bubbleLayer;              //pause screen layer
    
    CCLabelTTF * lblTimer;              //timer label at top
    CCLabelTTF * lblColon;              //colon label at top
    CCLabelTTF * lblSubTimer;           //ms timer label at top
    CCLabelTTF * lblStatus;             //status label
    CCLabelTTF * lblGameOver;           //game over label
    CCLabelTTF * lblStage;              //stage label
    CCLabelTTF * lblBestOf;             //best of label
    CCLabelTTF * lblMusic;              //music label
    CCLabelTTF * lblSFX;                //sound effects label
    CCLabelTTF * lblPaused;             //paused label
    
    CCLabelTTF * lblLeftName;           //left player's name label
    CCLabelTTF * lblRightName;          //right player's name label
    CCLabelTTF * lblWinText;            //win blurb
    
    int winEffect;                      //reference to win sound effect
    
    
    CCSprite * sprOverlay;              //sprite for transparent black overlay
    CCSprite *leftHand;                 //user's sprite
    CCSprite *rightHand;                //opponent's sprite
    
    
    // Win Lose Tie Overlays -------------
    CCSprite * sprWin;                  //win sprite text  
    CCSprite * sprTie;                  //tie sprite text
    CCSprite * sprLose;                 //lose sprite text
    
    
    // In Game Buttons ----------------
    CCMenuItemImage * itmScissor;       //scissor button
    CCMenuItemImage * itmRock;          //rock button
    CCMenuItemImage * itmPaper;         //paper button
    CCMenuItemImage * itmPause;         //pause button
    
    
    
    // Pause Overlay ----------------
    CCMenuItemImage * itmReturn;        //return to main menu
    CCMenuItemImage * itmResume;        //resume match
    CCSprite * sprPauseBackground;      //paused background
    
    CCMenuItemImage * itmMusicOn;       //music on button
    CCMenuItemImage * itmMusicOff;      //music off button
    CCMenuItemImage * itmSFXOn;         //sfx on button
    CCMenuItemImage * itmSFXOff;        //sfx off button
    
    // Win Overlay -------------------
    CCSprite * sprWinBackground;        //win match background
    CCSprite * sprWinCharacter;         //win match character sprite
    CCSprite * sprTextBubble;           //win match text bubble
    
    // Start Overlay -----------------
    CCSprite * sprReady;                //ready sprite at start of match
    CCSprite * sprGo;                   //go sprite at start of match
    

    
    CCMenu * menu;                      //all game buttons
    CCMenu * menuOverlay;               //overlay menus for pause screen
    SceneState sceneState;              //current state of screen
    float timer;                        //count down timer for battle
    
    int ai;                             //AIType: to define AI logic
    int winCount;                       //counting # of wins
    int loseCount;                      //counting # of losses
    int tempState;                      
    
    int roundTime;                      //every round's time
    
    NSMutableArray * roundBadges;         //CCSprite of badges
    NSMutableString * record;             //string to keep track of game progress
    
    bool transitioning;                 //screen is transitioning
    
}

+(CCScene *) scene;
-(void) nextRoundCallback;
-(void) pauseCallback;
-(void) resumeCallback;
-(void) gameOverCallback;
-(void) determineResult;

@end
