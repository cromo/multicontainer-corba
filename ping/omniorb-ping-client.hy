(import sys
	[omniORB [CORBA :as corba importIDL]])

(importIDL "Ping.idl")
(def orb (.ORB-init corba sys.argv))
(def pingable-object (.string-to-object orb (get sys.argv 1)))
(.ping pingable-object)
