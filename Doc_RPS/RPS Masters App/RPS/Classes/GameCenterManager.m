//
//  GameCenterManager.m
//  RPS
//
//  Created by chibitotoro on 12-05-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameCenterManager.h"
#import "cocos2d.h"
#import <GameKit/GameKit.h>

#import "MultiplayerOptionsLayer.h"
#import "MultiplayerVersusLayer.h"
#import "MultiplayerBattleLayer.h"

@implementation GameCenterManager
@synthesize hasGameCenter, unsentScores;
@synthesize myViewController;
@synthesize localPlayer,myMatch;


// Time-saving singleton generator - see http://cocoawithlove.com/2008/11/singletons-appdelegates-and-top-level.html

- (id)init{
    if ((self = [super init])){
        // Initialize any class properties here
        if ([self isGameCenterAPIAvailable])
            hasGameCenter = YES;
        else
            hasGameCenter = NO;
    }
    sequence=receiveSequence=0;
    return self;
}
/**
 Check to see if installed OS supports Game Center
 */
- (BOOL)isGameCenterAPIAvailable{
    // Check for presence of GKLocalPlayer class
    BOOL localPlayerClassAvailable = (NSClassFromString(@"GKLocalPlayer")) != nil;
    
    // Device must be running 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    return (localPlayerClassAvailable && osVersionSupported);
    
}

/**
 Attempt to authenticate a Game Center user. Will automatically present a modal login window.
 */
- (void)authenticateLocalPlayer{

	if (hasGameCenter){
		localPlayer = [GKLocalPlayer localPlayer];

		[localPlayer authenticateWithCompletionHandler:^(NSError *error) {

			if (localPlayer.isAuthenticated){
				/* Perform additional tasks for the authenticated player here */

                AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
                
                [localPlayer loadPhotoForSize:GKPhotoSizeSmall withCompletionHandler:^(UIImage *photo,NSError *error){
                    if(error==nil){
                        //              [ad.chrLeft.sprAvatar release];
                        
                        ad.userImage = photo;  
                        [ad.userImage retain];
                    }
                }];
                
                [self retrieveUserScore];
                
                // Load player achievements
                [GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements, NSError *error) {
                    if (error != nil)
                    {
                        // handle errors
                    }
                    if (achievements != nil)
                    {
                        // process array of achievements
                        for (GKAchievement* achievement in achievements)
                            [achievementsDictionary setObject:achievement forKey:achievement.identifier];
                    }
                }];

                
				// If unsent scores array has length > 0, try to send saved scores
				if ([unsentScores count] > 0){
					// Create new array to help remove successfully sent scores
					NSMutableArray *removedScores = [NSMutableArray array];
                    
					for (GKScore *score in unsentScores){
						[score reportScoreWithCompletionHandler:^(NSError *error) {
							if (error != nil){
								// If there's an error reporting the score (again!), leave the score in the array
							}
							else{
								// If success, mark score for removal
								[removedScores addObject:score];
							}
						}];
					}
                    
					// Remove successfully sent scores from stored array
					[unsentScores removeObjectsInArray:removedScores];
				}
			}
			else{
				// Disable Game Center methods - player not authenticated
				hasGameCenter = NO;
			}
		}];
	}
}

#pragma mark -
#pragma mark Achievement methods

/**
 * Get an achievement object in the locally stored dictionary
 */
- (GKAchievement *)getAchievementForIdentifier:(NSString *)identifier
{
	if (hasGameCenter)
	{
		GKAchievement *achievement = [achievementsDictionary objectForKey:identifier];
		if (achievement == nil)
		{
			achievement = [[[GKAchievement alloc] initWithIdentifier:identifier] autorelease];
			[achievementsDictionary setObject:achievement forKey:achievement.identifier];
		}
		return [[achievement retain] autorelease];
	}
	return nil;
}

/**
 * Send a completion % for a specific achievement to Game Center
 */
- (void)reportAchievementIdentifier:(NSString *)identifier percentComplete:(float)percent
{
	if (hasGameCenter)
	{
        
        
		// Instantiate GKAchievement object for an achievement (set up in iTunes Connect)
        GKAchievement *achievement = [self getAchievementForIdentifier:identifier];
		if (achievement)
		{
			achievement.percentComplete = percent;
			[achievement reportAchievementWithCompletionHandler:^(NSError *error)
             {
                 if (error != nil)
                 {
                     // Retain the achievement object and try again later
                     [unsentAchievements addObject:achievement];

                     NSLog(@"Error sending achievement!");
                 }
             }];
		}
	}
}

