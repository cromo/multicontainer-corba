{.compile: "Ping-common.c"}
{.compile: "Ping-stubs.c"}

import os

const
  orbith = "orbit/orbit.h"
  cosnamingh = "ORBitservices/CosNaming.h"
  pingh = "/source/Ping.h"
  CorbaNoException = 0

type
  CorbaEnvironmentObj {.final, header: orbith, importc: "CORBA_Environment".} = object
    id {.importc: "_id".}: cstring
    major {.importc: "_major".}: cint
  CorbaEnvironment = ptr CorbaEnvironmentObj
  CorbaOrb {.final, header: orbith, importc: "CORBA_ORB".} = object
  CorbaObject {.final, header: orbith, importc: "CORBA_Object".} = object
  NamingContext {.final, header: cosnamingh, importc: "CosNaming_NamingContext".} = object
  NameComponent {.final, header: cosnamingh, importc: "CosNaming_NameComponent".} = object
    id {.importc: "id".}: cstring
    kind {.importc: "kind".}: cstring
  Name {.final, header: cosnamingh, importc: "CosNaming_Name".} = object
    maximum {.importc: "_maximum".}: cuint
    length {.importc: "_length".}: cuint
    buffer {.importc: "_buffer".}: ptr NameComponent
    release {.importc: "_release".}: cint
  ExamplePingable {.final, header: pingh, importc: "Example_Pingable".} = object

proc exceptionInit(ev: CorbaEnvironment)
  {.header: orbith, importc: "CORBA_exception_init".}

proc exceptionId(ev: CorbaEnvironment): cstring
  {.header: orbith, importc: "CORBA_exception_id".}

proc freeException(ev: CorbaEnvironment)
  {.header: orbith, importc: "CORBA_exception_free".}

proc corbaOrbInit(argc: ptr cint, argv: cstringArray, name: cstring, ev: CorbaEnvironment): CorbaOrb
  {.header: orbith, importc: "CORBA_ORB_init".}

proc orbInit(ev: CorbaEnvironment, args: seq[string], name: string): CorbaOrb =
  var
    argc = args.len().cint
    argv = args.allocCStringArray
  return corbaOrbInit(addr argc, argv, name, ev)

proc stringToObject(orb: CorbaOrb, uri: cstring, ev: CorbaEnvironment): CorbaObject
  {.header: orbith, importc: "CORBA_ORB_string_to_object".}

proc resolve(ns: NamingContext, name: ptr Name, ev: CorbaEnvironment): CorbaObject
  {.header: cosnamingh, importc: "CosNaming_NamingContext_resolve".}

proc ping(pingable: ExamplePingable, ev: CorbaEnvironment)
  {.header: pingh, importc: "Example_Pingable_ping".}

proc releaseObject(obj: CorbaObject, ev: CorbaEnvironment)
  {.header: orbith, importc: "CORBA_Object_release".}

proc destroy(orb: CorbaOrb, ev: CorbaEnvironment)
  {.header: orbith, importc: "CORBA_ORB_destroy".}

proc raisedException(ev: CorbaEnvironment): bool =
  return ev.major != CorbaNoException

proc abortIfException(ev: CorbaEnvironment, message: string) =
  if ev.raisedException:
    echo(message, ev.exceptionId)
    ev.freeException
    quit(QuitFailure)

var
  evo: CorbaEnvironmentObj
  ev = addr evo
ev.exceptionInit
ev.abortIfException("Failed to initialize exception")

var orb = ev.orbInit(os.commandLineParams(), "orb")
ev.abortIfException("Failed to initialize ORB")

var ns = cast[NamingContext](orb.stringToObject("corbaloc::nameservice:2809/NameService", ev))
ev.abortIfException("Failed to convert string to object reference")

var
  path: array[0..1, NameComponent] = [NameComponent(id: "test", kind: ""), NameComponent(id: "ExamplePing", kind: "")]
  name = Name(maximum: 2, length: 2, buffer: cast[ptr NameComponent](addr path), release: 0)
  service = cast[ExamplePingable](ns.resolve(addr name, ev))
ev.abortIfException("Failed to resolve object")

service.ping(ev)
ev.abortIfException("Failed to call ping")

cast[CorbaObject](service).releaseObject(ev)
ev.abortIfException("Failed to release pingable")

orb.destroy(ev)
ev.abortIfException("Failed to destroy orb")