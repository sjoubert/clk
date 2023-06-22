#!/bin/bash -eu
# [[file:dealing_with_secrets.org::test][test]]
. ./sandboxing.sh

clk command create python --group http
cat<<EOF >> "${CLKCONFIGDIR}/python/http.py"
class HTTPConfig:
    pass

@group()
@option("--bearer", help="The bearer token to request the API", prompt=True, confirmation_prompt=True, hide_input=True, expose_class=HTTPConfig)
@option("--base-url", help="The url of the site to play with", expose_class=HTTPConfig)
def http():
    "Commands to play with some OAuth 2 protected site"

@http.command()
@argument("path", help="The endpoint to call")
def get(path):
    "Perform a get request from the site"
    print(f"Calling {config.http.base_url}/{path} with bearer token {config.http.bearer}")

EOF



setsecretinparameter_code () {
      clk parameter set http --bearer mytoken
}

setsecretinparameter_expected () {
      cat<<"EOEXPECTED"
New global parameters for http: --bearer mytoken
EOEXPECTED
}

diff -uBw <(setsecretinparameter_code 2>&1) <(setsecretinparameter_expected) || {
echo "Something went wrong when trying setsecretinparameter"
exit 1
}



usesecretinparameter_code () {
      clk http --base-url someurl get someendpoint
}

usesecretinparameter_expected () {
      cat<<"EOEXPECTED"
Calling someurl/someendpoint with bearer token mytoken
EOEXPECTED
}

diff -uBw <(usesecretinparameter_code 2>&1) <(usesecretinparameter_expected) || {
echo "Something went wrong when trying usesecretinparameter"
exit 1
}



usethebearefromsecret_code () {
      clk parameter set http --bearer noeval:secret:http_bearer
}

usethebearefromsecret_expected () {
      cat<<"EOEXPECTED"
Removing global parameters of http: --bearer mytoken
New global parameters for http: --bearer secret:http_bearer
EOEXPECTED
}

diff -uBw <(usethebearefromsecret_code 2>&1) <(usethebearefromsecret_expected) || {
echo "Something went wrong when trying usethebearefromsecret"
exit 1
}



httpwithsecretfail_code () {
      clk http --base-url someurl get someendpoint
}

httpwithsecretfail_expected () {
      cat<<"EOEXPECTED"
error: Could not find the secret for http_bearer
EOEXPECTED
}

diff -uBw <(httpwithsecretfail_code 2>&1) <(httpwithsecretfail_expected) || {
echo "Something went wrong when trying httpwithsecretfail"
exit 1
}



# GENERATED USING AUTOEXPECT
cat<<"EOEXPECT" > "pass.exp"
#!/usr/bin/expect -f
#
# This Expect script was generated by autoexpect on Wed Jun 21 10:25:46 2023
# Expect and autoexpect were both written by Don Libes, NIST.
#
# Note that autoexpect does not guarantee a working script.  It
# necessarily has to guess about certain things.  Two reasons a script
# might fail are:
#
# 1) timing - A surprising number of programs (rn, ksh, zsh, telnet,
# etc.) and devices discard or ignore keystrokes that arrive "too
# quickly" after prompts.  If you find your new script hanging up at
# one spot, try adding a short sleep just before the previous send.
# Setting "force_conservative" to 1 (see below) makes Expect do this
# automatically - pausing briefly before sending each character.  This
# pacifies every program I know of.  The -c flag makes the script do
# this in the first place.  The -C flag allows you to define a
# character to toggle this mode off and on.

set force_conservative 0  ;# set to 1 to force conservative mode even if
              ;# script wasn't run conservatively originally
if {$force_conservative} {
    set send_slow {1 .1}
    proc send {ignore arg} {
        sleep .1
        exp_send -s -- $arg
    }
}

