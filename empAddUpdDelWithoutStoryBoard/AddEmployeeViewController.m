//
//  AddEmployeeViewController.m
//  empAddUpdDelWithoutStoryBoard
//
//  Created by student14 on 15/06/17.
//  Copyright © 2017 kaamini. All rights reserved.
//

#import "AddEmployeeViewController.h"
#import <sqlite3.h>
#import "EmpRecordsTableViewController.h"

@interface AddEmployeeViewController ()

@end

@implementation AddEmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //_msgLabel=[[UILabel alloc]init];
    
    self.navigationItem.title=@"Add Employee";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addEmployee:(id)sender {
    
    _msgLabel.hidden=YES;
    _msgLabel.text=@"";
    
    NSArray *dircontents=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath=[NSString stringWithFormat:@"%@/empAddUpDelwoStory.sqlite",[dircontents lastObject]];
    
    
    sqlite3 *db;
    
    if(sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        NSString *query=[NSString stringWithFormat:@"insert into empdetail values(\"%@\",\"%@\",\"%@\",\"%@\")",_empid.text,_empname.text,_address.text,_phoneno.text];
        
        //NSLog(@"%@",query);
        
        if(sqlite3_exec(db, [query UTF8String], NULL, NULL, NULL)==SQLITE_OK)
        {
            _msgLabel.hidden=NO;
            _msgLabel.text=@"Record Inserted Successfully";
        }
        else
        {
            _msgLabel.hidden=NO;
            _msgLabel.text=@"Failed to insert record";
        }
    }
    else
    {
        _msgLabel.hidden=NO;
        _msgLabel.text=@"Failed to open Database";
    }
    
    sqlite3_close(db);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
