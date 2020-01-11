## Cypress with Docker

Debugging a `Failed to connect to the bus: Failed to connect to socket /run/dbus/system_bus_socket: No such file or directory` error message

## Test environment

* docker: Docker version 19.03.5-ce, build 633a0ea838
* docker-compose: docker-compose version 1.25.1, build unknown
* bash: 5.0.11(1)-release
* kernel: Linux 5.4.10-arch1-1

## Execution

* ./test-all.sh

## Errors

When using ELECTRON_ENABLE_LOGGING=true

````
[...]

>>> Running test *with* Electron logging:  ELECTRON_ENABLE_LOGGING=true
Fontconfig warning: "/etc/fonts/fonts.conf", line 100: unknown element "blank"
[17:0111/175459.790006:ERROR:bus.cc(393)] Failed to connect to the bus: Failed to connect to socket /var/run/dbus/system_bus_socket: No such file or directory

[...]

[17:0111/175503.921736:ERROR:bus.cc(393)] Failed to connect to the bus: Address does not contain a colon
[215:0111/175504.814871:ERROR:child_process_sandbox_support_impl_linux.cc(81)] FontService unique font name matching request did not receive a response.
[215:0111/175504.821682:ERROR:child_process_sandbox_support_impl_linux.cc(81)] FontService unique font name matching request did not receive a response.
[215:0111/175504.822100:ERROR:child_process_sandbox_support_impl_linux.cc(81)] FontService unique font name matching request did not receive a response.

[...]
````

## Fixing the errors

By [exposing](https://docs.docker.com/storage/bind-mounts/) the host
socket `/var/run/dbus/system_bus_socket` to the container we remove
the error.

### Credits

* The fix was inspired by the documentation of [x11docker](https://github.com/mviereck/x11docker)
  https://github.com/mviereck/x11docker/wiki/How-to-connect-container-to-DBus-from-host