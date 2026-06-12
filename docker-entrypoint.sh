#!/bin/bash

# Change ownership of GPIO devices to the 'gpio' group
# and grant read/write access to that group.
if [ -e /dev/gpiochip0 ]; then
    sudo chgrp gpio /dev/gpiochip*
    sudo chmod g+rw /dev/gpiochip*
fi

# If you also need access to gpiomem
if [ -e /dev/gpiomem ]; then
    sudo chgrp gpio /dev/gpiomem
    sudo chmod g+rw /dev/gpiomem
fi

# Seed the configuration if missing
if [ ! -f /etc/pymc_repeater/config.yaml ]; then
    echo "Initializing default configuration..."
    sudo cp /opt/pymc_repeater/config.yaml.example /etc/pymc_repeater/config.yaml
    sudo chown repeater:repeater /etc/pymc_repeater/config.yaml
fi

# Now run the application
exec "$@"
