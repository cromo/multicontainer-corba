import java.io.*;
import org.omg.CORBA.*;
import org.omg.CosNaming.*;
import Example.*;

public class JacorbPingClient {
    public static void main(String[] args) {
	ORB orb = ORB.init(args, null);
	org.omg.CORBA.Object o = null;
	try {
	    o = orb.resolve_initial_references("NameService");
	    // o = orb.string_to_object("corbaloc:iiop:nameservice:2809/NameService");
	} catch (org.omg.CORBA.ORBPackage.InvalidName e) {
	    System.out.println("Invalid name for rir");
	}
	NamingContextExt nc = NamingContextExtHelper.narrow(o);
	try {
	    o = nc.resolve_str("test/ExamplePing");
	} catch (org.omg.CosNaming.NamingContextPackage.NotFound e) {
	    System.out.println("Unable to resolve name");
	} catch (org.omg.CosNaming.NamingContextPackage.CannotProceed e) {
	    System.out.println("Can't proceed to lookup name");
	} catch (org.omg.CosNaming.NamingContextPackage.InvalidName e) {
	    System.out.println("Invalid name for string resolve");
	}
	Pingable po = PingableHelper.narrow(o);
	po.ping();
    }
}
