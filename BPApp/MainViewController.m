//
//  MainViewController.m
//  BPApp
//
//  Created by Misato Tina Alexandre on 10/8/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

-(NSString *)filePath{
    //listing out possible paths.Location of the file.
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths lastObject];
    NSString *databasePath=[documentsDirectory stringByAppendingPathComponent:@"bp.sql"];
    //This is going to be the sqlite file I use. Name of the file.
    return databasePath;
}
-(void)openDB{
    //open or create db
    if (sqlite3_open([[self filePath]UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Database failed to open.");
    }else{
        NSLog(@"database opened.");
    }
}
-(void)createTable:(NSString *)tableName withField1:(NSString *)filed1 withField2:(NSString *)field2 withField3:(NSString *)field3 withField4:(NSString *)field4{
    //create a table
    char *err;
    NSString *sql=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@'('%@' " "TEXT PRIMARY KEY, '%@' INTEGER, '%@' INTEGER, '%@'TEXT);", tableName, filed1, field2, field3, field4];
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Could not create table");
    }else{
        NSLog(@"table created");
    }
                   
}

- (void)viewDidLoad

{
    [super viewDidLoad];
    [self openDB];
    [self createTable:@"summary" withField1:@"theDate" withField2:@"systolic" withField3:@"diastolic" withField4:@"comments"];
	// Do any additional setup after loading the view, typically fro
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)saveEntry:(id)sender {
    //collect the info from the text fields.
    int systolic=[self.systolicText.text intValue];
    int diastolic=[self.diastolicText.text intValue];
    NSString *comments=self.commentsText.text;
    NSDate *theDate=[NSDate date];
    
    //Sql statements. Name of the fields and values.
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO summary ('theDate', 'systolic', 'diastolic', 'comments') VALUES ('%@', '%d','%d', '%@')", theDate, systolic, diastolic, comments];
    //execute the update.
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) !=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0,@"COuld not update table.");
    }else{
        NSLog(@"table updated.");
    }
    
    self.systolicText.text=@"";
    self.diastolicText.text=@"";
    self.commentsText.text=@"";
}

- (IBAction)bkgdTap:(id)sender {
    [self.systolicText resignFirstResponder];
    [self.diastolicText resignFirstResponder];
    [self.commentsText resignFirstResponder];
}
@end
