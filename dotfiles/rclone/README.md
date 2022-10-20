The set of files in this folder define a user systemd service that calls
the rclone-sync bash script on a predefined frequency.

To make this work, you need to enable and start the systemd service.

First, import PATH from the environment.

```
systemctl --user import-environment PATH
```

Then, enable and start the timer unit.

```
systemctl --user enable rclone-sync.timer
systemctl --user start rclone-sync.timer
```

You can see the logs of the service with this command.

```
journalctl --user -u rclone-sync
```
