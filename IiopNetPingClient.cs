using System;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting;
using Ch.Elca.Iiop;
using Ch.Elca.Iiop.Services;
using omg.org.CosNaming;
 
public class IiopNetPingClient
{
    static public void Main(string[] args)
    {
	IiopClientChannel channel = new IiopClientChannel();
	ChannelServices.RegisterChannel(channel, false);

	NamingContext nc = (NamingContext)RemotingServices.Connect(
            typeof(NamingContext), args[0]);
	Example.Pingable pingable = (Example.Pingable)nc.resolve(
	    new NameComponent[] {
	        new NameComponent("test"),
	        new NameComponent("ExamplePing")
	    });

	pingable.ping();
    }
}