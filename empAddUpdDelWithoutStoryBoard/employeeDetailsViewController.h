//
//  employeeDetailsViewController.h
//  empAddUpdDelWithoutStoryBoard
//
//  Created by student14 on 15/06/17.
//  Copyright © 2017 kaamini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "employeeData.h"

@interface employeeDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *empid_e;
@property (weak, nonatomic) IBOutlet UITextField *empname_e;
@property (weak, nonatomic) IBOutlet UITextField *empaddr_e;
@property (weak, nonatomic) IBOutlet UITextField *empphone_e;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

@property(nonatomic,retain)employeeData *tempEmp;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@property (weak, nonatomic) IBOutlet UIButton *delButton;

- (IBAction)EditEmpData:(id)sender;
- (IBAction)delEmpData:(id)sender;
- (IBAction)updateEmpData:(id)sender;
@end
