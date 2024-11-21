# Esquema de nomenclatura
--
Formato: <obj>-<environment>-<purpose>-<name>
Example:  cm-prd-web-atlas 



Kubernetes Objects
cm - ConfigMap
hp - Host Provisioner
pd - Pod
sv - Service
vl - Volume
vc - Volume Claim
sc - Storage Class

Specify Environment
dev – Development
tst – Testing
hom – Staging
prd – Production

Specify Purpose
app - Application Server (non-web)
bkp - Backup Server
cdb	- Clickhouse Database
cfg - Configuration Management (puppet/ansible/etc.)
dns - Name Server
fir - Firewall
ftp - SFTP server
kfk - Kafka Server
mon - Monitoring Server (nagios, sensu, etc.)
mta - Mail Server
lbx - Proxy/Load Balancer (software)
mgo - Mongo Database
red - Redis Database
sql - Database Server ()
ssh - SSH Jump/Bastion Host
sto - Storage Server
vcs - Version Control Software Server (Git/SVN/CVS/etc.)
vmm - Virtual Machine Manager
vpn - VPN Appliance
web - Nginx / PHP / Python 
kub - Kubernetes Control Host
