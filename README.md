Simple Vagrant config using a mix of the following resources:

* [Setting up a Hadoop virtual cluster with Vagrant ](http://cscarioni.blogspot.ch/2012/09/setting-up-hadoop-virtual-cluster-with.html)
* [Running Hadoop on Ubuntu Linux (Single-Node Cluster)](http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-single-node-cluster/)

As simple as follow:

    $ vagrant up
    $ vagrant ssh
    $ start-all.sh
    
    # to end it
    $ stop-all.sh
    $ exit

**NB:** it uses Hadoop 0.21.0 (which is old) and is not supported, so don't bother creating any pull requests. Thanks!
