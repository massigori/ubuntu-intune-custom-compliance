#!/bin/dash

log="$HOME/compliance.log"
echo "$(date) | Starting compliance script" >> $log

# Specify the processes the script should be searching for
processes="msedge gnome-shell"

# iterate over the processes and determine which ones are running
numProcesses=$(echo "$processes" | awk -F" " '{print NF-1}')
numProcesses=$((numProcesses+1))

iteration=0

echo -n "{"
echo "$processes" | tr ' ' '\n' | while read process; do
  echo -n "$(date) |   + Process [$process]..." >> $log
    iteration=$((iteration+1))
    if pgrep -l "$process" > /dev/null; then
        echo -n "\"$process\": \"Running\""
        echo "Running" >> $log
    else
        echo -n "\"$process\": \"NotRunning\""
        echo "NotRunning" >> $log
    fi

    if [ $iteration -le $numProcesses ];then
       echo -n ","
    fi

done

# Check if Ubuntu pro subscription is attached and security services are enabled 
proStatus=$(pro status --all --format json)
attached=$(echo $proStatus | jq '.attached')

echo -n "$(date) |   + Ubuntu Pro subscription attached..." >> $log
if $attached; then
    echo -n "\"pro-Subscription\": \"attached\","
    echo "true" >> $log
    livepatchStatus=$(echo $proStatus | jq '.services[]| select(.name|match("livepatch"))|.status')
    echo -n "\"livepatch\": $livepatchStatus,"
    echo "$(date) |   + Livepatch service status...$livepatchStatus" >> $log
    esmappsStatus=$(echo $proStatus | jq '.services[]| select(.name|match("esm-apps"))|.status')
    echo -n "\"esm-apps\": $esmappsStatus,"
    echo "$(date) |   + esm-apps service status...$esmappsStatus" >> $log
    esminfraStatus=$(echo $proStatus | jq '.services[]| select(.name|match("esm-infra"))|.status')
    echo -n "\"esm-infra\": $esminfraStatus"
    echo "$(date) |   + esm-infra service status...$esminfraStatus" >> $log
else
    echo "false" >> $log
    echo -n "\"pro-Subscription\": \"detached\","
    echo "$(date) |   + esm-apps service status...disabled" >> $log
    echo -n "\"livepatch\": \"disabled\","
    echo "$(date) |   + esm-infra service status...disabled" >> $log
    echo -n "\"esm-infra\": \"disabled\","
    echo "$(date) |   + Livepatch service status...disabled" >> $log
    echo -n "\"esm-apps\": \"disabled\""
fi

echo "}"
echo "$(date) | Ending compliance script" >> $log