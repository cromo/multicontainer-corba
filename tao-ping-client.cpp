#include <iostream>

#include "PingC.h"

int main(int argc, char** argv) {
    try {
        CORBA::ORB_var orb = CORBA::ORB_init(argc, argv);
        CORBA::Object_var po = orb->string_to_object("corbaname::nameservice/NameService#test/ExamplePing");
        Example::Pingable_var pingable = Example::Pingable::_narrow(po.in());
        pingable->ping();
        orb->destroy();
    } catch (CORBA::Exception const& e) {
        std::cerr << "CORBA exception raised: " << e._name() << ": " << e._info().c_str() << '\n';
    }
    return 0;
}
