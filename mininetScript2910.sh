#!/usr/bin/python

"""

"""
from mininet.net import Mininet
from mininet.node import Controller, RemoteController, OVSKernelSwitch
from mininet.cli import CLI
from mininet.log import setLogLevel
from mininet.link import Link, TCLink

def topology():
    "Create a network."
    net = Mininet( controller=RemoteController, link=TCLink, switch=OVSKernelSwitch )

    print "*** Creating nodes"
    h1 = net.addHost( 'h1', mac='00:00:00:00:00:01', ip='192.168.100.1/24' )
    h2 = net.addHost( 'h2', mac='00:00:00:00:00:02', ip='192.168.200.1/24' )
    h3 = net.addHost( 'h3', mac='00:00:00:00:00:03', ip='192.168.100.2/24' )
    h4 = net.addHost( 'h4', mac='00:00:00:00:00:04', ip='192.168.200.2/24' )
    s5 = net.addSwitch( 's5', mac='00:00:00:00:00:05')
    s6 = net.addSwitch( 's6', mac='00:00:00:00:00:06')
    c7 = net.addController( 'c7', controller=RemoteController, ip='127.0.0.1', port=6633)

    print "*** Creating links"
    net.addLink(h4, s6, 0, 3)
    net.addLink(h3, s6, 0, 2)
    net.addLink(s5, s6, 3, 1)
    net.addLink(h2, s5, 0, 2)
    net.addLink(h1, s5, 0, 1)

    print "*** Starting network"
    net.build()
    s6.start( [c7] )
    s5.start( [c7] )
    c7.start()

    print "*** Running CLI"
    CLI( net )

    print "*** Stopping network"
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    topology()

