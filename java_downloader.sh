#! /bin/bash

#check if pet-clinic user already exist else create it
pet_pass=1234
id -u "pet-clinic" 2> /dev/null
if [[ `echo $?` == 0 ]]; then
echo "this user is already exist"
else
sudo useradd -m -d /home/pet-clinic -c "pet clinic" -s /bin/bash  pet-clinic
echo -e "$pet_pass\n$pet_pass"|sudo passwd pet-clinic
sudo usermod -aG sudo pet-clinic
#sudo chmod 777 /home/pet-clinic
#sudo chmod 777  /home/pet-clinic/.bashrc
fi

#switch to the created user
su pet-clinic <<EOF
$pet_pass
cd /home/pet-clinic
if [[ -e /home/pet-clinic/openjdk-18_linux-x64_bin.tar.gz ]]; then
echo "Java is already installed in pet-clinic user"
exit
else
curl -O https://download.java.net/java/GA/jdk18/43f95e8614114aeaa8e8a5fcf20a682d/36/GPL/openjdk-18_linux-x64_bin.tar.gz
#cp ./openjdk-18_linux-x64_bin.tar.gz  /home/pet-clinic
tar -xvf /home/pet-clinic/openjdk-18_linux-x64_bin.tar.gz
echo JAVA_HOME="/home/pet-clinic/jdk-18" >> ./.profile
echo PATH="/home/pet-clinic/jdk-18/bin:$PATH" >> ./.profile
echo JAVA_HOME="/home/pet-clinic/jdk-18" >> ./.bashrc
echo PATH="/home/pet-clinic/jdk-18/bin:$PATH" >> ./.bashrc
fi
git clone https://github.com/spring-projects/spring-petclinic.git
EOF

