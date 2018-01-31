//
//  AppDelegate.m
//  empAddUpdDelWithoutStoryBoard
//
//  Created by student14 on 15/06/17.
//  Copyright © 2017 kaamini. All rights reserved.
//

#import "AppDelegate.h"
#import <sqlite3.h>
#import "EmpRecordsTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    _window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    EmpRecordsTableViewController *ertvc=[[EmpRecordsTableViewController alloc]init];
    UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:ertvc];
    _window.rootViewController=navigation;
    
    [_window makeKeyAndVisible];
    
    [self createdatabase];
    
    return YES;
}


-(void)createdatabase
{
    NSArray *dircontents=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath=[NSString stringWithFormat:@"%@/empAddUpDelwoStory.sqlite",[dircontents lastObject]];
    
    NSLog(@"%@",dbpath);
    
    NSFileManager *f=[[NSFileManager alloc]init];
    if([f fileExistsAtPath:dbpath])
    {
        NSLog(@"Database already exists");
        return;
    }
    
    sqlite3 *db;
    
    if(sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        NSString *query=@"Create table empdetail(empid integer, empname varchar(25),address varchar(30),phoneno integer)";
        if(sqlite3_exec(db, [query UTF8String], NULL, NULL, NULL)==SQLITE_OK)
        {
            NSLog(@"Table Created Successfully");
        }
        else
        {
            NSLog(@"Failed to create table");
        }
    }
    else
    {
        NSLog(@"Failed to open Database");
    }
    
    sqlite3_close(db);
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
