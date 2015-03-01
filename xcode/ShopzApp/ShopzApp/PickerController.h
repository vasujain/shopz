//
//  FLPickerController.h
//  Autolayout
//
//  Created by Francisco Magdaleno on 6/1/14.
//  Copyright (c) 2014 pako. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerController;
@protocol PickerControllerDelegate

/**
 * Notifies the delegate a value has been selected.
 * @author Francisco Magdaleno
 *
 * @param sender Sending class.
 * @param selectedValue The value that was selected from the picker.
 */
-(void)pickerController:(PickerController *)sender didSelectValue:(NSDictionary *)selectedValue;

/**
 * Notifies when the cancel button was pressed.
 * @author Francisco Magdaleno
 *
 * @param sender Sending class.
 */
-(void)pickerControllerDidCancel:(PickerController *)sender;
@end

@interface PickerController : UIViewController

///Datasource array containing the values to present
@property (nonatomic,strong) NSArray *fullData;
///Picker view displaying the values
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
///Callback delegate
@property (nonatomic,weak) id<PickerControllerDelegate>delegate;

#define PICKER_VALUE_KEY @"picker_value_key"
#define PICKER_ID_KEY @"picker_id_key"



/**
 * Creates a new instance for the controller with a given delegate.
 * @author Francisco Magdaleno
 * @param delegate Callback delegate.
 */
+(PickerController *)createPickerControllerWithDelegate:(id<PickerControllerDelegate>)delegate;

/**
 * Shows the picker controller in a given view.
 * @author Francisco Magdaleno
 *
 * @param masterView View that will contain the picker.
 * @param informationToDisplay Array with the information to display. It needs to be an array of dictionaries containing PICKER_VALUE_KEY and PICKER_ID_KEY values.
 * @param guide Layout guide (bottom) to position the view.
 */
-(void)showPickerInView:(UIView *)masterView
               withInfo:(NSArray *)informationToDisplay
            layoutGuide:(id)guide;

/**
 * Selects the first value in the picker.
 * @author Francisco Magdaleno
 *
 */
-(void)selectFirstValue;

/**
 * Hide the picker with a callback action.
 * @author Francisco Magdaleno
 *
 * @param completion Callback method after the picker has been dismissed.
 */
-(void)hidePicker:(void (^)(void))completion;

@end
