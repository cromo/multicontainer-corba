import sys
import Example
from org.omg import CORBA as corba, CosNaming as naming, PortableServer

class Ping_i(Example.PingablePOA):
    def ping(self):
        print("Pinged")

orb = corba.ORB.init([], None)
poa = PortableServer.POAHelper.narrow(orb.resolve_initial_references("RootPOA"))
poa.the_POAManager().activate()
nc = naming.NamingContextExtHelper.narrow(orb.string_to_object(sys.argv[1]))

pingable = Ping_i()
name = nc.to_name("test/ExamplePing")
po = poa.servant_to_reference(pingable)
nc.rebind(name, po)

orb.run()
