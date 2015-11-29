import sys
import org.omg.CORBA, org.omg.CosNaming, Example
from org.omg import CORBA, CosNaming

orb = CORBA.ORB.init([], None)
o = orb.string_to_object(sys.argv[1])
nc = CosNaming.NamingContextExtHelper.narrow(o)
o = nc.resolve_str("test/ExamplePing")
po = Example.PingableHelper.narrow(o)
po.ping()