/**
 * Send a completion % for a specific achievement to Game Center - increments an existing achievement object
 */
- (void)reportAchievementIdentifier:(NSString *)identifier incrementPercentComplete:(float)percent
{
	if (hasGameCenter)
	{
		// Instantiate GKAchievement object for an achievement (set up in iTunes Connect)
		GKAchievement *achievement = [self getAchievementForIdentifier:identifier];
		if (achievement)
		{
			achievement.percentComplete += percent;
			[achievement reportAchievementWithCompletionHandler:^(NSError *error)
			 {
				 if (error != nil)
				 {
					 // Retain the achievement object and try again later
					 [unsentAchievements addObject:achievement];
                     
					 NSLog(@"Error sending achievement!");
				 }
			 }];
		}
	}
}

/**
 * Create a GKAchievementViewController and display it on top of cocos2d's OpenGL view
 */
- (void)showAchievements
{
	if (localPlayer.alias.length>0)
	{
		GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
		if (achievements != nil)
		{
			achievements.achievementDelegate = self;
            
            [myViewController presentModalViewController:achievements animated:YES];

		}
		[achievements release];
	}
    else{
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Game Center Required" message:@"Please sign into game center to use this feature." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [alert show];
    }
}

/**
 * Dismiss an active GKAchievementViewController
 */

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	[myViewController dismissModalViewControllerAnimated:YES];

}


#pragma mark Leaderboard methods
/**
 Send an integer score to Game Center for a particular category (set up category in iTunes Connect)
 */
- (void)reportScore:(int64_t)score forCategory:(NSString *)category{
	// Only execute if OS supports Game Center & player is logged in
	if (hasGameCenter){
		// Create score object
		GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
        
		// Set the score value
		scoreReporter.value = score;
        
        printf("reporting:%d\n",score);
		// Try to send
		[scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
			if (error != nil){
				// Handle reporting error here by adding object to a serializable array, to be sent again later
                NSLog(@"ERROR REPORTING");
				[unsentScores addObject:scoreReporter];
			}
		}];
	}
}

/**
 Show the "green felt" leaderboard view for a particular category
 */
- (void)showLeaderboardForCategory:(NSString *)category
{
	// Only execute if OS supports Game Center & player is logged in
	if (localPlayer.alias.length>0)
	{
		// Create leaderboard view w/ default Game Center style
		GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
        
		// If view controller was successfully created...
		if (leaderboardController != nil){
			// Leaderboard config
			leaderboardController.leaderboardDelegate = self;	// The leaderboard view controller will send messages to this object
			leaderboardController.category = category;	// Set category here
			//leaderboardController.timeScope = GKLeaderboardTimeScopeAllTime;	// GKLeaderboardTimeScopeToday, GKLeaderboardTimeScopeWeek, GKLeaderboardTimeScopeAllTime
            
            
            [myViewController presentModalViewController:leaderboardController animated:YES];
		}
	}
    else{
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Game Center Required" message:@"Please sign into game center to use this feature." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [alert show];
    }
}

/**
 Since this singleton is the GKLeaderboardViewControlerDelegage, it intercepts this method and removes the view
 */
- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	[myViewController dismissModalViewControllerAnimated:YES];
    
}
#pragma mark Auxilary

-(void) retrieveUserScore{
    GKLeaderboard * leaderboardRequest=[[[GKLeaderboard alloc]initWithPlayerIDs:[NSArray arrayWithObject:localPlayer.playerID]] autorelease];
    if(leaderboardRequest!=nil){
        [leaderboardRequest loadScoresWithCompletionHandler:^(NSArray *scores, NSError *error) {
            if(error!=nil){
                
            }
            else{
                AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
                
                //ad.singlePlayerWins=ad.multiplayerWins=[[scores objectAtIndex:0] intValue];
                //printf("CURRENT SCORE IS:%d\n",[[scores objectAtIndex:0] intValue]);
            }
        }];
    }
}


-(void) inviteFriends:(NSArray*) identifiers{
    GKFriendRequestComposeViewController * friendRequestViewController=[[GKFriendRequestComposeViewController alloc]init];
    friendRequestViewController.composeViewDelegate=self;
    if(identifiers){
        [friendRequestViewController addRecipientsWithPlayerIDs:identifiers];
        
    }
    [myViewController presentModalViewController:friendRequestViewController animated:YES];
    [friendRequestViewController release];
}

