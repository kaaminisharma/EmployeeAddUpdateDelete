//
//  EmpRecordsTableViewController.m
//  empAddUpdDelWithoutStoryBoard
//
//  Created by student14 on 15/06/17.
//  Copyright © 2017 kaamini. All rights reserved.
//

#import "EmpRecordsTableViewController.h"
#import "AddEmployeeViewController.h"
#import "employeeData.h"
#import "employeeDetailsViewController.h"
#import <sqlite3.h>

@interface EmpRecordsTableViewController ()

@end

@implementation EmpRecordsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title=@"All records";
    UIBarButtonItem *rgtbtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(AddEmployee)];
    
    self.navigationItem.rightBarButtonItem=rgtbtn;
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    _empRecords=[[NSMutableArray alloc]init];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    // empty array as it will append other records as well whenever we are going back to the records table
    [_empRecords removeAllObjects];
    
    NSArray *dircontents=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath=[NSString stringWithFormat:@"%@/empAddUpDelwoStory.sqlite",[dircontents lastObject]];
    
    sqlite3 *db;
    sqlite3_stmt *mystmt;
    if(sqlite3_open([dbpath UTF8String], &db)==SQLITE_OK)
    {
        NSString *query=@"Select * from empdetail";
        
        if(sqlite3_prepare(db, [query UTF8String], -1, &mystmt, NULL)==SQLITE_OK)
        {
            
            while(sqlite3_step(mystmt)==SQLITE_ROW)
            {
                employeeData *emp=[[employeeData alloc]init];
                
                emp.empID=sqlite3_column_int(mystmt, 0);
                
                emp.empName=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 1)];
                emp.empAddress=[NSString stringWithFormat:@"%s",sqlite3_column_text(mystmt, 2)];
                emp.empPhoneno=sqlite3_column_int(mystmt, 3);
                
                //NSLog(@"%d",emp.empID);
                
                [_empRecords addObject:emp];
            }
            
            //NSLog(@"%@",_empRecords);
        }
        else
        {
            NSLog(@"No Records Found");
        }
    }
    else
    {
        NSLog(@"Failed to open Database");
    }
    
    [self.tableView reloadData];

    
    sqlite3_close(db);
    
}


-(void)AddEmployee
{
    AddEmployeeViewController *addemp=[[AddEmployeeViewController alloc]init];
    [self.navigationController pushViewController:addemp animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _empRecords.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    employeeData *employee=[_empRecords objectAtIndex:indexPath.row];
    cell.textLabel.text=employee.empName;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    //DetailViewController *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    employeeDetailsViewController *employeeObj=[[employeeDetailsViewController alloc]init];
    // Pass the selected object to the new view controller.
    employeeObj.tempEmp=[_empRecords objectAtIndex:indexPath.row];
    
    // Push the view controller.
    [self.navigationController pushViewController:employeeObj animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
