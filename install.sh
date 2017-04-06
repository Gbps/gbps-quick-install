echo "=============== Gbps Startup Script ==============="
if [ "$EUID" -ne 0 ]
then 
    echo "Please run as root!"
    echo "sudo $0" 
    exit
fi

function execute_cmd
{
    echo "> $@"
    exec $@
}

execute_cmd echo Hello

