//
//  AddEmployeeViewController.h
//  empAddUpdDelWithoutStoryBoard
//
//  Created by student14 on 15/06/17.
//  Copyright © 2017 kaamini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEmployeeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *empid;
@property (weak, nonatomic) IBOutlet UITextField *empname;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phoneno;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;


- (IBAction)addEmployee:(id)sender;

@end
