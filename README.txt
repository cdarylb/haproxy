Script to manage servers in HaProxy - Read README.TXT
Copyright (c) Cyril Beaufrere <cyril.beaufrere@gmail.com>
Version: 1.1
Last Modified: 10 Janvier 2013
License: This software can be used for free unless I meet you, then you owe me lunch.

Usage: wwwcluster.sh -d| -e| -a| -h| -m| -s [webserver]

Options:

-d [webserver]: To disable server
-e [webserver]: To enable server
-a: Enable all servers
-h: This stupid help
-m: Disable all servers (maintenance mode)
-s: Show status of all web servers

Examples:

- Remove web1 from cluster:

prod@lb1:~# ./wwwcluster.sh -d web1
----------------------------------  
Do you want to disable web1? (y/n)
----------------------------------  
y

web1 ===> MAINT
prod@lb1:~# 

- Add web1 in cluster:

prod@lb1:~# ./wwwcluster.sh -e web1
----------------------------------  
Do you want to enable web1? (y/n)
----------------------------------  
y

web1 ===> UP
prod@lb1:~# 

etc, etc...
