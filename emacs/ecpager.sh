#! /bin/sh
# Use `emacsclient' as a pager for Eshell sessions.  The environment
# variable PAGER should be setup to point to this script.

# Note that this may inconvenient for some applications because we
# write out the entire temp file before invoking the pager.  But
# remember, Eshell was written with non-multitasking operating systems
# in mind!

TEMPFILE="`mktemp tmp.XXXXXXXXXX.ansi`"
trap "rm -f $TEMPFILE" EXIT
cat >"$TEMPFILE"
emacsclient "$TEMPFILE"
