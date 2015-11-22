(import sys
	[omniORB [CORBA :as corba importIDL]]
	[CosNaming :as cosnaming])

(importIDL "Ping.idl")
(def example-poa (get sys.modules "Example__POA"))

(defclass pingable-i [example-poa.Pingable]
  [[ping (fn [self]
	     (print "Pinged"))]])

(def orb (.ORB-init corba sys.argv))
(def poa (.resolve-initial-references orb "RootPOA"))

(def pi (pingable-i))
(def po (.-this pi))

(def root-context (-> orb (.string-to-object (get sys.argv 1)) (.-narrow cosnaming.NamingContext)))

(when (none? root-context)
  (print "Failed to narrow the root naming context")
  (sys.exit 1))

(def name [(cosnaming.NameComponent (str "test") (str ""))])
(try
 (def test-context (.bind-new-context root-context name))
 (except [e cosnaming.NamingContext.AlreadyBound]
	 (print "test context already exists")
	 (def test-context (-> root-context
			       (.resolve name)
			       (.-narrow cosnaming.NamingContext)))
	 (when (none? test-context)
	   (print "test exists but is not a NamingContext")
	   (sys.exit 1)))
 (else (print "New test context bound")))

(def name [(cosnaming.NameComponent (str "ExamplePing") (str ""))])
(try
 (.bind test-context name po)
 (except [e cosnaming.NamingContext.AlreadyBound]
	 (.rebind test-context name po)
	 (print "ExamplePing already existed, rebound"))
 (else (print "New ExamplePing object bound")))

(-> poa .-get-the-POAManager .activate)
(.run orb)
