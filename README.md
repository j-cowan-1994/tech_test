# tech_test

•	Deploy an t2.micro EC2 instance using your preferred Linux OS using your preferred deployment method. If you are using any IaC tooling please include this config in your git repo. 
    Created t2.micro EC2 instance using Terraform.

•	Log into the terminal for the host and secure the node to the following minimum standards – Modify the default SSH port, disable root login, set up a standard user with full sudo privileges.
    Created a cloud-int script which will be ran on boot via Terraform. The script will:
    - Update SSH port to 2222
    - Ensure root login is disabled
    - Create a new user which can authenticate with a SSH Key rather than password
    - Extra security features which could be done are, remove the generic centos user and only allow SSH auth via SSH key 
•	Write a script in your preferred language that monitors diskspace usage on the main filesystem of the host, i.e “ / “ – the script should record the amount of free disk space a timestamp, and write it out to a log file named /var/log/freespace – ensure the log file does not get overwritten each time the script runs
    Created a basic script which will check the aviable disk space and pass it to a log. 
    Create a cron jon which will run the script every 5 mins

•	Configure an external repo and install netdata
    All installed via the bootstrap script - http://35.176.131.181:19999/#;after=-540;before=0;theme=slate

•	Install nginx either directly on the EC2 or if you prefer, deploy docker and run nginx as a container. It should show a simple HTTP page containing “Hello, Sky” which you should be able to reach on the EC2 node by running the command
curl -Lv http://localhost/hellosky.htm on the local command line
    All done via the bootstrap script - http://35.176.131.181/hellosky.html 
•	Export your configured EC2 instance as an Amazon Machine Image (AMI) and share it publicly, named in the README so we can pull it down and review. NOTE ensure nginx and any other services you configured will start on Boot, rather than having to be started manually.
    Stored in our private AMI - ami-06bbc21aa940410b3
