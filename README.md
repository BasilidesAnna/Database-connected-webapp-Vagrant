# Database connected webapp with Vagrant

There are two virtual machine in this project. One with the database(postgresql) and one with a query webapplication running on tomcat, connected by environmental variables in the setenv file.

The app avaliable on localhost:8080, but reserved words only works with capital letters.
  
~~select * from artist~~

     SELECT * FROM artist


Tomcat config files can be changed. These files are located in the tomcat_files folder.

The database has an IP address, `192.168.55.35` . You should change it, in the Vagrantfile and in the setenv file also, if there is any problem with it.

This project use the 9.0.41 tomcat version. If you would like to use some newer version, these config files wont work.

**Base requirements:**

 - git (https://git-scm.com/downloads)
 - Vagrant (https://www.vagrantup.com/downloads)
 - Virtualbox (https://www.virtualbox.org/wiki/Downloads)
 - Database sample - https://github.com/lerocha/chinook-database/tree/master/ChinookDatabase/DataSources
