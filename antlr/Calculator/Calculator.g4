grammar Calculator;

// Generate: antlr4 Calculator.g4
// Compile: javac Calculator*.java 
// Run: grun Calculator exp -tree test/input1.txt

start: statements EOF;

statements:
    // nothing 
    | statement statements
    ;

statement: 
    varDef 
    | sExpr
    ;

varDef: ID '=' expr ';' { 
    System.out.println($ID.text+ " = "+ 
        Integer.toString($expr.i));
};

sExpr: expr ';' { 
    System.out.println("result: "+ 
        Integer.toString($expr.i));
};

expr returns[int i]:
    '(' e=expr ')' { $i = $e.i; }
    | el=expr '*' er=expr { $i = $el.i * $er.i; }
    | el=expr '+' er=expr { $i = $el.i + $er.i; }
    | el=expr '-' er=expr { $i = $el.i - $er.i; }
    | ID { }
    | INT { $i = Integer.parseInt($INT.text); }
    ;


ID: [_A-Za-z][_A-Za-z0-1]*;
INT: [0-9]+ ;
WS : [ \t\r\n]+ -> skip ;