#
# 2) differing output - Some programs produce different output each time
# they run.  The "date" command is an obvious example.  Another is
# ftp, if it produces throughput statistics at the end of a file
# transfer.  If this causes a problem, delete these patterns or replace
# them with wildcards.  An alternative is to use the -p flag (for
# "prompt") which makes Expect only look for the last line of output
# (i.e., the prompt).  The -P flag allows you to define a character to
# toggle this mode off and on.
#
# Read the man page for more info.
#
# -Don


set timeout -1
spawn clk --ask-secret http --base-url someurl get someendpoint
match_max 100000
expect -exact "warning: Could not find the secret for http_bearer\r
Please provide the secret http_bearer: "
send -- "test\r"
expect -exact "\r
Repeat for confirmation: "
send -- "test\r"
expect eof
EOEXPECT



call_ask_for_real_code () {
      expect pass.exp |tail -n+2
}

call_ask_for_real_expected () {
      cat<<"EOEXPECTED"
warning: Could not find the secret for http_bearer
Please provide the secret http_bearer:
Repeat for confirmation:
Calling someurl/someendpoint with bearer token test
EOEXPECTED
}

diff -uBw <(call_ask_for_real_code 2>&1) <(call_ask_for_real_expected) || {
echo "Something went wrong when trying call_ask_for_real"
exit 1
}



# GENERATED USING AUTOEXPECT
cat<<"EOEXPECT" > "passerror.exp"
#!/usr/bin/expect -f
#
# This Expect script was generated by autoexpect on Wed Jun 21 10:25:46 2023
# Expect and autoexpect were both written by Don Libes, NIST.
#
# Note that autoexpect does not guarantee a working script.  It
# necessarily has to guess about certain things.  Two reasons a script
# might fail are:
#
# 1) timing - A surprising number of programs (rn, ksh, zsh, telnet,
# etc.) and devices discard or ignore keystrokes that arrive "too
# quickly" after prompts.  If you find your new script hanging up at
# one spot, try adding a short sleep just before the previous send.
# Setting "force_conservative" to 1 (see below) makes Expect do this
# automatically - pausing briefly before sending each character.  This
# pacifies every program I know of.  The -c flag makes the script do
# this in the first place.  The -C flag allows you to define a
# character to toggle this mode off and on.

set force_conservative 0  ;# set to 1 to force conservative mode even if
              ;# script wasn't run conservatively originally
if {$force_conservative} {
    set send_slow {1 .1}
    proc send {ignore arg} {
        sleep .1
        exp_send -s -- $arg
    }
}

#
# 2) differing output - Some programs produce different output each time
# they run.  The "date" command is an obvious example.  Another is
# ftp, if it produces throughput statistics at the end of a file
# transfer.  If this causes a problem, delete these patterns or replace
# them with wildcards.  An alternative is to use the -p flag (for
# "prompt") which makes Expect only look for the last line of output
# (i.e., the prompt).  The -P flag allows you to define a character to
# toggle this mode off and on.
#
# Read the man page for more info.
#
# -Don


set timeout -1
spawn clk --ask-secret http --base-url someurl get someendpoint
match_max 100000
expect -exact "warning: Could not find the secret for http_bearer\r
Please provide the secret http_bearer: "
send -- "something\r"
expect -exact "\r
Repeat for confirmation: "
send -- "somethingelse\r"
expect -exact "Error: The two entered values do not match.\r"
expect -exact "Please provide the secret http_bearer:"
EOEXPECT



call_ask_for_real_error_code () {
      expect passerror.exp |tail -n+2
}

call_ask_for_real_error_expected () {
      cat<<"EOEXPECTED"
warning: Could not find the secret for http_bearer
Please provide the secret http_bearer:
Repeat for confirmation:
Error: The two entered values do not match.
Please provide the secret http_bearer:
EOEXPECTED
}

diff -uBw <(call_ask_for_real_error_code 2>&1) <(call_ask_for_real_error_expected) || {
echo "Something went wrong when trying call_ask_for_real_error"
exit 1
}



