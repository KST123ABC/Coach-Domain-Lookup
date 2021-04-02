#! /bin/bash

printf 'Enter as many domains as you want to check(can be one at a time, multiple per line, or copy and paste). Type \"exit\" to quit...\n'

# Runs whois, gets server strings, checks strings for DDC.
# If 1 or more matches: Yes; Else: No
ddc_check (){
for d in $@
do
	wddc=`whois -h whois.domain.com $d | grep -A1 "Registrar WHOIS Server:"`
        wgdr=`whois -h whois.porkbun.com $d | grep -A1 "Registrar WHOIS Server:"`
        if [[ $wddc == *"domain.com"* ]]; then
                printf "\n$d - YES! - Domain.com\n"
        elif [[ $wgdr == *"porkbun.com"* ]]; then
                printf "\n $d - YES! - GoDaddy Registry\n"
	else
		printf "\n        $d - NO!\n"
	fi
done
}

# Stops when user types "exit"
# Calls DDC_Check with all params
while true
do
	read varname
	if [[ $varname == "exit" ]]; then exit 0; fi
	ddc_check $varname
done
