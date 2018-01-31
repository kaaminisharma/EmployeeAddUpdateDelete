//
//  employeeDetailsViewController.m
//  empAddUpdDelWithoutStoryBoard
//
//  Created by student14 on 15/06/17.
//  Copyright © 2017 kaamini. All rights reserved.
//

#import "employeeDetailsViewController.h"
#import <sqlite3.h>

@interface employeeDetailsViewController ()

@end

@implementation employeeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.temp
    self.navigationItem.title=@"Employee Details";
    
    _empid_e.text=[NSString stringWithFormat:@"%d",_tempEmp.empID];
    _empname_e.text=_tempEmp.empName;
    _empaddr_e.text=_tempEmp.empAddress;
    _empphone_e.text=[NSString stringWithFormat:@"%d",_tempEmp.empPhoneno];
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

- (IBAction)EditEmpData:(id)sender {
    
    _editBtn.hidden =YES;
    _editBtn.enabled=NO;
    
    _updateBtn.hidden=NO;
    _updateBtn.enabled=YES;
    _delButton.hidden=NO;
    _delButton.enabled=YES;
    
    _empname_e.enabled=YES;
    _empaddr_e.enabled=YES;
    _empphone_e.enabled=YES;
}


- (IBAction)updateEmpData:(id)sender {
    _msgLabel.hidden=YES;
    _msgLabel.text=@"";
    NSArray *dircontents=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath=[NSString stringWithFormat:@"%@/empAddUpDelwoStory.sqlite",[dircontents lastObject]];
    
    sqlite3 *db;
    
    if(sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        NSString *query=[NSString stringWithFormat:@"update empdetail set empname='%@',address='%@',phoneno='%@' where empid='%@'",_empname_e.text,_empaddr_e.text,_empphone_e.text,_empid_e.text];
        if(sqlite3_exec(db, [query UTF8String], NULL, NULL, NULL)==SQLITE_OK)
        {
            _msgLabel.hidden=NO;
            _msgLabel.text=@"Record Updated Successfully";
        }
        else
        {
            _msgLabel.hidden=NO;
            _msgLabel.text=@"Failed to update the record";
        }
    }
    else
    {
        _msgLabel.hidden=NO;
        _msgLabel.text=@"Failed to open Database";
    }
    
    sqlite3_close(db);
}

- (IBAction)delEmpData:(id)sender {
    _msgLabel.hidden=YES;
    _msgLabel.text=@"";
    NSArray *dircontents=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath=[NSString stringWithFormat:@"%@/empAddUpDelwoStory.sqlite",[dircontents lastObject]];
    
    sqlite3 *db;
    
    if(sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        NSString *query=[NSString stringWithFormat:@"Delete from empdetail where empid='%@'",_empid_e.text];
        if(sqlite3_exec(db, [query UTF8String], NULL, NULL, NULL)==SQLITE_OK)
        {
            _msgLabel.hidden=NO;
            _msgLabel.text=@"Record deleted Successfully";
        }
        else
        {
            _msgLabel.hidden=NO;
            _msgLabel.text=@"Failed to delete the record";
        }
    }
    else
    {
        _msgLabel.hidden=NO;
        _msgLabel.text=@"Failed to open Database";
    }
    
    sqlite3_close(db);
}


@end
