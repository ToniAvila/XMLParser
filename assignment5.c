/*
 * Filename      assignment5.c
 * Date          4/7/2021
 * Author        Toni Avila
 * Email         txa180025@utdallas.edu
 * Course        SE 3377.0W6 Spring 2021
 * Version       1.0
 * Copyright     2021, All Rights Reserved
 *
 * Description
 *
 *   This file holds the main routine of the program. Depending on
 *   the argv[0] we will either run in parse mode or scanner mode, or
 *   an unsupported option was chosen.
 *
*/


#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"


int yylex(void);
extern char *yytext;

int main(int argc, char* argv[]){
  
  // if scanner called
  if((strcmp(argv[0], "./scanner")) == 0) { 
    int token;

    token = yylex();

    // loop until out of tokens (end of file)
    while(token != 0){
   
      switch(token){
       case NAMETOKEN:
	 printf("yylex returned NAMETOKEN token (%s)\n", yytext);
	 break;
       case NAME_INITIAL_TOKEN:
	 printf("yylex returned NAME_INITIAL_TOKEN token (%s)\n", yytext);
	 break;
       case ROMANTOKEN:
	 printf("yylex returned ROMANTOKEN token (%s)\n", yytext); 
         // note: sample ouput from assignment outputs enum value of a complex token
	 // I have decided instead to print out actual value of token
         break;
       case IDENTIFIERTOKEN:
	 printf("yylex returned IDENTIFIERTOKEN token (%s)\n", yytext);
	 break;
       case SRTOKEN:
	 printf("yylex returned SRTOKEN token (%s)\n", yytext);
	 break;
       case JRTOKEN:
	 printf("yylex returned JRTOKEN token (%s)\n", yytext);
	 break;
       case EOLTOKEN:
	 printf("yylex returned EOLTOKEN token (%d)\n", EOLTOKEN);
	 break;
       case INTTOKEN:
	 printf("yylex returned INTTOKEN token (%s)\n", yytext);
	 break;
       case HASHTOKEN:
	 printf("yylex returned HASHTOKEN token (%d)\n", HASHTOKEN);
	 break;
       case COMMATOKEN:
	 printf("yylex returned COMMATOKEN token (%d)\n", COMMATOKEN);
	 break;
       case DASHTOKEN:
	 printf("yylex returned DASHTOKEN token (%d)\n", DASHTOKEN);
	 break;
       default:
	 printf("UNKNOWN\n");
	 break;
      }
      
      // get next token
      token = yylex();
    } 

    printf("Done\n");

  }else if((strcmp(argv[0], "./parser")) == 0){  // if parser is called

    printf("About to call parser.\n");

    // determine results of yyparse call
    switch(yyparse()){
     case 0: 
       printf("Parse Successful!\n");
       break;
     case 1:
       printf("Parse Failure!\n");
       break;
     case 2:
       printf("Out of Memory.\n");
       break;
     default:
       printf("Unknown Results.\n");
     break;
    }

    
  }else{ //parser or scanner not called
    printf("Program error. No valid mode entered.");
    return 1;
  }

  return 0;

}
