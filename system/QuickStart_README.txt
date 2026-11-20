Multics MR12.8 Quickstart

1. Unzip the contents of the QuickStart ZIP file into a directory on your
system.

2. Build the emulator (dps8) from source or find an executable appropriate 
for your system and place in the QuickStart directory.

3. Execute in a command shell: "./dps8 MR12.8_boot.ini"

4. Once Multics is booted and the answering service is started, in another
command shell, execute the command "telnet localhost 6180".  If you do not have
telnet installed on your system, download and install an appropriate telnet
client.

5. You should be rewarded with a list of channels to which you can connect.
Press <enter> to select the first available channel.

6. You should receive a login prompt that looks similar to this:

   Multics MR12.8: Installation and location (Channel d.h000)
   Load = 5.0 out of 90.0 units: users = 5, 06/09/21  1745.6 pst Thu

7. Login as Repair.SysAdmin using the password "repair". You will need to
specify the "-cpw" control argument to change the password.  Use a login
line such as "l Repair -cpw".

8. You will be prompted for the password ("repair") and then twice to specify
a new password. Once you provide a new password (twice), you should be logged
in.

Customizing Your System

You can generate a script (for use with the emulator, dps8) by first editing the
file "site_setup.sh" to have values appropriate for your system and then running
the command: "./site_setup.sh > configure.ini".

That command will generate an INI file (configure.ini) that you can use for subsequent
boots of your system.  You can invoke it with the command "./dps8 configure.ini".

Note that this scripts takes several minutes to execute and will end by shutting
down your system. Once it is complete, you can reboot your customized system
with the command "./dps8 MR12.8_boot.ini".

Feel free to make a copy of MR12.8_boot.ini and rename it to whatever name you wish,
such as "multics.ini" or "mysite.ini". That way, you can boot your system with
the command "./dps8 multics.ini" or "./dps8 mysite.ini", as appropriate.

Note: You may note, when booting with the MR12.8_boot.ini, a seemingly spurious
"yes" answer to a prompt, as shown below:

  bce (boot) 1802.0: M-> [auto-input] yes
  bce: Unrecognizable request.  Type lr for a list of requests.

You should ignore this, and not try to fix this. Sometimes Multics will ask one
more question here, to which the correct answer is "yes".
