using System;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting;
using System.Threading;

using Ch.Elca.Iiop;
using Ch.Elca.Iiop.Services;
using omg.org.CosNaming;

// CORBA Servants must be public types.
public class PingImpl: MarshalByRefObject, Example.Pingable
{
    public override object InitializeLifetimeService()
    {
        // Live forever!
        return null;
    }

    public void ping()
    {
        Console.WriteLine("Pinged");
    }
}

public class IiopNetPingServer
{
    static public void Main(string[] args)
    {
	try
	{
	    IiopChannel channel = new IiopChannel(0);
	    ChannelServices.RegisterChannel(channel, false);

	    CorbaInit init = CorbaInit.GetInit();
	    NamingContext nc = (NamingContext)RemotingServices.Connect(
	        typeof(NamingContext), args[0]);
	    PingImpl pingable = new PingImpl();
	    nc.rebind(new NameComponent[] {
		    new NameComponent("test"),
		    new NameComponent("ExamplePing")
		}, pingable);
	    Thread.Sleep(Timeout.Infinite);
	}
	catch (Exception e)
	{
	    Console.WriteLine(e);
	}
    }
}