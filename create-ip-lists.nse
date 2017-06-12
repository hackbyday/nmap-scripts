id="IP List Creator"
description="Script to output files containing ip list of open ports"
author = "Hack by Day <hackbyday@gmail.com>"
license = "Same as Nmap--See http://nmap.org/book/man-legal.html"
categories = {"default", "safe"}

==[[

Notes:

- files are created with output prefix of "iplist." followed by port number
  unless prefix specified
  e.g. iplist.3389

- prefix can be specified using script arg 'prefix'
  e.g. --script-args prefix="test"
  e.g. --script-args prefix="/temp/test"

]]

portrule = function(host, port)
	if port.state == "open" or 
	   port.state == "open|filtered" 
	then
		return true
	else
		return false
	end
end

action = function(host, port)
	local file_prefix = nmap.registry.args.prefix
	if file_prefix == nil then
		file = io.open("iplist." .. tostring(port.number), "a+")
	else
		file = io.open(tostring(file_prefix) .. "." .. tostring(port.number), "a+")
	end
	file:write(host.ip .. "\n")
	file:close()
end
