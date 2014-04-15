//
//  AppDelegate.m
//  RPS
//
//  Created by chibitotoro on 12-03-05.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"

#import "MainMenuLayer.h"
#import "SinglePlayerOptionsLayer.h"
#import "MultiplayerOptionsLayer.h"
#import "GameOverLayer.h"
#import "WinGameLayer.h"
#import "HowToPlayLayer.h"

#import "SimpleAudioEngine.h"

@implementation AppController

@synthesize opponentReady,userReady;

@synthesize window=window_, navController=navController_, director=director_;
@synthesize defaults;
@synthesize numberOfRounds,userHand,opponentHand,leftCharacter,rightCharacter;
@synthesize currentMatch,currentStage,currentRound;
@synthesize chrLeft,chrRight,opponentLineUp,stageLineUp,playingBGM,playingSFX,restarted;
@synthesize mgrStage,mgrGameCenter;
@synthesize singlePlayerWins,multiplayerWins;
@synthesize wrapper,isHost,disconnected;
@synthesize rootViewController,inGame;
@synthesize activeLayer,match,matchStarted,loadedOpponent,receivedStart;
@synthesize selectedCharacter,userSide,opponentName,userImage,opponentImage,opponentCharacter;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];

	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];

	director_.wantsFullScreenLayout = YES;

	// Display FSP and SPF
	[director_ setDisplayStats:NO];

	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];

	// attach the openglView to the director
	[director_ setView:glView];

	// for rotation and other messages
	[director_ setDelegate:self];

	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
//	[director setProjection:kCCDirectorProjection3D];

	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");

	// Create a Navigation Controller with the Director
	navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;

	// set the Navigation Controller as the root view controller
//	[window_ setRootViewController:rootViewController_];
	[window_ addSubview:navController_.view];

	// make main window visible
	[window_ makeKeyAndVisible];

	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	// When in iPad / RetinaDisplay mode, CCFileUtils will append the "-ipad" / "-hd" to all loaded files
	// If the -ipad  / -hdfile is not found, it will load the non-suffixed version
	[CCFileUtils setiPadSuffix:@"-ipad"];			// Default on iPad is "" (empty string)
	[CCFileUtils setRetinaDisplaySuffix:@"-hd"];	// Default on RetinaDisplay is "-hd"

	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];

    
	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	[director_ pushScene: [MainMenuLayer scene]]; 
    //[director_ pushScene: [HowToPlayLayer scene]]; 
    //[director_ pushScene: [SinglePlayerOptionsLayer scene]]; 
    //[director_ pushScene: [MultiplayerOptionsLayer scene]]; 
    
    playingBGM=true;
    playingSFX=true;
    restarted=false;
    isHost=false;
    matchStarted=false;
    loadedOpponent=false;
    receivedStart=false;
    disconnected=true;
    userReady=false;
    opponentReady=false;
    inGame=false;
    
    // BEGIN CUSTOM INITIALIZATION
    
    userHand=ROCK;        //no hand selected
    opponentHand=ROCK;
    currentRound=1;         //not in match
    currentMatch=1;
    
    singlePlayerWins=0;
    multiplayerWins=0;
    
    mgrStage = [[StageManager alloc]init];
    mgrGameCenter = [[GameCenterManager alloc]init];
    
    [mgrGameCenter authenticateLocalPlayer];
    
    defaults = [NSUserDefaults standardUserDefaults]; 
    if([defaults objectForKey:@"spWins"]!=nil) singlePlayerWins=[[defaults objectForKey:@"spWins"]intValue];
    if([defaults objectForKey:@"mpWins"]!=nil) multiplayerWins=[[defaults objectForKey:@"mpWins"]intValue];
    
    
    printf("SCORES: %d,%d\n",singlePlayerWins,multiplayerWins);
    // to load
   
    
    if(playingBGM) [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"MainMenu.mp3"];
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.4f];
    
    
    // create the root controller
    
    rootViewController = [[RootViewController alloc] init];
    [window_ addSubview:rootViewController.view];
    
    mgrGameCenter.myViewController=rootViewController;
    
	return YES;
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
    disconnected=true;
    inGame=false;
    
    [mgrGameCenter disconnect];
    
    NSLog(@"RESIGN");
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
        NSLog(@"ACTIVE");
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
    
    
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
        NSLog(@"ENTER BG");
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
        NSLog(@"ENTER FG");
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void) dealloc
{
	[window_ release];
	[navController_ release];

	[super dealloc];
}
@end