try-completion_code () {
      clk completion try --remove-bash-formatting --last http --base-ur
}

try-completion_expected () {
      cat<<"EOEXPECTED"
--base-url
EOEXPECTED
}

diff -uBw <(try-completion_code 2>&1) <(try-completion_expected) || {
echo "Something went wrong when trying try-completion"
exit 1
}



try-completion-without-ask-secret_code () {
      clk --ask-secret completion try --remove-bash-formatting --last http --base-ur
}

try-completion-without-ask-secret_expected () {
      cat<<"EOEXPECTED"
--base-url
EOEXPECTED
}

diff -uBw <(try-completion-without-ask-secret_code 2>&1) <(try-completion-without-ask-secret_expected) || {
echo "Something went wrong when trying try-completion-without-ask-secret"
exit 1
}


clk secret set --set-parameter global --secret mytoken

clk secret set http_bearer


showsecret_code () {
      clk secret show http_bearer
}

showsecret_expected () {
      cat<<"EOEXPECTED"
http_bearer *****
EOEXPECTED
}

diff -uBw <(showsecret_code 2>&1) <(showsecret_expected) || {
echo "Something went wrong when trying showsecret"
exit 1
}



reallyshowsecret_code () {
      clk secret show http_bearer --secret
}

reallyshowsecret_expected () {
      cat<<"EOEXPECTED"
http_bearer mytoken
EOEXPECTED
}

diff -uBw <(reallyshowsecret_code 2>&1) <(reallyshowsecret_expected) || {
echo "Something went wrong when trying reallyshowsecret"
exit 1
}



reallyshowonlysecret_code () {
      clk secret show http_bearer --secret --field secret
}

reallyshowonlysecret_expected () {
      cat<<"EOEXPECTED"
mytoken
EOEXPECTED
}

diff -uBw <(reallyshowonlysecret_code 2>&1) <(reallyshowonlysecret_expected) || {
echo "Something went wrong when trying reallyshowonlysecret"
exit 1
}



httpwithsecret_code () {
      clk http --base-url someurl get someendpoint
}

httpwithsecret_expected () {
      cat<<"EOEXPECTED"
Calling someurl/someendpoint with bearer token mytoken
EOEXPECTED
}

diff -uBw <(httpwithsecret_code 2>&1) <(httpwithsecret_expected) || {
echo "Something went wrong when trying httpwithsecret"
exit 1
}


clk command create python dosomething --force
cat<<EOF >> "${CLKCONFIGDIR}/python/dosomething.py"
from clk import get_secret

@command()
def dosomething():
    'Example of using secrets'
    click.echo(get_secret('http_bearer'))
EOF


showgetsecret_code () {
      clk dosomething
}

showgetsecret_expected () {
      cat<<"EOEXPECTED"
mytoken
EOEXPECTED
}

diff -uBw <(showgetsecret_code 2>&1) <(showgetsecret_expected) || {
echo "Something went wrong when trying showgetsecret"
exit 1
}


clk parameter set secret.unset --force

clk secret unset http_bearer


checkthatthesecretisgone_code () {
      clk secret show http_bearer
}

checkthatthesecretisgone_expected () {
      cat<<"EOEXPECTED"
warning: No secret set
EOEXPECTED
}

diff -uBw <(checkthatthesecretisgone_code 2>&1) <(checkthatthesecretisgone_expected) || {
echo "Something went wrong when trying checkthatthesecretisgone"
exit 1
}


cat <<EOF > "${CLK_NETRC_LOCATION}"
machine http_bearer
password thevalue
EOF


using_netrc_code () {
      clk --keyring clk.keyrings.NetrcKeyring secret show http_bearer --secret
}

using_netrc_expected () {
      cat<<"EOEXPECTED"
http_bearer thevalue
EOEXPECTED
}

diff -uBw <(using_netrc_code 2>&1) <(using_netrc_expected) || {
echo "Something went wrong when trying using_netrc"
exit 1
}
# test ends here
