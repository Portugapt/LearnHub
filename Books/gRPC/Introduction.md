# gRPC

[Link](https://grpc.io/docs/what-is-grpc/introduction/)

In gRPC, a client application can directly call a method on a server application on a different machine as if it were a local object, making it easier for you to create distributed applications and services.

stub ~ client 

gRPC clients and servers can run and talk to each other in a variety of environments - from servers inside Google to your own desktop - and can be written in any of gRPC’s supported languages.

----

Define the structure for the data you want to serialize in a proto file.
File with `.proto` extension.

Protocol buffer data is structured as messages, where each message is a small logical record of information containing a series of name-value pairs called fields.

```
message Person {
  string name = 1;
  int32 id = 2;
  bool has_ponycopter = 3;
}
```

compiler `protoc` to provide simple accessors for each field, like `name()` and `set_name()`, as well as methods to serialize/parse the whole structure to/from raw bytes.

You define gRPC services in ordinary proto files, with RPC method parameters and return types specified as **protocol buffer messages**:

```
// The greeter service definition.
service Greeter {
  // Sends a greeting
  rpc SayHello (HelloRequest) returns (HelloReply) {}
}

// The request message containing the user's name.
message HelloRequest {
  string name = 1;
}

// The response message containing the greetings
message HelloReply {
  string message = 1;
}
```


