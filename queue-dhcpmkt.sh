:if ($leaseBound = "1") do={/queue simple add name=$leaseActIP target=$leaseActIP max-limit=1M/2M;} else={/queue simple remove $leaseActIP}
