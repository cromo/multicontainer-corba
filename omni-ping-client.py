import sys
from omniORB import CORBA, PortableServer, importIDL
import CosNaming

importIDL('Ping.idl')
# Example = sys.modules['Example']
# Example__POA = sys.modules['Example__POA']

orb = CORBA.ORB_init(sys.argv, CORBA.ORB_ID)

def get_object_classic():
    """Resolve NameService#test/ExamplePing using the classic approach.

    According to the omniORBpy documentation, this is the main way to resolve
    an object reference from the name service. This approach involves first
    resolving the name service, then finding the context and narrowing it to
    the appropriate type.
    """
    obj = orb.resolve_initial_references('NameService')
    root_context = obj._narrow(CosNaming.NamingContext)
    if not root_context:
        print('Failed to narrow the root naming context')
        sys.exit(1)

    name = [CosNaming.NameComponent('test', ''),
        CosNaming.NameComponent('ExamplePing', '')]
    try:
        obj = root_context.resolve(name)
    except CosNaming.NamingContext.NotFound, ex:
        print('Name not found')
        sys.exit(1)

    po = obj._narrow(Example.Pingable)
    if not po:
        print('Object reference is not an Example::Ping')
        sys.exit(1)
    return po

def get_object_rir():
    """Resolve NameService#test/ExamplePing using a corbaname URI.

    A corbaname URI specifies how to contact the name service and a path
    within the nameservice to resolve. Because this is Python, if the type
    specified within the object reference is already loaded, omniORBpy can
    automatically narrow the object, skipping the manual narrowing step.
    """
    return orb.string_to_object('corbaname:rir:/NameService#test/ExamplePing')

po = get_object_rir()
po.ping()
