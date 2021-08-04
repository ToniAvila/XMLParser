/*
 * Filename       parse.y
 * Date           4/7/2021
 * Author         Toni Avila
 * Email          txa180025@utdallas.edu
 * Course         SE 3377.0W6 Spring 2021
 * Version        1.0
 * Copyright      2021, All Rights Reserved
 *
 * Description
 *
 *    This file holds our grammar rules in order to produce
 *    the correct XML output.
 *
 */

%{
  #include <stdio.h>
  int yylex(void);
  void yyerror(char *);
%}

%union
 {
   int value;
   char *str;
}
/* defining types of complex tokens, JRTOKEN and SRTOKEN are considered simple token, */
%type <str> NAMETOKEN
%type <str> NAME_INITIAL_TOKEN
%type <str> ROMANTOKEN
%type <str> IDENTIFIERTOKEN
%type <value> INTTOKEN


%token NAMETOKEN
%token IDENTIFIERTOKEN
%token NAME_INITIAL_TOKEN
%token ROMANTOKEN
%token SRTOKEN
%token JRTOKEN
%token INTTOKEN
%token HASHTOKEN
%token COMMATOKEN
%token DASHTOKEN
%token EOLTOKEN

%start postal_addresses

%%

postal_addresses:
                       address_block EOLTOKEN postal_addresses
                  |    address_block
		  ;

address_block: 
                       name_part street_part location_part {fprintf(stderr, "\n");}
		  |    error EOLTOKEN{printf("bad address description... skipping to next line to recover.\n");} 
                  ;

name_part:             personal_part last_name suffix EOLTOKEN
                  |    personal_part last_name EOLTOKEN
                  |    error EOLTOKEN{printf("Bad name-part ... skipping to newline.\n");}
                  ;
personal_part:         NAMETOKEN {fprintf(stderr, "<FirstName>%s</FirstName>\n", $1);}
                  |    NAME_INITIAL_TOKEN {fprintf(stderr, "<FirstName>%s</FirstName>\n", $1);}
                  ;                   

last_name:             NAMETOKEN {fprintf(stderr, "<LastName>%s</LastName>\n", $1);}
                  ;

suffix:                SRTOKEN {fprintf(stderr, "<Suffix>Sr.</Suffix>\n");}
                  |    JRTOKEN {fprintf(stderr, "<Suffix>Jr.</Suffix>\n");}
                  |    ROMANTOKEN {fprintf(stderr, "<Suffix>%s</Suffix>\n", $1);}
                  ;

street_part:           street_num street_nme apt_num EOLTOKEN
                  |    street_num street_nme EOLTOKEN
                  |    error EOLTOKEN{printf("Bad street_part (address_line) ... skipping to newline.\n");}
                  ;

apt_num:               INTTOKEN {fprintf(stderr, "<AptNum>%d</AptNum>\n", $1);}
                  |    HASHTOKEN INTTOKEN {fprintf(stderr, "<AptNum>%d</AptNum>\n", $2);}
                  ;

street_num:            INTTOKEN {fprintf(stderr, "<HouseNumber>%d</HouseNumber>\n", $1);}
                  |    IDENTIFIERTOKEN {fprintf(stderr, "<HouseNumber>%s</HouseNumber>\n", $1);}
                  ;

street_nme:            NAMETOKEN {fprintf(stderr, "<StreetName>%s</StreetName>\n", $1);}
                  ;
 
location_part:         city_nme COMMATOKEN state_initials zip_code EOLTOKEN
                  |    error EOLTOKEN{printf("Bad location_part (location_line) ... skipping to newline.\n");}
                  ;     
                  
city_nme:              NAMETOKEN {fprintf(stderr, "<City>%s</City>\n", $1);}
                  ;

state_initials:        NAMETOKEN {fprintf(stderr, "<State>%s</State>\n", $1);}
                  ; 

zip_code:              INTTOKEN DASHTOKEN INTTOKEN {fprintf(stderr, "<Zip5>%d</Zip5>\n<Zip4>%d</Zip4>\n", $1, $3);}
                  |    INTTOKEN {fprintf(stderr, "<Zip5>%d</Zip5>\n", $1);}
                  ;


%%

void yyerror(char *s)
{
}
