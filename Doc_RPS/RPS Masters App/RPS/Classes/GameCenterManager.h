//
//  GameCenterManager.h
//  RPS
//
//  Created by chibitotoro on 12-05-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "AppSpecificValues.h"
#import "SynthesizeSingleton.h"
#import "cocos2d.h"
#import "SimpleAudioEngine.h"


// Subclass our object from NSObject - allow it to be serialized, and make it the delegate for the leaderboard view
@interface GameCenterManager : NSObject <NSCoding, GKLeaderboardViewControllerDelegate,GKAchievementViewControllerDelegate,GKFriendRequestComposeViewControllerDelegate,GKMatchmakerViewControllerDelegate,GKMatchDelegate>{
    // Boolean that is set to true if device supports Game Center and a player has logged in
    BOOL hasGameCenter;
    
    // An array that holds scores that couldn't be sent to Game Center (network timeout, etc.)
    NSMutableArray *unsentScores;
    
    // The view that shows the default Game Center leaderboards
    UIViewController *myViewController;
    
    // Store unsent Game Center data
    NSMutableArray *unsentAchievements;
    
    // Store saved Game Center achievement progress
    NSMutableDictionary *achievementsDictionary;
    
    GKLocalPlayer * localPlayer;
    
    GKMatch * myMatch;
    
    int sequence;
    int receiveSequence;
}

// Create accessible properties

@property (readwrite) BOOL hasGameCenter;
@property (readwrite, retain) NSMutableArray *unsentScores;
@property (readwrite, retain) UIViewController *myViewController;
@property (nonatomic, retain) GKLocalPlayer * localPlayer;
@property (nonatomic, retain) GKMatch * myMatch;

//SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(GameCenterManager);

-(void) sendPacket:(int)type state:(int)state character:(int)character data:(int)data time:(float)time;

// These methods are all provided as examples from Apple
- (BOOL)isGameCenterAPIAvailable;
- (void)authenticateLocalPlayer;
- (void)reportScore:(int64_t)score forCategory:(NSString *)category;
- (void)showLeaderboardForCategory:(NSString *)category;
- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController;

// Achievement methods
- (GKAchievement *)getAchievementForIdentifier:(NSString *)identifier;
- (void)reportAchievementIdentifier:(NSString *)identifier percentComplete:(float)percent;
- (void)reportAchievementIdentifier:(NSString *)identifier incrementPercentComplete:(float)percent;
- (void)showAchievements;
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController;

// Serialize/store the variables in this singleton
+ (void)loadState;
+ (void)saveState;

-(void) retrieveUserScore;
-(void)disconnect;
-(void) hostMatch;


@end
