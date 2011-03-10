/*
 * Part of FlowFTPd
 * Licence: GPL v2
 * Author: Arrrbiter
 * pid.c
 *
 * Process ID related functions.
 */

#include "str.h"
#include "utility.h"
#include "pid.h"
#include "tunables.h"

void
vsf_pid_write_pid_file(int pid)
{
  int pidfile;
  int retval;
  struct mystr pid_str = INIT_MYSTR;

  pidfile = vsf_sysutil_create_or_open_file(tunable_pid_file, 0600);
  if (vsf_sysutil_retval_is_error(pidfile))
  {
    die2("cannot open pidfile:", tunable_pid_file);
  }

  str_alloc_ulong(&pid_str, (unsigned long)pid);
  str_append_text(&pid_str, "\n");

  retval = vsf_sysutil_write(pidfile, str_getbuf(&pid_str), str_getlen(&pid_str));
  if (vsf_sysutil_retval_is_error(pidfile))
  {
    die2("failed write to pidfile:", tunable_pid_file);
  }
  vsf_sysutil_close(pidfile);
}
