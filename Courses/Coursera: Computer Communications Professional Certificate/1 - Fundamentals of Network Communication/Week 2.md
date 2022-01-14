# Week 2

- [Week 2](#week-2)
  - [Layered Architecture and OSI Model](#layered-architecture-and-osi-model)
  - [OSI Unified View](#osi-unified-view)
    - [Contextless](#contextless)
  - [TCP/IP: Architecture and Routing Examples](#tcpip-architecture-and-routing-examples)
  - [Quiz 1: Layered Architecture](#quiz-1-layered-architecture)
  - [Quiz 2: Layered Architecture](#quiz-2-layered-architecture)

## Layered Architecture and OSI Model

![img1](https://i.imgur.com/eg6S093.png)

For a network node, it only has at lowest three layers.
The network and data link layers involve interaction of peer to peer process across a single hop. 

![whylayers](https://i.imgur.com/1U168Js.png)

![physicallayer](https://i.imgur.com/4eeSYhX.png)

Physical layer deals with the transmit of bits of our communication channel. Such as uncoupled wire pairs. The layer is concerned now with a particular choice of system parameters. It also is concerned with the procedures to set up and release the connection as well as mechanical aspects.

![datalayer](https://i.imgur.com/sw0C6hj.png)

The data link layer provides for the transfer of block of information called the frames across our transmission link that directly connects to nodes. It will insert framing information into the sequence of transmitted bits to indicate the boundary of the frames.

Please note that our link includes the case where multiple nodes are connected to a broadcast medium, such as our local area network, LAN. Therefore, a media access control procedure is required to coordinate the access to the broadcast medium.

![networklayer](https://i.imgur.com/RJEbj6A.png)

Another key aspect in that network codes jointly execute routing algorithms to determine the routing paths across the network. By routing protocol we mean the procedure to select paths across a network. This function makes network layer as the most complex in the reference model. The network layer is also responsible for congestion control to deal with temporary surges in packet to traffic from time to time.

![internetworking](https://i.imgur.com/SjHwrSd.png)

In the networking is a part of network layer that provides transfer of package between gateway routers that are connected to intermediate network, as shown in the figure.


![transportlayer](https://i.imgur.com/U0CbNGU.png)

Transport layer is responsible for the end to end transfer of messages from the process in a source machine to a process In the destination machine.

Both UDP and TCP are transport layers.

![applayer](https://i.imgur.com/Wb5RGYL.png)

Application layer is to provide services that are frequently required by applications that involve communication, for example, HTTP protocol, domain name service, file transfer, email and other applications.

## OSI Unified View

![OSI1](https://i.imgur.com/N2DXirC.png)

Layer n in one machine interacts with layer n in another machine to provide a service to its upper layer n+1.

![PDUs](https://i.imgur.com/YUIj44Z.png)

![services](https://i.imgur.com/RSyalZB.png)

Point 4 is most important.

![SDUs](https://i.imgur.com/W4tUgy1.png)

The figure illustrates the layered services in which SDUs are exchanged between layers while PDUs are exchanged within a layer. For more illustrations, readers may refer to the example of HTTP used in TCP service in the lesson of examples of protocol and services.

![sdu2](https://1.bp.blogspot.com/_mAJDMuyu_WI/SjflV44wkOI/AAAAAAAABmw/MstS1fm8QtA/s640/osipdusdu.png)

![encapsulation](https://i.imgur.com/f1HWv77.png)


The figure shows the headers and the trailers that are added as a block of information data works its way down the seven layers. A header of protocol carries information such as addresses, sequence number, flag bits, lengths, and so on.

![headers](https://i.imgur.com/gyBZw6K.png)

![bandwidth](https://i.imgur.com/nFQv13g.png)

$$ \frac{APPDATA}{APP DATA + HEADERS + CRC}  $$

Reminder: CRC = [Cyclic Redundancy check](https://en.wikipedia.org/wiki/Cyclic_redundancy_check)

![encapsulationofheaders](https://i.imgur.com/FrAA9qS.png)

### Contextless

![segmentation](https://i.imgur.com/x2KEjj6.png)

https://avinetworks.com/glossary/packet-switching/

![packetswitching](https://i.imgur.com/7iM0kAn.png)

The transport layer provides two protocols on top of IP to enable process-to-process communications. TCP provides reliable stream service. And UDP provides best-effort user datagram service. Application layer protocols such as HTTP and SMTP operate over TCP. Application layer protocols such as DNS and RTP operate over UDP.
Both TCP and UDP operate over IP, the Internet routing protocol. That provides best-effort connectionless packet transfer. All higher-layer protocols access a network interface through IP. This feature provides the capability to operate over multiple different networks.
IP layer handles the transfer of information across multiple networks through the use of routers. It provides a single service, best-effort connectionless packet transfer. It provides no mechanism for **error recovery or flow control**.

![ipapproach](https://i.imgur.com/u07Jfjd.png)

## TCP/IP: Architecture and Routing Examples

![tcpip](https://i.imgur.com/mZfth6h.png)

What is meant by connectionless protocol?

My answer:  
Packet divided and individually routed. Each of these packets has the source, destination and the number of packets. But it means that each packet is routed differently and dynamically according to the current network status.  
Correct: The IP protocol is a connectionless protocol. Every packet is independent and has no relationship to any other packet.

How are errors detected in IP?  
My Answer:  
Using CRC, Cyclic Redundancy Checks. Each packet has a CRC attached, and it's calculated and compared at the end-point, to confirm no data was lost.  
Correct: The error detection method used by IP is the checksum.

![internetaddress](https://i.imgur.com/BUf4uJs.png)

On a LAN, the network interface card is identified by a physical address. The network use its own address to transfer packets or frames to the appropriate destination. IP address needs to be resolved to a physical address at each IP network interface, by address resolution protocol, called ARP. Ethernet use 48-bit addresses. Each network interface card has globally unique physical MAC address. Let's consider a routing example as shown in the figure. We assume that Ethernet has a network ID 1. And the point-to-point link has a net ID 2. In the Ethernet, we suppose the server has IP address 1 and 1. And the workstation has IP address 1, 2. The routing has IP address 1, 3. In the point-to-point link, the PC has IP address 2, 2. And the router has address 2, 1.

![Physicaladdress](https://i.imgur.com/KIQxqwE.png)

The Point-to-Point Protocol (PPP) was designed for users who need a reliable point-to-point connection to the Internet. PPP operates at the physical and data link layers of the OSI model.

![exampleppp](https://i.imgur.com/Rd7ICfI.png)

The IP packet at workstation has IP address and the server IP address in IP packet header. The IP entity in the workstation looks at its routing table and finds that the server is directly connected to the same network, with the physical address s. The IP packet, that's encapsulated in Ethernet frame with address w and s. The header also contains a protocol type field that is set to a value corresponding to IP. The Ethernet frame is then broadcasted over the LAN. The server's network interface card recognize that a frame is intended for its host. So it captures the frame and examine it. It finds the protocol type field is set to IP. And it therefore passes IP packet up to the IP entity. The communication from the workstation to the server is completed.

![exampleppp2](https://i.imgur.com/WItaWeX.png)

![exampleppp3](https://i.imgur.com/1opWUVy.png)

An example from Server to PC (Outside lan network)

Now consider a case that a server wants to send an IP packet to PC. The PC is connected to the router by a point-to-point link that runs PPP as a data link control. And the IP addresses on either side of the link were negotiated when the link was set up.

![ex2](https://i.imgur.com/Q3vKWRQ.png)

IP table at server indicates packet shouldn't be sent to the default router, because the destination is not in the server's LAN. So the IP packet is encapsulated with the source address s and destination address r. The Ethernet frame is broadcasted by server's network interface card and captured by router's network interface card. Router's network interface card exams the protocol type field, and it delivers packet to its IP layer. Its IP layer exams IP packet destination address and determines IP packet should be routed to network address 2, 2. Router's table indicates 2, 2 is directly connected via PPP link.
![ex3](https://i.imgur.com/IbYXeI0.png)

## Quiz 1: Layered Architecture

Q1

Which OSI layer is responsible for providing end-to-end communication with reliable service?

- Transport layer

------
Q2

Which OSI layer is responsible for dividing the transmitted bit stream into frames?

- Transport layer - It does segmentation and reassembly? WRONG
- Network layer - Incorrect. The network layer controls the operation of the subnet, deciding which physical path the data should take based on network conditions, priority of service, and other factors
- Application layer Incorrect. The application layer serves as the window for users and application processes to access network services
- Data link layer

------
Q3

Which OSI layer is responsible for determining which route through the network to use?

- Network layer

------
Q4

Which feature does  the data link layer and transport layer have in common?

- Medium access control WRONG
- Flow control - Both layers can provide flow control

------
Q5

Which protocol glues the network of networks together as the Internet? 

- [ ] TCP
- [ ] UDP
- [X] IP
- [ ] None of the above

## Quiz 2: Layered Architecture

Q1

In a LAN, which address is used to transfer frames to appropriate destination?

- Physical address

------

Q2

Suppose an application layer entity wants to send an L-byte message to its peer process, using an existing TCP connection. The TCP segment consists of the message plus 20 bytes of header. The segment is encapsulated into an IP packet that has an additional 20 bytes of header. The IP packet in turn goes inside an Ethernet frame that has 18 bytes of header and trailer. What is the bandwidth utilization in terms of the percentage of the transmitted bits in the physical layer corresponds to message information if L = 500 bytes?

- 90% ( 500 / (500+20+20+18))

------

Q3

Of the following services, which service(s) does the IP layer provides?

- [ ] Error Control
- [ ] FLow Control
- [ ] Connection-based data transfer
- [x] None of the above - Correct. Services provided by IP layer are addressing, fragmenting, packet timeouts

------

Q4

Which of the following is true about the ways in which the OSI reference model and TCP/IP reference model differ.


- [ ] TCP/IP model does not have presentation layer, but OSI model has
- [ ] They differ in the number of layers
- [ ] TCP/IP model does not have session layer, but OSI model has
- [X] All of the above

------

Q5

Which of following statements is true about how the data link layer and transport layer differ? 

- Data link layer is concerned with framing and the transport layer is not

Correct. Transport layer is not concerned with framing rather it uses segment for TCP and datagram for UDP.

------

Q6

This layer is an addition to OSI model

- Presentation layer and Session layer

------

Q7

The functionalities of presentation layer includes

- [ ] Data compression
- [ ] Data encryption
- [ ] Data decryption
- [X] All of the above

Correct. All of the mentioned are functionalities of presentation layer "page 45 of Computer Networks by Tanenbaum and Wetherall" 5th Edition