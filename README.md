wwwcluster.sh
==========

Another haproxy control and management tool

About
--------

wwwcluster.sh is a tool to manage haproxy with his socket.

It can to do the following:

* status  -  Lists all servers with status.
* enable  -  Enable a server.
* disable  - Disable a server. 
* maintenance  - Disable all servers, active maintenance mode.

Usage
------

```
Usage: wwwcluster.sh -d| -e| -a| -h| -m| -s [webserver]

Options:

-d [webserver]: To disable server
-e [webserver]: To enable server
-a: Enable all servers
-h: This stupid help
-m: Disable all servers (maintenance mode)
-s: Show status of all web servers

```
