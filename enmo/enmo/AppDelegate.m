//
//  AppDelegate.m
//  enmo
//
//  Created by APPLE on 07/03/18.
//  Copyright © 2018 APPLE. All rights reserved.
//

#import "AppDelegate.h"

// TODO: change to your advertiser ID here
#define ADVERTISER_ID   0


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    EnmoManager.shared.delegate = self;
    [EnmoManager.shared setAdvertiserId: ADVERTISER_ID];
    [EnmoManager.shared start3rdPartyRanging];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    application.applicationIconBadgeNumber = 0;
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSUserDefaults * settings = [ NSUserDefaults standardUserDefaults ];
    NSString * urlString = [ settings objectForKey: KEY_URL_TO_SHOW_UPON_FOREGROUND ];
    
    if( urlString )
    {
        BOOL alreadyHasParams = [ urlString rangeOfString: @"?" ].location != NSNotFound;
        if( alreadyHasParams ) {
            urlString = [ urlString stringByAppendingFormat: @"%@BG2FG=1", alreadyHasParams ? @"&" : @"" ];
        }
        
        if( [ [ settings objectForKey: @"shouldLoadRulesUponForeground" ] boolValue ] ) {
            [ settings setObject: nil forKey: @"shouldLoadRulesUponForeground" ];
            [EnmoManager.shared loadRulesFromServer: NO ];
        }
        
        // NOTE: call URL here and show it in UI
    }
    else
    {
        // NOTE: Konstantin - as I removed rule call when app loads rules json locally - we need to load last called page if any
        NSString * urlString2 = [ settings objectForKey: @"lastURL" ];
        if(urlString2 != nil) {
            // NOTE: call URL here and show it in UI
        }
    }}


- ( void ) application: ( UIApplication * ) application
performFetchWithCompletionHandler: ( void ( ^ ) ( UIBackgroundFetchResult ) ) completionHandler
{
    if( [ EnmoManager.shared appIdTimer ] == 0 ) {
        completionHandler(UIBackgroundFetchResultNoData);
    }
    else {
        EnmoManager.shared.fetchCompletionHandler = completionHandler;
        NSLog(@"performing background fetch of rules now");
        if( ![ EnmoManager.shared checkNewRules ] ) {
            completionHandler( UIBackgroundFetchResultNewData );
            EnmoManager.shared.fetchCompletionHandler = nil;
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
