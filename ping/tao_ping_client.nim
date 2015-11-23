{.compile: "PingC.cpp".}

import os

const pingc = "/source/PingC.h"

type
  # CorbaOrbPtr {.final, header: pingc, importcpp: "CORBA::ORB_ptr".} = object
  CorbaOrbVar {.final, header: pingc, importcpp: "CORBA::ORB_var".} = object
  CorbaObjectVar {.final, header:pingc, importcpp: "CORBA::Object_var".} =
    object
  ExamplePingableVar {.final, header:pingc,
                       importcpp: "Example::Pingable_var".} = object
  CorbaTransient {.final, header:pingc, importcpp: "CORBA::TRANSIENT".} = object of Exception

proc corbaOrbInit(argc: cint, argv: cstringArray): CorbaOrbVar
  {.header: pingc, importcpp: "CORBA::ORB_init(@)".}

proc stringToObject(orb: CorbaOrbVar, s: cstring): CorbaObjectVar
  {.header: pingc, importcpp: "#->string_to_object(@)".}

proc destroy(orb: CorbaOrbVar)
  {.header: pingc, importcpp: "#->destroy(@)".}

proc examplePingableNarrow(obj: CorbaObjectVar): ExamplePingableVar
  {.header: pingc, importcpp: "Example::Pingable::_narrow(@)".}

# I don't yet know how to get C++ exceptions to propagate to Nim, so the raises
# pragma is useless.
proc ping(pingable: ExamplePingableVar)
  {.header: pingc, importcpp: "#->ping(@)", raises: [CorbaTransient].}

var params = os.commandLineParams()
var argc: cint = params.len().cint
var argv: cstringArray = allocCStringArray(params)

try:
  var orb = corbaOrbInit(argc, argv)
  var po = orb.stringToObject("corbaname::nameservice/NameService#test/ExamplePing")
  var pingable = examplePingableNarrow(po)
  pingable.ping()
  orb.destroy()
except CorbaTransient:
  echo("Got an exception!")