# email-ups-report
A FreeBSD shell script to email a UPS report, for use on a FreeNAS server.

A simmple shell script which will email you a report regarding your UPS.  The UPS needs to have been correctly configured and connected to the server for this wot work.

You just need to create a crom task to execute this script.  

You need to ensure you have updated the following two variables for the script to work.

Your email address (email)
The configured name of the UPS (ups)
