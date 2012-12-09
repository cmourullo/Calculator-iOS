//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Ali Lemus on 6/14/12.
//  Copyright (c) 2012 Elemental Geeks. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain
@synthesize programStack = _programStack;

-(NSMutableArray *)programStack{
    if (!_programStack) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

-(void)clearStack{
    self.programStack = nil;
}

-(void)pushOperand:(double)operand{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

// Recursivo
+(double)popStack:(NSMutableArray *)stack{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }else if ([topOfStack isKindOfClass:[NSString class]]){
        NSString *operation = topOfStack;
        
        if ([operation isEqualToString:@"+"]) {
            result = [self popStack:stack] + [self popStack:stack];
        } else if ([@"-" isEqualToString:operation]){
            double temp = [self popStack:stack];
            result = [self popStack:stack] - temp;
        } else if ([@"*" isEqualToString:operation]){
            result = [self popStack:stack] * [self popStack:stack];
        } else if ([@"/" isEqualToString:operation]){
            double temp = [self popStack:stack];
            result = [self popStack:stack] / temp;
        } else if ([@"+/-" isEqualToString:operation]){
            result = ([self popStack:stack] * -1);
        } else if ([@"sin" isEqualToString:operation]){
            result = sin([self popStack:stack]);
        } else if ([@"cos" isEqualToString:operation]){
            result = cos([self popStack:stack]);
        } else if ([@"sqrt" isEqualToString:operation]){
            result = sqrt([self popStack:stack]);
        } else if ([@"π" isEqualToString:operation]){
            result = M_PI;        
        }

    }
    return result;
}

-(double)performOperation:(NSString *)operation{
    // Insertamos la operación en el stack
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:(self.program)];
}

-(id)program{
    // Se envía una copia inmutable
    return [self.programStack copy];
}

+(double)runProgram:(id)program{
    NSMutableArray *stack;
    
    // Nos aseguramos que el id es el correcto
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    
    return [self popStack:stack]; // Se puede sustituir self por CalculatorBrain
}

+(NSString *)descriptionOfProgram:(id)program{
    return @"Tarea para hacer en casa";
}


@end
