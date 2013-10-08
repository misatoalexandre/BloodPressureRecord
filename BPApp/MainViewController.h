//
//  MainViewController.h
//  BPApp
//
//  Created by Misato Tina Alexandre on 10/8/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "FlipsideViewController.h"
#import <sqlite3.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>{
    sqlite3 *db;
    
}
@property (weak, nonatomic) IBOutlet UITextField *systolicText;
@property (weak, nonatomic) IBOutlet UITextField *diastolicText;
@property (weak, nonatomic) IBOutlet UITextField *commentsText;
@property (nonatomic, readonly) NSDate *currentDate;

-(NSString *)filePath;
-(void)openDB;

-(void)createTable:(NSString *)tableName
        withField1:(NSString *)filed1
        withField2:(NSString *)field2
        withField3:(NSString *)field3
        withField4:(NSString *)field4;


- (IBAction)saveEntry:(id)sender;
//background tap to remove keyboard
- (IBAction)bkgdTap:(id)sender;
@end
