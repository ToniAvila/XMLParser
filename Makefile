#!/usr/bin/make -f
#
# Filename:		Makefile
# Date:			4/7/2021
# Author:		Toni Avila
# Email:		txa180025@utdallas.edu
# Course:               SE 3377.0W6 Spring 2021
# Version:		1.0
# Copyright:		2021, All Rights Reserved
#
# Description:
#
#	This Makefile builds our project and creates a scanner and parser 
#       symbolic link to execute either option as needed.
#	


#
# Flags for the C++ implicit rules
CC = gcc
CCFLAGS = -Werror
CPPFLAGS =


# Flags for the Lex implicit rules
LEX = /usr/bin/flex
LFLAGS = 


# Implicit Makefile rule to use YACC for C programs
YACC = /usr/bin/bison
YFLAGS = -dy



# descriptive name used for the backup target
# This should not contain spaces or special characters
PROJECTNAME = CS3377.Project.5

EXECFILE = assignment5

OBJS = parse.o scan.o assignment5.o

# Keeping the intermediate files so we can look at
.PRECIOUS: scan.c parse.c


all: $(EXECFILE)

clean:
	rm -f $(OBJS) $(EXECFILE) scanner parser y.tab.h parse.c scan.c *~ \#*

$(EXECFILE):	$(OBJS)
	$(CC) -o $@ $(OBJS)
	ln -fs ./$@ scanner
	ln -fs ./$@ parser


backup:
	@make clean
	@mkdir -p ~/backups; chmod 700 ~/backups
	@$(eval CURDIRNAME := $(shell basename "`pwd`"))
	@$(eval MKBKUPNAME := ~/backups/$(PROJECTNAME)-$(shell date +'%Y.%m.%d-%H:%M:%S').tar.gz)
	@echo
	@echo Writing Backup file to: $(MKBKUPNAME)
	@echo
	@-tar zcfv $(MKBKUPNAME) ../$(CURDIRNAME) 2> /dev/null
	@chmod 600 $(MKBKUPNAME)
	@echo
	@echo Done!
