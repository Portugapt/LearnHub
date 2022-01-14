# Week 3

- [Week 3](#week-3)
  - [Berkeley Sockets API](#berkeley-sockets-api)
    - [UDP STREAM](#udp-stream)
  - [Digital Transmission Fundamentals](#digital-transmission-fundamentals)
    - [Transmission Delay](#transmission-delay)
  - [Practice Quiz](#practice-quiz)
  - [Quiz 2: Socket API & Digital Transmissions](#quiz-2-socket-api--digital-transmissions)

## Berkeley Sockets API

What is Berkeley Socket API?

![bsapi](https://i.imgur.com/9ox4EQ0.png)

Applications create sockets in a write or read to or from sockets. Note there are other popular socket interface. For example, Winsock in Microsoft Windows environment. The figure shows how two applications talk to each other across the communication networks through the socket interface. In a typical scenario, one application operates as a server, while the other as a client. As you tell from the figure, sockets are kernel space resources while their interface accessible by descriptor are in user space.

![bsapi2](https://i.imgur.com/sVRQKqV.png)

That's two modes of services available through the circuit interface, connection-oriented and connection-less. In connection-oriented mode, an application must first establish a connection. Then, data will be delivered through the connection to the destination in sequenced transfer of byte strings. Note, no boundaries preserve the transfer, so a programmer has to pay attention to it when developing client server applications.
The connectionless mode doesn't have connection setup overhead. It provides best effort of service. The mode does immediate transfer of one block of information where message boundaries are preserved in transfer. But please note the message may be possibly out of order when received. Even worse, there is possible loss of a message. So a programmer needs to take care of retransmission and ordering if those features are really important. 
![streamodes](https://i.imgur.com/idnaqWf.png)

![clientserver](https://i.imgur.com/C7cbvI7.png)

![APIprimitives](https://i.imgur.com/suoycjr.png)

The figure shows a typical diagram of the sequence of sockets calls for connection-oriented mode. The server begins by carrying out a passive open as follows. The **socket** called creates a socket specifying TCP stream pipe. The type is sock online stream. It returns a socket descriptor and the integer number if the call is successful.  
The **bind** call binds the well-known port number, as well as the local IP address of the server to the socket descriptor. Note that it could wipe out IP address for multiple net interface.  
The **listen** call turns the socket into a listening socket that can accept incoming connections from clients. There is a parameter in the call that specifies the maximum number of requests that may be queued while waiting for server to accept them.  
The server calls **accept** to accept incoming requests. Accept blocks if queue is empty. The client side active open, it creates a circuit to connect to the server. Client calls connect and attempts to establish a connection to their local socket, which is specified to the specified remote address upon number.  
This indeed initiates a three-way handshaking process for connection build up according to the TCP protocol. The three-way handshaking process will be covered in a later course.
When the TCP connection is established, acceptor function under the server wakes up and returns a new socket descriptor for the given connection. That is specified by the source app IP address, source port number, destination IP address, and destination port number. Note that a client on a server will use a new socket for track data transfer, while the original socket at the server side continues to listen for new connection requests from a client.
For data transfer client or server pulls write function to transmit the data into the connected socket. Write function call if successful returns a number of bytes transferred, it is a blocking call until all data are transferred. Client on this server calls real function to receive data from the connected socket. The call returns number of bytes read. It is a broken call if no data arrives. Client or server cause close function to close out the TCP connection.

![socketcalls](https://i.imgur.com/m4tHNZD.png)

At the client side, it knows server name but another is IP address. Client use a name to address conversion function gethostbyname. The client establishes a connection on a socket by calling connect.It also does repeated calls to read until all data has been received. 

### UDP STREAM
![udpstream](https://i.imgur.com/KpgDezY.png)

![udp2](https://i.imgur.com/NKkrPny.png)

For example, if the reply from the server doesn't reach the client, the client will wait forever. In this case, the client must provide a timeout mechanism and retransmit the message. Also, further reliability may be provided to reorder the datagrams at the receiver and to ensure that the duplicated datagrams are discarded. We will learn reliable communication protocols in future lessons.

## Digital Transmission Fundamentals

![interests](https://i.imgur.com/hpQU34L.png)

### Transmission Delay

Transmission delay = packet length / transmission rate

![td1](https://i.imgur.com/K1q4rel.png)

The transmission delay is determined by the size of message L, over the bandwidth of the transmission system R in bits per second. The overall delay is the sum of propagation delay and the transmission delay. To reduce L, we use data compression technique. To increase R, we use higher bandwidth modem. To reduce d, we place server closer to users.

![td2](https://i.imgur.com/KsesGMx.png)


![compression1](https://i.imgur.com/9Z7hOXN.png)

![transmission](https://i.imgur.com/ZQnGWFw.png)

![impairments](https://i.imgur.com/SYK8BVa.png)

A regenerator is like the first time transmission. Required for long distance distances.

![fiber](https://i.imgur.com/RsdpuQe.png)

![fiberquality](https://i.imgur.com/McDPzEN.png)

## Practice Quiz

**Q1**

Which of the following applications would you select TCP protocol for? 

- [ ] File transfer
- [ ] Web Browsing


  -----

**Q2**  

In BSD socket API, which type of socket is used to create a TCP socket?

- SOCK_STREAM

  -----

Q3

In BSD socket API, which type of socket is used to create a UDP socket?

- SOCK_DGRAM

  -----

Q4

In BSD socket 	API, which system call is used to assign a network address to the socket?

> The bind call binds the well-known port number, as well as the local IP address of the server to the socket descriptor. Note that it could wipe out IP address for multiple net interface.

- bind()

  -----

Q5

In BSD socket API, if a client knows the server name but not server’s network address, what system call should the client use to get server’s network address?

- gethostbyname()

  -----

Q6

In a transmission system, which of the following statement is true for a receiver

- [X] Receives energy from medium
- [X] Converts received signal into a form suitable for delivery to user
- [ ] Converts information into signal suitable for transmission
- [ ] All of the above

  -----

Q7

In digital transmission, long distance digital communications require the use of a generator to recover original data sequence and re-transmits on next segment

- True

  -----

Q8

In twisted pair, a category 5 UTP cable can support a data rate of up to 16MHz

- False

  -----

Q9

Which of the following statement is true for optical fiber

- [ ] Plentiful bandwidth for new services
- [ ] Dominates long distance transmission
- [ ] Distance less of a cost factor in communications
- [X] All of the above

  -----

Q10

Which of the following are advantages of optical fiber

- [X] Noise immunity
- [X] No corrosion

## Quiz 2: Socket API & Digital Transmissions

Q1

In BSD socket API, which call is usually used for transmitting data in the connectionless mode?

- sendto()

  -----

Q2

Which of following statement about TCP/UDP sockets is wrong?

- TCP is faster than UDP

  -----

Q3

Which of following are commonly used as digital communication medium?

- [ ] Twisted pair
- [ ] Optical fiber
- [ ] Coaxial cable
- [X] All of the above

  -----

Q4

Consider a network link that has distance of 100 meters, and signal traverses at the speed of light in cable 2.5 x 10^8 meters per second. The link has transmission bandwidth of 100 megabits/second (100 x 10^6 bits per second). The packet size is 400 bits. What is the signal propagation delay? 

$100/(2.5*10^8) + 400/(100*10^6)$

0.00000433333

Propagation delay:  
$100/(2.5*10^8) = 4e-7$

- 4 x 10^-7 seconds

  -----

Q5

Consider a network link that has distance of 100 meters, and signal traverses at the speed of light in cable 2.5 x 10^8 meters per second. The link has transmission bandwidth of 100 megabits/second (100 x 10^6 bits per second). The packet size is 400 bits.  What is the packet transmission delay?

Transmission delay:  
$400/(100*10^6) = 0.000004$

- 4 x 10^-6 seconds

  -----

Q6

An API allows application programs to access certain resources through a predefined interface?

- True

  -----

Q7

In transport protocol, which of the following statements is true for User Datagram Protocol

- [ ] It enables best-effort connectionless reliable transfer of a stream of bytes
- [X] It enables best-effort connectionless transfer of individual block of information

  -----

Q8

Which of the following sentences are true for connectionless stream mode of service

- [ ] Multiple write/read between peer processes
- [X] No setup overhead and delay
- [X] Send/receive to/from multiple peer processes
- [X] Destination address with each block

  -----

Q9

In transmission delay, in order to reduce the number of bits in a message we use data compression

- True

  -----

Q10

Which of the following is true of data compression algorithms

- [X] Recover information approximately
- [X] Recover original information exactly
- [X] Represent the information using fewer bits
- [ ] Modify data headers