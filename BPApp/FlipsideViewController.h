//
//  FlipsideViewController.h
//  BPApp
//
//  Created by Misato Tina Alexandre on 10/8/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end


@interface FlipsideViewController : UIViewController
{
    sqlite3 *db;

}
@property (nonatomic, retain) NSMutableArray *entries;
@property (nonatomic, retain) NSMutableArray *dates;
@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

-(NSString *)filePath;
-(void)openDB;

- (IBAction)done:(id)sender;

@end
