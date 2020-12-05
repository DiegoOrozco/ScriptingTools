#!/bin/bash
MAIL=0
DETAILS=0
HELP=0
AUTO=0
ADDRESS=""
#LOGPATH="." # Testing path (same directory)
LOGPATH=/home/vadmin/scripts/temps
#ABSPATH="." # Testing path (same directory)
ABSPATH="/home/vadmin/scripts/monitoring/dhcp" # Production path

function main()
{
	parseArguments "$@"

	if [[ -f $LOGPATH/dhcp_report.log ]]; then
		echo "" > $LOGPATH/dhcp_report.log
	fi

	if [[ $# -eq 0 ]] || [[ $AUTO -eq 1 ]]; then
		if [[ $AUTO -eq 0 ]]; then
			printf 'Command ran\n'
		fi
		echo '    Date                MAC Address             Host            IP Address      State' > dhcp_report.log
		journalctl -u dhcpd -n 500 --no-pager > $LOGPATH/log_dhcp.txt
		awk -f $ABSPATH/dhcp.awk $LOGPATH/log_dhcp.txt >> $LOGPATH/dhcp_report.log
	fi

	if [[ $HELP -eq 1 ]]; then
		printHelp $0
	fi

	if [[ $DETAILS -eq 1 ]]; then
		hostname
		printf '\tDate\t\tMAC Address\t\tHost\t\tIP Address\tState\n'
		journalctl -u dhcpd -n 500 --no-pager > $LOGPATH/log_dhcp.txt
		awk -f $ABSPATH/dhcp.awk $LOGPATH/log_dhcp.txt
	fi

	if [[ $MAIL -eq 1 ]]; then
		isInstalled
		journalctl -u dhcpd -n 500 --no-pager > $LOGPATH/log_dhcp.txt
		awk -f $ABSPATH/dhcp.awk $LOGPATH/log_dhcp.txt >> $LOGPATH/dhcp_report.log
		enscript $LOGPATH/dhcp_report.log -o - | ps2pdf - $LOGPATH/dhcp_report.pdf  
		cat $ABSPATH/dhcp_report.log | mailx -v -r "virtualcollaboard@gmail.com" -s "DHCP REPORT - VIRTUALCOLLABOARD" -a $ABSPATH/dhcp_report.pdf $ADDRESS
		printf 'Mail sent to %s\n' $ADDRESS
	fi
}

function parseArguments()
{
	while (( "$#" )); do
	  case "$1" in
	    -m|--mail)
	      MAIL=1
	      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
	        ADDRESS=$2
	        shift 2
	      else
	        echo "Error: Missing mail address" >&2
	        exit 1
	      fi
	      ;;
  	    -d|--details)
	      DETAILS=1
	      shift
	      ;;
      	-a|--auto)
	      AUTO=1
	      shift
	      ;;
  	    -h|--help)
	      HELP=1
	      shift
	      ;;	      
	    -*|--*=) # unsupported flags
	      echo "Error: Unsupported flag $1" >&2
	      exit 1
	      ;;
	    *) # preserve positional arguments
	      PARAMS="$PARAMS $1"
	      shift
	      ;;
	  esac
	done

	eval set -- "$PARAMS"
}

function printHelp()
{
	echo "Usage:" $1 "[options]"
	echo "Options:"
	printf "\t%s\n" "-m --mail: Mails report to Virtualcollaboard mail account"
	printf "\t%s\n" "-d --details: Show report in terminal"
}


function isInstalled {
	if yum list installed ghostscript >/dev/null 2>&1; then
		if yum list installed enscript >/dev/null 2>&1; then
			if yum list installed mailx >/dev/null 2>&1; then
			    true
			else
				yum -y install mailx
			fi 
		else
			yum install enscript -y
		fi
	else
	  	yum install ghostscript -y
	    yum install enscript -y
		yum -y install mailx 
	fi
}


# Pass arguments as-is
main "$@"