-(void) friendRequestComposeViewControllerDidFinish:(GKFriendRequestComposeViewController*)viewController{
    [myViewController dismissModalViewControllerAnimated:YES];
}
-(void) loadPlayerData:(NSArray*) identifiers{
    [GKPlayer loadPlayersForIdentifiers:identifiers withCompletionHandler:^(NSArray *players, NSError *error) {
        if(error!=nil){
            
        }
        
        if(players!=nil){
            //process array of GKPlayers
            
        }
    }];
}

-(void) loadOpponent:(NSArray*) identifiers{
    [GKPlayer loadPlayersForIdentifiers:identifiers withCompletionHandler:^(NSArray *players, NSError *error) {
//        NSLog(@"LOADING OPP");
        if(error!=nil){
            
        }
        
        if(players!=nil){
//            NSLog(@"PLAYERS NON NIL");
            //process array of GKPlayers
            GKPlayer * opponentPlayer=[players objectAtIndex:0];
            AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
            
            ad.opponentName=opponentPlayer.alias;
            
            [opponentPlayer loadPhotoForSize:GKPhotoSizeSmall withCompletionHandler:^(UIImage *photo,NSError *error){
                if(error==nil){
//                    NSLog(@"IMAGED");
                    ad.opponentImage = photo;  
                    [ad.opponentImage retain];
                    
                    ad.loadedOpponent=true;
                    
                    //send packet to change to versus screen with selected character
                    [self sendPacket:STATE_PACKET state:VERSUS character:ad.selectedCharacter data:0 time:0];
                    
                    if(ad.loadedOpponent&&ad.receivedStart){
//                                                NSLog(@"ENTRY2");
                        MultiplayerOptionsLayer * m=(MultiplayerOptionsLayer*)ad.activeLayer;
                        [m startMatch];
                    }
                }
            }];
        }
    }];
}

-(void) retrieveFriends{
    if(localPlayer.authenticated){
        [localPlayer loadFriendsWithCompletionHandler:^(NSArray *friends, NSError *error) {
            if(friends!=nil){
                [self loadPlayerData:friends];
            }
        }];
    }
}
 

#pragma mark Match Maker

-(void) hostMatch{
    GKMatchRequest *request = [[[GKMatchRequest alloc] init] autorelease];
    request.minPlayers = 2;
    request.maxPlayers = 2;
    
    GKMatchmakerViewController *mmvc = [[[GKMatchmakerViewController alloc] initWithMatchRequest:request] autorelease];
    mmvc.matchmakerDelegate = self;

    [myViewController presentModalViewController:mmvc animated:YES];
}
- (void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController *)viewController
{
    [myViewController dismissModalViewControllerAnimated:YES];
    // implement any specific code in your application here.
}
- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFailWithError:(NSError *)error
{
    [myViewController dismissModalViewControllerAnimated:YES];
    // Display the error to the user.
}

- (void)match:(GKMatch *)match player:(NSString *)playerID didChangeState:(GKPlayerConnectionState)state
{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
//
    
    switch (state){
        case GKPlayerStateConnected:
            // handle a new player connection.
//            NSLog(@"CONNECTED");
            if (!ad.matchStarted&&match.expectedPlayerCount == 0){
                
                // handle initial match negotiation.
                [myViewController dismissModalViewControllerAnimated:YES];
                
                ad.matchStarted=true;
                ad.disconnected=false;
                
                //retrieve opponent's photo and alias
                [self loadOpponent:[NSArray arrayWithObject:playerID]];
                
            }
            break;
        case GKPlayerStateDisconnected:
            // a player just disconnected.
            
            NSLog(@"DISCONNECTED");

            [self disconnect];
            
            //[myMatch release];
            if(!ad.disconnected){
                UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Disconnected" message:@"Connection has been terminated." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
                [alert show];
                
                
                
                [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];

                if(!ad.userReady||!ad.opponentReady){
                                    NSLog(@"Path3");
                    MultiplayerVersusLayer * b=(MultiplayerVersusLayer*) ad.activeLayer;
                    b.transitioning=true;
                }
                else if(ad.inGame&&ad.matchStarted){
                                    NSLog(@"Path4");
                    MultiplayerBattleLayer * b=(MultiplayerBattleLayer*) ad.activeLayer;
                    b.transitioning=true;
                }
                
                ad.userReady=false;
                ad.opponentReady=false;
                ad.disconnected=true;
                ad.inGame=false;
                
                [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"MainMenu.mp3"];
                [[CCDirector sharedDirector] replaceScene:
                 [CCTransitionFade transitionWithDuration:0.5f scene:[MultiplayerOptionsLayer scene]]];
                

            }
            
            
            
            
            
            break;
    }
}

