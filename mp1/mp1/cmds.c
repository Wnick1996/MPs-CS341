/******************************************************************
*
*   file:     cmds.c
*   author:   betty o'neil
*   date:     9/16/2021
*
*   semantic actions for commands called by tutor (cs341, mp1)
*
*   revisions:
*      9/90  eb   cleanup, convert function declarations to ansi
*      9/91  eb   changes so that this can be used for hw1
*      9/02  re   minor changes to quit command
*/
/* the Makefile arranges that #include <..> searches in the right
   places for these headers-- 200920*/

#include <stdio.h>
#include "slex.h"

/*===================================================================*
*
*   Command table for tutor program -- an array of structures of type
*   cmd -- for each command provide the token, the function to call when
*   that token is found, and the help message.
*
*   slex.h contains the typdef for struct cmd, and declares the
*   cmds array as extern to all the other parts of the program.
*   Code in slex.c parses user input command line and calls the
*   requested semantic action, passing a pointer to the cmd struct
*   and any arguments the user may have entered.
*
*===================================================================*/

PROTOTYPE int stop(Cmd *cp, char *arguments);
PROTOTYPE int mem_display(Cmd *cp, char *arguments);
PROTOTYPE int mem_set(Cmd *cp, char *arguments);
PROTOTYPE int help(Cmd *cp, char *arguments);

/* command table */

Cmd cmds[] = {{"md",  mem_display, "Memory display: MD <addr>"},
              {"s",   stop,        "Stop" },
              {"ms",  mem_set,     "Memory Set: MS <addr> <value>"},
              {"h",   help,        "Help: H <command>"}, 

              {NULL,  NULL,        NULL}};  /* null cmd to flag end of table */

char xyz = 6;  /* test global variable  */
char *pxyz = &xyz;  /* test pointer to xyz */
/*===================================================================*
*		command			routines
*
*   Each command routine is called with 2 args, the remaining
*   part of the line to parse and a pointer to the struct cmd for this
*   command. Each returns 0 for continue or 1 for all-done.
*
*===================================================================*/


int stop(Cmd *cp, char *arguments)
{
  return 1;			/* all done flag */
}

/*===================================================================*
*
*   mem_display: display contents of 16 bytes in hex
*
*/

int mem_display(Cmd *cp, char *arguments) {
  unsigned int disnum;
  unsigned int disaddr;
  printf("disaddr = %p  content = %d\n", pxyz, *pxyz);
  if (sscanf(arguments, "%x", &disaddr) == 1) 
  { 
  printf("%08x  ", disaddr);
  for (disnum = 0; disnum < 16; disnum++)
	  printf("%02x ", *(unsigned char*)(disaddr + disnum)); 
  for (disnum = 0; disnum < 16; disnum++)
    printf("%c", (*(unsigned char *)(disaddr + disnum) >= ' ' &&
    *(unsigned char *)(disaddr + disnum) <= '~') ?
    *(unsigned char *)(disaddr + disnum) : '.'); 
  printf("\n"); } else 
  printf("        help message: %s\n", cp->help);
  return 0;			/* not done */ }
/* mem_set: set: display address of the typed value */
int mem_set(Cmd *cp, char *arguments) {
unsigned int setnum;
unsigned int setaddr;
if (sscanf(arguments, "%x %x", &setaddr, &setnum) == 2) { 
  if (setnum < 0x100)
    *(unsigned char *)setaddr = setnum;
  else
    *(unsigned int *)setaddr = setnum;
  printf("Ok/n"); 
} else 
  printf("        help message: %s\n", cp->help);
return 0; } 
/* help: prints out the commands if not known*/
int help(Cmd *cp, char *arguments) {
printf("  cmd   help message\n");
while (*arguments == ' ')
  arguments++;
for(cp = cmds; cp->cmdtoken; cp++)
  if(!strcmp(arguments, cp->cmdtoken)) {
    printf("%8s   %s\n", cp->cmdtoken, cp->help);
  return 0; } 
for(cp = cmds; cp->cmdtoken; cp++)
  printf("%8s   %s\n", cp->cmdtoken, cp->help);
return 0; } 
