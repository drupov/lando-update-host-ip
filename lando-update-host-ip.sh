#!/bin/bash

# Get the host ip - the one that changed after the network switch.
hostip=`lando config --path appEnv.LANDO_HOST_IP`
# Strip the quotes from the output.
hostip=`echo $hostip | cut -d "'" -f 2`

# Get the current value of the LANDO_HOST_IP within the contaner.
containerip=`lando ssh -c "printenv LANDO_HOST_IP"`
# Remove the last character from the received value.
containerip=${containerip%?}

if [ $hostip != $containerip ]
then
	echo "Updating host ip in container..."
	echo "You might be asked for the sudo password, as it is needed to stop/start docker and change its configuration."
	# Stop the docker service.
	sudo service docker stop
	# Replace the IP with the new one for all docker containers.
	sudo find /var/lib/docker/containers -type f -name "*" -exec sed -i'' -e "s/$containerip/$hostip/g" {} +
	# Start the docker service.
	sudo service docker start
	# Restart the app after the docker restart.
	lando restart
else
	echo "No change needed."
fi
