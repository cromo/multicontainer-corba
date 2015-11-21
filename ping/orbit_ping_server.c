#include <stdio.h>

#include <orbit/orbit.h>
#include <ORBitservices/CosNaming.h>
#include <ORBitservices/CosNaming_impl.h>

#include "Ping.h"
// Ick, including a source file is apparently the way to do this...
#include "Ping-skelimpl.c"

static gboolean raised_exception(CORBA_Environment *ev) {
    return ev->_major != CORBA_NO_EXCEPTION;
}

static void abort_if_exception(CORBA_Environment *ev, char const* message) {
    if (raised_exception(ev)) {
        g_error("%s %s", message, CORBA_exception_id(ev));
        CORBA_exception_free(ev);
        assert(0);
    }
}

int main(int argc, char *argv[]) {
    PortableServer_POA poa;
    Example_Pingable servant = CORBA_OBJECT_NIL;
    CosNaming_NamingContext ns = CORBA_OBJECT_NIL;
    CORBA_ORB orb = CORBA_OBJECT_NIL;
    CosNaming_NameComponent path[2] = {
        {"test", ""},
        {"ExamplePing", ""}
    };
    CosNaming_Name name = {2, 2, path, CORBA_FALSE};
    CORBA_Environment ev;

    printf("Server>starting server...\n");
    printf("Server>creating and initializing the ORB\n");
    CORBA_exception_init(&ev);
    abort_if_exception(&ev, "CORBA_exception_init failed");

    orb = CORBA_ORB_init(&argc, argv, "orb", &ev);
    abort_if_exception(&ev, "CORBA_ORB_init failed");

    printf("Server>getting reference to RootPOA\n");
    poa = (PortableServer_POA)CORBA_ORB_resolve_initial_references(orb, "RootPOA", &ev);
    abort_if_exception(&ev, "CORBA_ORB_resolve_initial_references 'RootPOA' failed");

    printf("Server>activating the POA Manager\n");
    PortableServer_POAManager_activate(PortableServer_POA__get_the_POAManager(poa, &ev), &ev);
    abort_if_exception(&ev, "POA_activate failed");

    printf("Server>creating the servant\n");
    servant = impl_Example_Pingable__create(poa, &ev);
    abort_if_exception(&ev, "Example_Pingable__create failed");

    ns = (CosNaming_NamingContext)CORBA_ORB_string_to_object(orb, argv[1], &ev);
    abort_if_exception(&ev, "CORBA_ORB_string_to_object failed");

    printf("Server>binding the object reference in naming with name 'test/ExamplePing'\n");
    CosNaming_NamingContext_rebind(ns, &name, servant, &ev);
    abort_if_exception(&ev, "rebind failed");

    printf("Server>running the orb...\n");
    CORBA_ORB_run(orb, &ev);
    abort_if_exception(&ev, "ORB_run failed");

    printf("Server>executing the release\n");
    CORBA_Object_release(servant, &ev);
    abort_if_exception(&ev, "Object_release failed");

    printf("Server>executing shutdown\n");
    CORBA_ORB_shutdown(orb, CORBA_FALSE, &ev);
    abort_if_exception(&ev, "shutdown failed");

    return 0;
}