-(void) sendPacket:(int)type state:(int)state character:(int)character data:(int)data time:(float)time{
    NSError * error;
    DataPacket p;
    p.type=type;
    p.data=data;
    p.character=character;
    p.state=state;
    p.time=time;
    p.sequence=sequence;
    
    NSData *packet = [NSData dataWithBytes:&p length:sizeof(DataPacket)];
    
    [myMatch sendDataToAllPlayers: packet withDataMode: GKMatchSendDataUnreliable error:&error];
    if (error != nil){
        // handle the error
    }
    sequence++;
}
- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFindMatch:(GKMatch *)match{
    
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    self.myMatch=match;    
    match.delegate=self;
    
    NSLog(@"MATCH FOUND!");
}

-(void) disconnect{
    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
    
    if(myMatch!=NULL){
        [myMatch disconnect];
    }
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID{

    AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
//    NSLog(@"RECEIVED DATA");
   
    
    MultiplayerBattleLayer * b;
    MultiplayerVersusLayer * v;
    DataPacket * p = (DataPacket *)[data bytes];
    
//    printf("packet type:%d,%d\n",p->data,p->type);
    
    switch (p->type) {
        case STATE_PACKET:
            switch (p->state) {
                case VERSUS:
//                    NSLog(@"VS DATA");
                    if([[localPlayer.playerID substringFromIndex:2] intValue]>[[playerID substringFromIndex:2] intValue]){
                        ad.userSide=LEFT_SIDE;
                        ad.isHost=true;
                    }
                    else{
                        ad.userSide=RIGHT_SIDE;
                        ad.isHost=false;
                    }
                    
                    ad.opponentCharacter=p->character;
                    ad.receivedStart=true;
                    
                    if(ad.loadedOpponent&&ad.receivedStart){
//                        NSLog(@"ENTRY1");
                        MultiplayerOptionsLayer * m=(MultiplayerOptionsLayer*)ad.activeLayer;
                        [m startMatch];
                    }
                    

                    break;
                case READY:
//                    NSLog(@"RD DATA");
                    
                    if(p->data>=0) ad.currentStage=p->data;     //assign stage only if it is valid
                    ad.opponentReady=true;
                    
                    printf("ENTRY2 : %d,%d\n",ad.userReady,ad.opponentReady);
                    if(ad.opponentReady&&ad.userReady){
                        [[CCDirector sharedDirector] replaceScene:
                         [CCTransitionFade transitionWithDuration:0.5f scene:[MultiplayerBattleLayer scene]]]; 
                    }
                    break;
                default:
                    break;
            }
            
            break;
        case HAND_PACKET:
            
            if(!ad.inGame){
                [self disconnect];
                break;
            }
            b=(MultiplayerBattleLayer*)ad.activeLayer;
            
            
            if(ad.userSide==p->character){
                ad.userHand=p->data;
            }
            else {
                ad.opponentHand=p->data;
            }
            switch(p->character){
                case LEFT_SIDE:
                    //if(b.sceneState==IN_BATTLE){
                        [b updateLeftHand:p->data];
                    //}
                   
                    break;
                case RIGHT_SIDE:
                    //if(b.sceneState==IN_BATTLE){
                        [b updateRightHand:p->data];
                    //}
                    break;
            }
            /*
            if(ad.isHost){
                //if host, bounce msg back
                [self sendPacket:HAND_PACKET state:IN_BATTLE character:p->character data:p->data time:p->time];
                
            }
             */
/*            
            switch(p->data){
                case ROCK:
                    NSLog(@"ROCKING");
                    //userside
                   
                    break;
                case PAPER:
                    NSLog(@"PAPERING");
                    break;
                case SCISSORS:
                    NSLog(@"SCISSORING");
                    break;
                default:
                    break;
            }*/
            
            break;
        case SYNC_PACKET:
            if(!ad.inGame){
                [self disconnect];
                break;
            }
            if(p->sequence<receiveSequence) break;
            
            if(p->state==IN_BATTLE){
                b=(MultiplayerBattleLayer*)ad.activeLayer;
                if(b.sceneState==IN_BATTLE){
                    b.timer=p->time;
                }
            }
            break;
        default:
            break;
    }
    if(p->sequence>receiveSequence) receiveSequence=p->sequence;
}




@end
