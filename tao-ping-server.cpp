#include <iostream>

#include <orbsvcs/CosNamingC.h>

#include "PingS.h"

class Ping_i : public POA_Example::Pingable {
public:
    void ping() {
        std:: cout << "Pinged\n";
    }
};

int main(int argc, char** argv) {
    try {
        CORBA::ORB_var orb = CORBA::ORB_init(argc, argv);
        CORBA::Object_var object = orb->resolve_initial_references("RootPOA");
        PortableServer::POA_var poa = PortableServer::POA::_narrow(object.in());
        PortableServer::POAManager_var poa_manager = poa->the_POAManager();
        poa_manager->activate();

        Ping_i pingable;
        Example::Pingable_var pingable_object = pingable._this();

        // This is the easy way to get a reference to the nameservice if the
        // hostname is known. In this case, the hostname is "nameservice".
        object = orb->string_to_object("corbaloc::nameservice/NameService");
        CosNaming::NamingContextExt_var naming_context =
            CosNaming::NamingContextExt::_narrow(object.in());

        CosNaming::Name_var name;
        name = naming_context->to_name("test/ExamplePing");
        naming_context->rebind(name.in(), pingable_object.in());

        // This is the textbook way of doing this. This also skips the step of
        // making the outer context if it doesn't exist, which is essential to
        // the operation of the program.

        // object = orb->resolve_initial_references("NameService");
        // CosNaming::NamingContext_var naming_context = CosNaming::NamingContext::_narrow(object.in());
        // CosNaming::Name name(1);
        // name.length(2);
        // name[0].id = CORBA::string_dup("test");
        // name[1].id = CORBA::string_dup("ExamplePing");

        // try {
        //     naming_context->bind(name, pingable_object.in());
        //     std::cout << "New context bound\n";
        // } catch (CosNaming::NamingContext::AlreadyBound const& e) {
        //     naming_context->rebind(name, pingable_object);
        //     std::cout << "Ping binding already existed, rebound\n";
        // }

        orb->run();

        poa->destroy(1, 1);
        orb->destroy();
    } catch (CORBA::Exception const& e) {
        std::cerr << "CORBA exception raised: " << e._name();
    }
    return 0;
}
