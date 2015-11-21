import java.io.*;
import org.omg.CORBA.*;
import org.omg.CosNaming.*;
import Example.*;

public class JacorbPingServer {
    static class Ping_i extends PingablePOA {
	public void ping() {
	    System.out.println("Pinged");
	}
    }

    public static void main(String[] args) {
	ORB orb = ORB.init(args, null);
	org.omg.CORBA.Object o = null;
	try {
	    o = orb.resolve_initial_references("RootPOA");
	} catch (org.omg.CORBA.ORBPackage.InvalidName e) {
	    System.out.println("Unable to get root POA");
	    return;
	}
	org.omg.PortableServer.POA poa = org.omg.PortableServer.POAHelper.narrow(o);
	try {
	    poa.the_POAManager().activate();
	} catch (org.omg.PortableServer.POAManagerPackage.AdapterInactive e) {
	    System.out.println("POA manager adapter inactive");
	    return;
	}

	try {
	    o = orb.resolve_initial_references("NameService");
	    // o = orb.string_to_object("corbaloc:iiop:nameservice:2809/NameService");
	} catch (org.omg.CORBA.ORBPackage.InvalidName e) {
	    System.out.println("Invalid name for rir");
	    return;
	}
	NamingContextExt nc = NamingContextExtHelper.narrow(o);

	Ping_i pingable = new Ping_i();
	NameComponent[] name = null;
	try {
	    name = nc.to_name("test/ExamplePing");
	} catch (org.omg.CosNaming.NamingContextPackage.InvalidName e) {
	    System.out.println("Invalid name");
	    return;
	}
	try {
	    o = poa.servant_to_reference(pingable);
	} catch (org.omg.PortableServer.POAPackage.ServantNotActive e) {
	    System.out.println("Servant not active");
	    return;
	} catch (org.omg.PortableServer.POAPackage.WrongPolicy e) {
	    System.out.println("Wrong policy");
	    return;
	}
	try {
	    nc.rebind(name, o);
	} catch (org.omg.CosNaming.NamingContextPackage.NotFound e) {
	    System.out.println("Unable to resolve name");
	} catch (org.omg.CosNaming.NamingContextPackage.CannotProceed e) {
	    System.out.println("Can't proceed to lookup name");
	} catch (org.omg.CosNaming.NamingContextPackage.InvalidName e) {
	    System.out.println("Invalid name for string resolve");
	}

	orb.run();
    }
}
