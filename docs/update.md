# Updating Your OpenHop Install

> 🚧 **Under Construction** — This document is a work in progress. Steps may be incomplete or change as the project evolves.

There are at least three methods to update your OpenHop installations, fleet or single system:

## Ugly but simple, no git or CLI involved

If you just want to update your fleet, don't want to use git, this is the crude but effective approach:

1. **Backup your OpenHop install** Use the gui under maintainence section to download your repeater settings. Use the full option so it saves your keys, etc

2. **Rename your balena OpenHop fleet** Use the balena cloud settings tab for your fleet, and rename it to something different. balena-openhop-old or similar. 

3. **Use the *Deploy with Balena* button** to create a new fleet, which will pull the latest OpenHop and balena-openhop code, build it, and have it ready to run.

4. **Set nodename and admin password variables** Optional step, by setting the admin password it will bypass the openhop setup menu. Likewise, any other variables can be set. 

5. Move your device to the new fleet** Use the balena clound control section to move your device to the newly created fleet. It will start up with defaults + any settings from env variables.

6. **Import your backup** Access the OpenHop gui like normal, and then import your backup. It will normally restart. You can ignore the "restart failed" notice, just hit refresh on your browser after a few seconds. 
Yes, this is embarrasingly crude. But is the only way I've found to force balena to rebuild an image with using command line git or similar commands.  


## Managing updates via git cli

This is the recommended approach. You have full control. But it does require a linux/mac host with git installed. Windows should work as well, but some of the commands may be slightly different. 

I'm going to add scripts to do these commands for you where possible. 

### Initial Setup

Before you can push updates to your balena fleet, you need a local copy of the repo and your balena account configured. You'll only need to do this once:

1. **Set up your balena account and add your SSH key**
   - Log into [balena-cloud.com](https://dashboard.balena-cloud.com)
   - Go to Preferences → SSH Keys and add your public key (add link to balena instructions for this)


2. **Note your balena username** — you'll need it for the git remote URL

3. **Clone the repo**
   ```bash
   git clone https://github.com/pinztrek/balena-openhop-repeater
   cd balena-openhop-repeater
   ```

4. **Add the balena fleet as a git remote**, substituting your *balena_username* and your balena-openhop fleet name:
   ```bash
   git remote add balena balena_username@git.balena-cloud.com:balena_username/balena-openhop-repeater.git
   ```

---

## Pushing an Update to Your Fleet

Once your local repo is set up, pushing an update to balena is a simple pull-and-push workflow:

```bash
git fetch origin
git checkout main
git pull origin main
git push balena main:master
```

Balena will detect the push, rebuild the container with the latest code, and deploy it to your devices automatically.

It will prompt you for your ssh private key, then build and push. Your OpenHop node will automatically detect the new release, install it and reboot. 

> **Note:** 
1. The `main:master` mapping is required — balena's git endpoint expects the `master` branch name regardless of what your upstream uses.

## Use the Balena CLI environment
Balena offers a command line environment that has full control over pushing releases to your balena environment. In some ways it's easier than using git, and operates similarly. But it is another thing to install, and more folks are familar with git. Same basic process as using git, balena has full docs. 

[← Back to README](../README.md)
