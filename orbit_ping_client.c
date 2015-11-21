#include <assert.h>
#include <signal.h>
#include <stdio.h>

#include <orbit/orbit.h>
#include <ORBitservices/CosNaming.h>
#include <ORBitservices/CosNaming_impl.h>

#include "Ping.h"

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

int main(int argc, char* argv[]) {

    g_print("Client>starting client...\n");
    g_print("Client>creating and initializing the ORB\n");
    CORBA_Environment ev;
    CORBA_exception_init(&ev);
    abort_if_exception(&ev, "CORBA_exception_init failed");

    CORBA_ORB orb = CORBA_OBJECT_NIL;
    orb = CORBA_ORB_init(&argc, argv, "orb", &ev);
    abort_if_exception(&ev, "CORBA_ORB_init failed");

    CosNaming_NamingContext ns = CORBA_OBJECT_NIL;
    ns = (CosNaming_NamingContext)CORBA_ORB_string_to_object(orb, argv[1], &ev);
    abort_if_exception(&ev, "CORBA_ORB_string_to_object failed");

    CORBA_char test_context[] = "test";
    CORBA_char ping_object[] = "ExamplePing";
    CosNaming_NameComponent path[2] = {
        {test_context, ""},
        {ping_object, ""}
    };
    CosNaming_Name name = {2, 2, path, CORBA_FALSE};
    g_print("Client>Resolving the object reference in naming '%s/%s'\n",
        test_context, ping_object);
    Example_Pingable service = CORBA_OBJECT_NIL;
    service = (Example_Pingable)CosNaming_NamingContext_resolve(ns, &name, &ev);
    abort_if_exception(&ev, "resolve failed");

    g_print("Client>calling the Ping service...\n");
    Example_Pingable_ping(service, &ev);
    abort_if_exception(&ev, "Example_Pingable_ping failed");

    CORBA_Object_release(service, &ev);
    abort_if_exception(&ev, "release failed");

    if (orb != CORBA_OBJECT_NIL) {
        CORBA_ORB_destroy(orb, &ev);
        abort_if_exception(&ev, "destroy failed");
    }

    return 0;
}
