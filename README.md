tracker
=======

TimeOffTracker tracks vacation, sick days, personal time off, deferred days and etc. that have been taken and that are scheduled. It supports multiple 
users, the concept of management, approval forms and has some nice individual and organizational views of time off.

Originally by: Andrew Fuqua

=== Getting Started

INSTALLATION INSTRUCTIONS

Install Ruby and Rails. 
Download TimeOffTracker from RubyForge.
Install other required gems (see below).
Create the configuration files (see below).
Create the database (see below).
Initializing the database (see below).
Create a user (see below).


INSTALL OTHER REQUIRED GEMS

I, uh, don't remember all the gems we need right now. I'll include what I can remember. At the bottom I've included a list of what's installed on my laptop. Some of those aren't
needed though.

In order to get this to work, I had to get rails version 1.2 and set RAILS_GEM_VERSION = ‘1.2.3’ (stored in the config/environment.rb fil) (to the version returned from the command rails -v) 
  gem install rails  
	gem cleanup
	rake rails:update
  
see also http://fora.pragprog.com/rails-recipes/discuss-the-book/post/498

  gem install actionmailer  (actionmailer should be installed already with rails by default)


CREATING THE CONFIGURATION FILES

Under config, use the examples provided to create the 
following config files:
	database.yml
	TimeOffTracker.yml
    environment.rb
    
Under public, use the examples provided to create the 
following files:
	dispatch.cgi
	dispatch.fcgi
	dispatch.rb
	.htaccess
	
Configure the mailer stuff in config/environment.rb if you want to use management_notifier.rb. Set the notifier to :immediate in TimeOffTracker.yml 
to have emails sent immediately upon the creation of each new time off event, or don't set it if you plan on using the management_notifier.rb scheduled job.

	
	
CREATING THE DATABASE

Run db/schema.rb with: 
    set RAILS_ENV=production
	rake db:schema:load


=== Initializing the Database 

= Creating Time Off Types
 
You may create your time off types (Vacation, Sick, Deferred, Personal) yourself, or grab the insert sql statements from migrate/004_create_time_off_types.rb.
Most time off types should NOT be marked as a holiday.

Also, create a Holiday time off type, and mark it as a holiday. Users cannot add their own holidays, but holidays show up on their calendar.


= Creating Day Parts

You may create your day parts (full day, first half, last half) yourself, or grab the insert sql statements from migrate/005_create_day_parts.rb.
I have used '>' in the code field to represent last half and '<' to represent first half, and I've also used the 1/2 ascii character (hold down alt and enter 171 on the numeric keypad).
Use whatever you want.


= Creating Default Time Off Allowances

Just do this through the UI.


=== Creating Users and Logging in

How do I create users? How do you log into this thing?

Logging in as an ldap (Active Directory) user will add you to the database.

Make someone a privileged user (i.e. a manager) by setting his privileged flag to 1 in the database.

You may want to add an ldap user manually (rather than requiring him/her to log in first) if you wish. If he/she is an ldap user, FindLdapUser.rb will help
you find his Active Directory object id and formulate an insert statement for you.

  ruby ./FindLdapUser.rb someUseridToFind MYDOMAIN\myuserid mypassword

You might want to add some test users. The password encrypted here is 
'p' and 't' for these two users.

INSERT INTO `users` VALUES
('puser', 'Priv User', NULL, 1,'pwNb4ak9Xygbk',NULL, NULL, '2007-01-01 15:46:45'),
('tuser', 'Test User', NULL, 0,'pwNSn1rxxmNE6',NULL, NULL, '2007-01-01 15:50:48')
;


=== Management Tips

If your organization requires that employees submit paper-based time off requests, they can use this system to print their time off request.

Managers will probably want to Acknowledge requests through the Summary and Detail view. Once a time of event has been Acknowledged, it can no longer be
edited (unless it is subsequently Unlocked by a manager).

=== Installed GEMS


Here is what is installed on my development laptop and/or in production.
(gem list --local)

*** LOCAL GEMS ***

actionmailer (1.3.4, 1.3.3)
    Service layer for easy email delivery and testing.

actionpack (1.13.4, 1.13.3)
    Web-flow and rendering framework putting the VC in MVC.

actionwebservice (1.2.3)
    Web service support for Action Pack.

activerecord (1.15.3)
    Implements the ActiveRecord pattern for ORM.

activesupport (1.4.3, 1.4.2)
    Support and utility classes used by the Rails framework.

fxri (0.3.3)
    Graphical interface to the RI documentation, with search engine.

fxruby (1.6.1, 1.2.6)
    FXRuby is the Ruby binding to the FOX GUI toolkit.

log4r (1.0.5)
    Log4r is a comprehensive and flexible logging library for Ruby.

mysql (2.7.1)
    A win32-native build of the MySQL API module for Ruby.

rails (1.2.3)
    Web-application framework with template engine, control-flow layer,
    and ORM.

rake (0.7.3)
    Ruby based make-like utility.

ruby-net-ldap (0.0.4)
    A pure Ruby LDAP client library.

sources (0.0.1)
    This package provides download sources for remote gem installation

win32-clipboard (0.4.1)
    A package for interacting with the Windows clipboard

win32-dir (0.3.0)
    Extra constants and methods for the Dir class on Windows.

win32-eventlog (0.4.2)
    Interface for the MS Windows Event Log.

win32-file (0.5.2)
    Extra or redefined methods for the File class on Windows.

win32-file-stat (1.2.2)
    A File::Stat class tailored to MS Windows

win32-process (0.5.1)
    Adds fork, wait, wait2, waitpid, waitpid2 and a special kill method

win32-sapi (0.1.3)
    An interface to the MS SAPI (Sound API) library.

win32-sound (0.4.0)
    A package for playing with sound on Windows.

windows-pr (0.5.3)
    Windows functions and constants predefined via Win32API


You may need these if you choose to run rails in mongrel:
mongrel (0.3.13.3)
    A small fast HTTP library and server that runs Rails, Camping, and
    Nitro apps.
mongrel_service (0.1)
    Mongrel Native Win32 Service Plugin for Rails
    
I have this in production, but I don't remember why. I do seem to remember
having to have it though:
win32-service (0.5.2)
    An interface for MS Windows services    

Here are a couple extra libraries that I have either in development or
in production but not both, so I therefore believe they aren't necessary.
ldap (0.9.7)
    LDAP library for Ruby
ruby-activeldap (0.8.0)
    Ruby/ActiveLdap is a object-oriented API to LDAP



=== RUNNING UNDER MONGREL APP SERVER

Here is an example of how one might run this application under mongrel.

cd C:\timeofftracker-production
mongrel_rails service::install -N TimeOffTracker -c /timeofftracker_production -p 80 -e production
sc config TimeOffTracker start= auto depend= MySql
mongrel_rails service::start -N TimeOffTracker

=== Copyright

Copyright 2007 Andrew Martin Fuqua, http://www.andrewfuqua.com
