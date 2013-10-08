//
//  FlipsideViewController.m
//  BPApp
//
//  Created by Misato Tina Alexandre on 10/8/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.entries=[[NSMutableArray alloc]init];
    [self openDB];
    //SQL query: select everything.
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM summary"];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char *field1=(char*)sqlite3_column_text(statement, 0);
            NSString *field1Str=[[NSString alloc]initWithUTF8String:field1];
        
            char *field2=(char *)sqlite3_column_text(statement, 1);
            NSString *field2Str=[[NSString alloc]initWithUTF8String:field2];
            
            char *field3=(char*)sqlite3_column_text(statement, 2);
            NSString *field3Str=[[NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *)sqlite3_column_text(statement, 3);
            NSString *field4Str=[[NSString alloc]initWithUTF8String:field4];
            
            NSString *str=[[NSString alloc]initWithFormat: @"%@/%@ -%@", field2Str, field3Str, field4Str];
            [self.entries addObject:str];
            
        }
    }
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
#pragma mark-TV data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *myTitle=@"BP History";
    return myTitle;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.entries count];
    NSLog(@"%d", self.entries.count);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Test");
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text=[self.entries objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
