import sys
from omniORB import CORBA, PortableServer, importIDL
import CosNaming

importIDL('Ping.idl')
Example = sys.modules['Example']
Example__POA = sys.modules['Example__POA']

class Pingable_i(Example__POA.Pingable):
    def ping(self):
        print('pinged')

orb = CORBA.ORB_init(sys.argv, CORBA.ORB_ID)
poa = orb.resolve_initial_references('RootPOA')

obj = orb.resolve_initial_references('NameService')
root_context = obj._narrow(CosNaming.NamingContext)

if not root_context:
    print('Failed to narrow the root naming context')
    sys.exit(1)

# Bind the root context
name = [CosNaming.NameComponent('test', '')]
try:
    test_context = root_context.bind_new_context(name)
    print('New test context bound')
except CosNaming.NamingContext.AlreadyBound, ex:
    print('Test context already exists')
    obj = root_context.resolve(name)
    test_context = obj._narrow(CosNaming.NamingContext)
    if test_context is None:
        print('test exists but is not a NamingContext')
        sys.exit(1)

# bind echo object to the test context
pi = Pingable_i()
po = pi._this()
name = [CosNaming.NameComponent('ExamplePing', '')]
try:
    test_context.bind(name, po)
    print('New Ping object bound')
except CosNaming.NamingContext.AlreadyBound:
    test_context.rebind(name, po)
    print('Ping binding already existed, rebound')

poa_manager = poa._get_the_POAManager()
poa_manager.activate()

orb.run()
