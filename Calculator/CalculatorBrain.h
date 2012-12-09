//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Ali Lemus on 6/14/12.
//  Copyright (c) 2012 Elemental Geeks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
@property (readonly) id program; // Almacena el programa, id es cualquier objeto

-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;
-(void)clearStack;

// Recibe un programa y devuelve cual es el rusultado de haber ejecutado ese programa 
+(double)runProgram:(id)program;
// Recibe el programa (id) y lo imprimimos y devolvemos un NSString
+(NSString *)descriptionOfProgram:(id)program;
@end
